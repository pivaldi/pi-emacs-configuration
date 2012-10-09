;; Copyright (c) 2007, Philippe Ivaldi.
;; Version: $Id: pi-meta.el,v 0.0 2007/07/04 18:58:36 Philippe Ivaldi Exp $

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.

;; Commentary:

;; This package provide:
;;   * a basic configuration for `meta-mode';
;;   * useful keys binding, C-c C-c to compile or view the output (even on Windows OS)
;;     and C-c C-p (only available on unix-like systems) to create
;;     a Beamer animation with all the picture contained in the Metapost code.

;; THANKS:

;; BUGS:

;; INSTALLATION an update
;; http://piprim.tuxfamily.org/emacs/pi-meta/index.html

;; Code:

(load "pi-tempo-meta")

(defvar running-unix-p (not (string-match "windows-nt\\|ms-dos" (symbol-name system-type))))
(defvar pi-meta-last-compilation-code -1
  "Internal use. Don't set in any fashion.")

(defcustom pi-meta-tex-preamble
  "
\\documentclass{minimal}
\\usepackage[latin1]{inputenc}
\\usepackage{graphicx}
%\\graphicspath{}
\\usepackage{ifpdf}
\\ifpdf \\DeclareGraphicsRule{*}{mps}{*}{} \\fi
\\begin{document}
"
  "Preamble to generate a temporary TeX file embedding a Metapost piscture."
  :type 'string
  :group 'pi-meta)

(defcustom pi-meta-output-format t
  "Format to view the Metapost output
t means output as eps, nil means output as pdf."
  :type '(choice (const :tag "eps" t)
                  (const :tag "pdf" nil))
  :group 'pi-meta)

(defcustom pi-meta-ps-view-command
  "gv"
  "Command to view a PostScript file.
Only used on unix-like systems."
  :type 'string
  :group 'pi-meta)

(defcustom pi-meta-pdf-view-command
  "xpdf"
  "Command to view a pdf file.
Only used on unix-like systems."
  :type 'string
  :group 'pi-meta)

(defcustom pi-meta-mp-command
  "mpost"
  "Command to compile a Metapost file."
  :type 'string
  :group 'pi-meta)

(defun pi-meta-compilation-wait(&optional close)
  "Wait for process in *meta-compilation* exits."
  (let* ((buff (get-buffer "*meta-compilation*"))
         (comp-proc (get-buffer-process buff)))
    (while (and comp-proc
                (not (eq (process-status comp-proc) 'exit)))
      (setq comp-proc (get-buffer-process buff))
      (sit-for 1)
      (message "Waiting process...") ;; need message in Windows system
      )
    (message "") ;; Erase previous message.
    (setq pi-meta-last-compilation-code (process-exit-status comp-proc))
    (when (and close (zerop pi-meta-last-compilation-code))
      (delete-windows-on buff)
      (kill-buffer buff))))


(defun pi-meta-internal-compile (command &optional close)
  "Execute command."
  (setq pi-meta-last-compilation-code -1)
  (let* ((compilation-buffer-name-function
          (lambda (mj) "*meta-compilation*")))
    (compile command))
  (pi-meta-compilation-wait close))


(defun pi-meta-tex-file-name(numfig)
  "Get a temp file name for printing."
  (concat "mp-tex-"
          (file-name-sans-extension
           (file-name-nondirectory buffer-file-name))
          "-" numfig))

(defun pi-meta-open-file(Filename)
  "Open the ps or pdf file Filename.
In unix-like system the variables `pi-meta-ps-view-command' and
`pi-meta-pdf-view-command' are used.
In Windows the associated system file type is used instead."
  (let ((command
         (if running-unix-p
             (let ((ext (file-name-extension Filename)))
               (cond
                ((string-match ext "ps\\|eps") pi-meta-ps-view-command)
                ((string= ext "pdf") pi-meta-pdf-view-command)
                (t (error "Extension Not Supported."))))
           (file-name-nondirectory Filename))))
    (if running-unix-p
        (start-process "" nil command Filename)
      (call-process-shell-command command nil 0))))


(defun pi-meta-compile-view (numfig)
  "Compile and view a Metapost file."
  (interactive "sNumber of the figure (default=0) : ")
  (when (buffer-modified-p) (save-buffer))
  (let* ((numfig (if (string= numfig "") "0" numfig))
         (file (pi-meta-tex-file-name numfig))
         (filet (concat file ".tex"))
         (filems (file-name-sans-extension
                  (file-name-nondirectory buffer-file-name)))
         (fileo (concat file
                        (if pi-meta-output-format
                            ".eps" ".pdf")))
         (filem (concat filems ".mp")))
    (if (file-newer-than-file-p filem fileo)
        (progn
          (pi-meta-internal-compile
           (concat pi-meta-mp-command " " filem))
          (when (zerop pi-meta-last-compilation-code)
            (write-region
             (concat pi-meta-tex-preamble
                     "\n\\includegraphics{"
                     filems
                     "." numfig "}"
                     "\n\\end{document}")
             nil filet)
            (if pi-meta-output-format ;; output eps
                (progn
                  (pi-meta-internal-compile
                   (concat "latex -halt-on-error " file))
                  (when (zerop pi-meta-last-compilation-code)
                    (pi-meta-internal-compile
                     (concat "dvips -R0 -E " file ".dvi -o " fileo) t)))
              (pi-meta-internal-compile
               (concat "pdflatex -halt-on-error " file) t))))
      (setq pi-meta-last-compilation-code 0))
    (if (zerop pi-meta-last-compilation-code)
      (pi-meta-open-file fileo)
      (message (concat "Compilation exited abnormally with code "
                       (number-to-string pi-meta-last-compilation-code))))))

(when running-unix-p
  (defcustom pi-meta-anime-script "~/bin/pi-anime-meta.sh"
    "* Script to create an animation with Bearmer of all the pictures contained in the Metapost code."
    :type 'string
    :group 'pi-meta))

(when (locate-library "meta-mode")
  (autoload 'metafont-mode "meta-mode" "Metafont editing mode." t)
  (autoload 'metapost-mode "meta-mode" "MetaPost editing mode." t)
  ;; extension .mf -> metafont-mode
  ;; extension .mp -> metapost-mode
  (setq auto-mode-alist
        (append '(("\\.mf\\'" . metafont-mode)
                  ("\\.mp\\'" . metapost-mode)) auto-mode-alist))

  (eval-after-load "meta-mode"
    '(progn
       (when running-unix-p
         (defun pi-meta-anime-pdf()
           "* Create an animation with Beamer of all the pictures contained in the Metapost code."
           (interactive)
           (let ((compile-command
                  (concat pi-meta-anime-script
                          " " (file-name-sans-extension (buffer-file-name)))))
             (when (buffer-modified-p) (save-buffer))
             (compile compile-command))))))

  (add-hook 'metapost-mode-hook
            (lambda ()
              (when running-unix-p
                (define-key meta-mode-map  [(control c) (control p)] 'pi-meta-anime-pdf))
              (define-key meta-mode-map  [(control c) (control c)] 'pi-meta-compile-view)
              ;; Fabrication automatique des pairs.
              (when pi-use-skeleton-pair-insert-maybe
                (define-key meta-mode-map "\"" 'skeleton-pair-insert-maybe)
                (define-key meta-mode-map "\{" 'skeleton-pair-insert-maybe)
                (define-key meta-mode-map "\[" 'skeleton-pair-insert-maybe)
                (define-key meta-mode-map "\(" 'skeleton-pair-insert-maybe))
              (setq skeleton-pair 1)
              ;;               (set-variable 'shell-file-name "/bin/sh" t)
              )))

(message "pi-meta.el(c) is loaded")

;; pi-meta.el ends here.
;; Local variables:
;; coding: utf-8
;; End:

;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-python.el,v 0.0 2011/04/11 Exp $
;; $Last Modified on 2011/06/30

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Commentary:

;; THANKS:

;; BUGS:

;; INSTALLATION:

;; Code:

(when (file-readable-p (cuid "site-lisp/python-mode"))
  (add-to-list 'load-path (cuid "site-lisp/python-mode"))

  (when (and (executable-find "ipython")
             (require 'python-mode nil t)
             ;; (require 'ipython nil t)
             )
    (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
    (setq interpreter-mode-alist (cons '("python" . python-mode)
                                       interpreter-mode-alist))
    (autoload 'python-mode "python-mode" "Python editing mode." t)

    ;; (setq py-python-command-args '("-pylab" "-colors" "DarkBG"))
    (define-key py-mode-map (kbd "<C-return>") '
      (lambda ()
        (interactive)
        (end-of-line)
        (insert "\\")
        (py-newline-and-indent)
        )
      )

    (define-key py-mode-map "\{" 'skeleton-pair-insert-maybe)
    (define-key py-mode-map "\(" 'skeleton-pair-insert-maybe)
    (define-key py-mode-map "[" 'skeleton-pair-insert-maybe)
    (define-key py-mode-map "\"" 'skeleton-pair-insert-maybe)
    (define-key py-mode-map "'" 'skeleton-pair-insert-maybe)
    (define-key py-mode-map "\{" 'skeleton-pair-insert-maybe)
    (define-key py-mode-map (kbd "C-c <down>") 'py-end-of-block-or-clause)
    (define-key py-mode-map (kbd "C-c <up>") 'py-beginning-of-block-or-clause)

    (when
        (and
         (require 'auto-complete-config "auto-complete-config.elc" t)
         ;; (require 'pymacs nil t)
         (ac-ropemacs-initialize)
         )

      ;; Support for Eldoc
      ;; Src : http://www.emacswiki.org/emacs/ElDoc#toc8
      ;; [----
      (defun rope-eldoc-function ()
        (interactive)
        (let* ((win-conf (current-window-configuration))
               (resize-mini-windows nil)
               (disable-python-trace t)
               class fun args result-type
               (flymake-message (python-flymake-show-help))
               (initial-point (point))
               (paren-range (let (tmp)
                              (ignore-errors
                                (setq tmp (vimpulse-paren-range 0 ?\( nil t))
                                (if (and tmp (>= (point) (car tmp)) (<= (point) (cadr tmp)))
                                    tmp
                                  nil))))
               (result (save-excursion
                         ;; check if we on the border of args list - lparen or rparen
                         (if paren-range
                             (goto-char (car paren-range)))
                         (call-interactively 'rope-show-doc)
                         (set-buffer "*rope-pydoc*")
                         (goto-char (point-min))
                         (if (or (equal (point-max) 1)
                                 (not (re-search-forward "\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)(.*):" (point-at-eol) t))
                                 (and (current-message) (string-match-p "BadIdentifierError" (current-message))))
                             nil
                           (let (result)
                             ;; check if this is class definition
                             (if (looking-at "class \\([a-zA-Z_]+[a-zA-Z0-9_]*\\)(.*):")
                                 (progn
                                   (goto-char (point-at-eol))
                                   (re-search-forward (buffer-substring (match-beginning 1) (match-end 1)))))
                             (goto-char (point-at-bol))
                             (setq result (buffer-substring (point) (point-at-eol)))

                             ;; check if exist better description of function
                             (goto-char (point-at-eol))
                             (string-match "\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)(.*)" result) ;get function name
                             (if (re-search-forward (concat (match-string 1 result) "(.*)") nil t)
                                 (progn
                                   (goto-char (point-at-bol))
                                   (setq result (buffer-substring (point) (point-at-eol)))))

                             ;; return result
                             result
                             ))))
               (arg-position (save-excursion
                               (if paren-range
                                   (count-matches "," (car paren-range) (point))))))
          ;; save window configuration
          (set-window-configuration win-conf)
          ;; process main result
          (if result
              (progn
                (setq result-type (nth 1 (split-string result "->")))
                (setq result (nth 0 (split-string result "->")))
                (setq result (split-string result "("))
                (setq fun (nth 1 (split-string (nth 0 result) "\\.")))
                (setq class (nth 0 (split-string (nth 0 result) "\\.")))
                ;; process args - highlight current function argument
                (setq args (nth 0 (split-string (nth 1 result) ")")))

                ;; highlight current argument
                (if args
                    (progn
                      (setq args (split-string args ","))
                      (setq args (let ((num -1))
                                   (mapconcat
                                    (lambda(x)(progn
                                                (setq num (+ 1 num))
                                                (if (equal num arg-position) (propertize x 'face 'eldoc-highlight-function-argument) x)))
                                    args
                                    ",")))))

                ;; create string for type signature
                (setq result
                      (concat
                       (propertize "Signature: " 'face 'flymake-message-face)

                       (if fun
                           (concat (propertize (org-trim class) 'face 'font-lock-type-face)
                                   "."
                                   (propertize (org-trim fun) 'face 'font-lock-function-name-face))
                         (propertize (org-trim class) 'face 'font-lock-function-name-face))

                       " (" args ")"

                       (if result-type
                           (concat " -> " (org-trim result-type)))
                       ))))

          ;; create final result
          (if (and (null flymake-message) (null result))
              nil
            (concat flymake-message
                    (if (and result flymake-message) "\n")
                    result))))

      (defvar disable-python-trace nil)

      (defadvice message(around message-disable-python-trace activate)
        (if disable-python-trace
            t
          ad-do-it))

      (defface flymake-message-face
        '((((class color) (background light)) (:foreground "#b2dfff"))
          (((class color) (background dark))  (:foreground "#b2dfff")))
        "Flymake message face")

      (defun python-flymake-show-help ()
        (when (get-char-property (point) 'flymake-overlay)
          (let ((help (get-char-property (point) 'help-echo)))
            (if help
                (format (concat (propertize "Error: " 'face 'flymake-message-face) "%s") help)))))
      )
    ;; ---]

    (when (featurep 'popwin)
      (push '("\*Python*" :regexp t :height 15) popwin:special-display-config))


    (when (and
           nil
           (file-readable-p "~/bin/pylint_etc_wrapper.py")
           (load "flymake" t)
           (load "flymake-cursor" t))
      ;; (defun flymake-pylint-init ()
      ;;   (let* ((temp-file (flymake-init-create-temp-buffer-copy
      ;;                      'flymake-create-temp-inplace))
      ;;          (local-file (file-relative-name
      ;;                       temp-file
      ;;                       (file-name-directory buffer-file-name))))
      ;;     (list "epylint" (list local-file))))

      ;; (add-to-list 'flymake-allowed-file-name-masks
      ;;              '("\\.py\\'" flymake-pylint-init))

      (setq pycodechecker "~/bin/pylint_etc_wrapper.py")
      (defun dss/flymake-pycodecheck-init ()
        (let* ((temp-file (flymake-init-create-temp-buffer-copy
                           'flymake-create-temp-inplace))
               (local-file (file-relative-name
                            temp-file
                            (file-name-directory buffer-file-name))))
          (list pycodechecker (list local-file))))
      (add-to-list 'flymake-allowed-file-name-masks
                   '("\\.py\\'" dss/flymake-pycodecheck-init))

      ;; And here are two little helpers for quickly silencing a warning message:
      (defun dss/pylint-msgid-at-point ()
        (interactive)
        (let (msgid
              (line-no (line-number-at-pos)))
          (dolist (elem flymake-err-info msgid)
            (if (eq (car elem) line-no)
                (let ((err (car (second elem))))
                  (setq msgid (second (split-string (flymake-ler-text err)))))))))

      (defun dss/pylint-silence (msgid)
        "Add a special pylint comment to silence a particular warning."
        (interactive (list (read-from-minibuffer "msgid: " (dss/pylint-msgid-at-point))))
        (save-excursion
          (comment-dwim nil)
          (if (looking-at "pylint:")
              (progn (end-of-line)
                     (insert ","))
            (insert "pylint: disable-msg="))
          (insert msgid)))

      (when (featurep 'col-highlight)
        (add-hook 'python-mode-hook
                  (lambda nil
                    (column-highlight 79)
                    )))

      (add-hook 'python-mode-hook
                (lambda ()
                  (define-key py-mode-map (kbd "M-n") 'flymake-goto-next-error)
                  (define-key py-mode-map (kbd "M-p") 'flymake-goto-prev-error)
                  (unless (eq buffer-file-name nil) (flymake-mode 1))
                  (eldoc-mode 1)))
      ))
  )
;;; pi-python.el ends here

;; Local variables:
;; coding: utf-8
;; End:


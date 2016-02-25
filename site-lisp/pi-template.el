;;; pi-template.el

;; Copyright (C) 2006
;; Author: Philippe IVALDI
;; Last modified: Sun Jul  1 01:06:47 CEST 2007
;;
;; This program is free software ; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation ; either version 2 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY ; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program ; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

;;; Commentary:

;;; THANKS:

;;; BUGS:

;;; INSTALLATION:
;; Put this line in your .emacs
;; (autoload 'pi-template "pi-template")
;; You must customize some variables by M-x customize-group <RET> pi-template

;;; Code:

(eval-when-compile
  (require 'cl))

(require 'autoinsert)
(require 'skeleton)


;; (defadvice TeX-auto-store (around no-auto-insert activate)
;;   "Ensure auto-insert is deactivated"
;;   (let ((auto-insert-automatically nil))
;;     ad-do-it))

(defcustom pi-template-directory (expand-file-name auto-insert-directory)
  "* Directory where the templates are."
  :type 'directory
  :group 'pi-template)

(defun pi-template-set-pi-template-auto-insert (phantom value)
  "* Set properly the value of pi-template-auto-insert to value.
The parameter PHANTOM, a symbol, is not used."
  (setq pi-template-auto-insert value)
  (auto-insert-mode -1))

(defcustom pi-template-auto-insert t
  "* If value's t, use `pi-template' with auto-insert features.
If you want customize this variable without 'Emacs customize' use the function `pi-template-set-pi-template-auto-insert'."
  :type 'boolean
  :set 'pi-template-set-pi-template-auto-insert
  :group 'pi-template)

(defcustom pi-template-author user-full-name
  "* Name of default author uses within template."
  :type '(string)
  :group 'pi-template)

(defcustom pi-template-email user-mail-address
  "* Email uses within template."
  :type '(string)
  :group 'pi-template)

(defcustom pi-template-address "**YOU DID NOT CUSTOMIZE THE VARIABLE `pi-template-address'**"
  "* Email uses within template."
  :type '(string)
  :group 'pi-template)

(defcustom pi-template-phone "**YOU DID NOT CUSTOMIZE THE VARIABLE `pi-template-phone'**"
  "* Email uses within template."
  :type '(string)
  :group 'pi-template)

(defcustom pi-template-alist
  '(
    (cperl-mode "pl")
    (sh-mode "sh")
    (c-mode "h")
    (python-mode "py")
    ("[Mm]akefile\\'" "mk")
    (emacs-lisp-mode "el")
    ("\\.tex$" "tex")
    ("\\.cls$" "cls")
    ("\\.sty$" "sty")
    ("\\.xhtml$" "xhtml")
    ("\\.html$" "html"))
  "Alist of ..."
  :type 'alist
  :group 'pi-template)


(when pi-template-auto-insert
  (setq auto-insert-alist
        (mapcar (lambda (alist)
                  `(,(nth 0 alist) . (lambda () (pi-template ,(nth 1 alist)))))
                pi-template-alist))
  ;; (setq auto-insert-alist
  ;;       '(
  ;;         (cperl-mode . (lambda () (pi-template "pl")))
  ;;         (sh-mode . (lambda () (pi-template "sh")))
  ;;         (c-mode . (lambda () (pi-template "h")))
  ;;         (python-mode . (lambda () (pi-template "py")))
  ;;         ("[Mm]akefile\\'" . (lambda () (pi-template "mk")))
  ;;         (emacs-lisp-mode . (lambda () (pi-template "el")))
  ;;         ("\\.tex$" . (lambda () (pi-template "tex")))
  ;;         ("\\.cls$" . (lambda () (pi-template "cls")))
  ;;         ("\\.sty$" . (lambda () (pi-template "sty")))
  ;;         ("\\.xhtml$" . (lambda () (pi-template "xhtml")))
  ;;         ("\\.html$" . (lambda () (pi-template "html")))
  ;;         ;; Add here the others conditions
  ;;         )
  ;;       )
  (add-hook 'find-file-hooks 'auto-insert)
  (auto-insert-mode 1))

;;Inspired from
;; http://www.emacswiki.org/cgi-bin/wiki/RecipeForSkeletonMode
(defun pi-template-file-to-skeleton (fm)
  "Convert current buffer to string"
  (interactive "fSkeletonize file:")
  (let ((sklist '())(line "")(sk '()))
    (with-temp-buffer
      (insert-file-contents fm)
      (beginning-of-buffer)
      (while (re-search-forward "!§!\\(\\(\n\\|.\\)*?\\)!§!" nil t)
        (setq sklist (cons (match-string 1) sklist))
        (replace-match "^Z" nil t))
      (setq lines (progn
                    (beginning-of-buffer)
                    (split-string (buffer-substring-no-properties (point) (point-max)) "\n")))
      (erase-buffer)
      (insert "(setq sk '( nil\n")
      (dolist (line lines nil)
        (back-to-indentation)
        (insert (format "%S \n" (concat line "\n"))))
      (insert "))")
      (while (re-search-backward "\\^Z" (point-min) t)
        (replace-match (concat "\"" (car sklist) "\"") nil t)
        (setq sklist (cdr sklist)))
      (eval-current-buffer))
    sk
    ))

(defun pi-template-licence (&optional type)
  (interactive)
  (let ((pointb (point))
        (sk
         (pi-template-file-to-skeleton
          (if (null type)
              (expand-file-name (read-file-name
                                 "Licence filename: "  ;Prompt
                                 pi-template-directory ;Default dir
                                 nil    ;Default filename
                                 t nil  ;Must march.
                                 '(lambda (name) ;Filter
                                    (pi-extension-filter name "licence"))))
            (expand-file-name (concat pi-template-directory type ".licence"))))))
    (skeleton-insert sk)
    (comment-region pointb (point))))

(defun pi-extension-filter (name extension)
  (if (string= (file-name-extension name) extension) t nil))

(defun pi-template (&optional extension)
  (interactive)
  (let* ((extension (if (null extension) (file-name-extension (buffer-file-name)) extension))
         (sk (pi-template-file-to-skeleton
              (expand-file-name (read-file-name
                                 "Template filename: " ;Prompt
                                 pi-template-directory ;Default dir
                                 (concat "default." extension) ;Default filename
                                 t nil           ;Must march.
                                 '(lambda (name) ;Filter
                                    (pi-extension-filter name extension)))))))
    (skeleton-insert sk)
    (insert " ") ;;set buffer-modified t
    (backward-delete-char 1)
    (indent-region (point-min) (point-max))
    (indent-according-to-mode)))

(provide 'pi-template)

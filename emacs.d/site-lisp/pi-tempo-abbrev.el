;; Copyright (c) 2006, Philippe Ivaldi.
;; Version: $Id: pi-tempo-abbrev.el,v 0.0 2006/12/04 19:16:50 Philippe Ivaldi Exp $

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
;; Using tempo template within abbrev-mode  (Emacs 21 or higher).
;; The principal functions are `tempo-abbrev-add' and `tempo-abbrev-change-table'
;; You can read the docstring using C-h f tempo-abbrev-add <RET>.

;; THANKS:
;; This package is inspired by these pages:
;; http://www.emacswiki.org/cgi-bin/wiki/TempoMode
;; http://www.linux-france.org/prj/emacs/lt.html

;; BUGS:
;; Within Emacs 21, the `lisp-interaction-mode-abbrev-table' is modified when defining
;; an abbrev table with tempo-abbrev-add for lisp-mode.

;; INSTALLATION:
;; Copy and uncomment the following lines in your .emacs
;; (require 'pi-tempo-abbrev)
;; (load "your-tempo-abbrev-mode")
;; (load "another-tempo-abbrev-mode")
;; You must enable abbrev-mode in order to use your table or use some key-binding like this
;; one: (global-set-key (kbd "M-SPC") 'expand-abbrev)

;; You can see how to construct a `tempo-abbrev-mode' in the files
;;pi-tempo-abbrev-latex.el, pi-tempo-abbrev-meta.el and pi-tempo-abbrev-lips.el
;;which comes with this file.

;; Code:

(require 'cl)
(require 'tempo)
(require 'advice)

;; save abbreviations upon exiting emacs whithout confirmation
(setq save-abbrevs (quote silently))

(setq-default tempo-interactive t)
;; The definition in tempo.el is false.
(setq-default tempo-match-finder "\\b\\([^\b]+\\)\\=")

(defvar pi-tempo-abbrev-table-list '())

(defadvice tempo-define-template (after no-self-insert-in-abbrevs activate)
  "Skip self-insert if template function is called by an abbrev."
  (put (intern (concat "tempo-template-" (ad-get-arg 0))) 'no-self-insert t))

(defadvice write-abbrev-file (around pi-tempo-abbrev-write-file activate)
  "* Delete temporarily the tables add by `tempo-abbrev-add' in `abbrev-table-name-list'
before saving the tables."
  (let* ((t-table-name abbrev-table-name-list)
         (abbrev-table-name-list
          (progn
            (dolist (tb pi-tempo-abbrev-table-list)
              (setq t-table-name (delete tb t-table-name)))
            t-table-name)))
    ad-do-it))

;; Modification of tempo for running auctex function
;; From latex-tempo.el
(defadvice tempo-insert (before run-function (element on-region))
  "run (auctex) lisp  function"
  (if (and (consp element)
	   (eq (car element) 'f))
      (progn
	(apply (nth 1 element) (nthcdr 2 element))
	(ad-set-arg 0 nil))))
(ad-activate 'tempo-insert t)

;;;###autoload
(defun tempo-abbrev-add (hooks table taglist tempolist)
  "* Construct tempo-template and insert abbrev in 'table'.
- HOOKS is a list of hook name for which the abbrev-table will be available.
- TABLE is a symbol, the name of the table which will create.
- TAGLIST is a symbol, the name of the tag list that tag of tempolist
should be added to.
- tempolist, a list, has this form:
'((\"TAG1\" (ELEMENTS))
 (\"TAG2\" (ELEMENTS))
 ...)
where TAG* is the abbrevation and ELEMENTS is the definition of tempo-template
as describes in the documentation of `tempo-define-template'.
Here an example:
(tempo-abbrev-add
 '(lisp-mode-hook emacs-lisp-mode-hook) ;; List of modes where the following table will use.
 'tempo-abbrev-lisp-table    ;; Table name (* MUST BE UNIQUE *).
 'tempo-abbrev-lisp-tagslist ;; Name of the variable where the tag list should be added.
 '((\"lambda\" (> \"lambda (\" p \")\" n> p > \")\" > %))
 (\"defun\" (> \"defun \" p \" (\" p \")\" n> \"\\\"\" p \"\\\"\" n> r \")\" > %))))
"
  (if (memq table pi-tempo-abbrev-table-list)
      (read-string (concat "* Error, " (symbol-name table) " already defined.\n  Press return to continue."))
    (progn
      (funcall `(lambda ()
                  (define-abbrev-table ',table nil)
                  (defvar ,taglist '()
                    "List of `tempo-template' used via tempo-abbrev.\n
It's variable is automatically created by `tempo-abbev-add'")))
      (push table pi-tempo-abbrev-table-list)
      (dolist (h hooks)
        (add-hook h
                  `(lambda ()
                     (tempo-use-tag-list ',taglist)
                     (setq local-abbrev-table ,table))))
      (mapcar
       (lambda (tempodef)
         (let* ((tag (car tempodef))
                (element (nth 1 tempodef))
                (template-name (concat (symbol-name (abbrev-table-name (symbol-value table))) "-" tag)))
           (tempo-define-template
            template-name ;;name of the template
            element       ;;definition
            tag           ;;tag used for completion
            "Added by `tempo-abbrev-add'." ;;documentation
            taglist ;;the tag list that "tag" should be added to.
            )
           (define-abbrev (symbol-value table) tag "" (intern (concat "tempo-template-" template-name)))))
       tempolist))))

;;;###autoload
(defun tempo-abbrev-change-table (&optional TABLE)
  "* Change local-abbrev-table or set it to TABLE."
  (interactive)
  (let* ((comp-abbrev-table
          (mapcar
           (lambda (table)
             (list (symbol-name table)))
           abbrev-table-name-list))
         (select-table-s (if (null TABLE)
                             (completing-read
                              (concat
                               "Change local-abbrev-table from "
                               (symbol-name (abbrev-table-name local-abbrev-table)) " to: ")
                              comp-abbrev-table nil t)
                           (symbol-name (abbrev-table-name TABLE))))
         (select-table (eval (intern select-table-s))))
    (if (memq (abbrev-table-name select-table) abbrev-table-name-list)
        (setq local-abbrev-table select-table)
      (error (concat select-table " is a unknown abbrev-table.")))
    ))

(provide 'pi-tempo-abbrev)

;;; pi-tempo-abbrev.el ends here


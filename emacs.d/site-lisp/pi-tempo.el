;; Copyright (c) 2009, Philippe Ivaldi http://www.piprime.fr/
;; Version: $Id: pi-tempo.el,v 1.0 2006/11/20
;; Last modified: Thu Nov 19 23:57:36 CET 2009

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
;; Facility for using tempo template.
;; The principal function is `pi-tempo-add'
;; You can read the docstring using C-h f pi-tempo-add <RET>.

;; THANKS:
;; This package is inspired by these pages:
;; http://www.emacswiki.org/cgi-bin/wiki/TempoMode
;; http://www.linux-france.org/prj/emacs/lt.html

;; BUGS:

;; INSTALLATION:
;; Copy and uncomment the following lines in your .emacs
;; (require 'pi-tempo-abbrev)
;; (load "your-tempo-mode")
;; (load "another-tempo-mode")

;; You can see how to construct a `tempo-abbrev-mode' in the files
;;pi-tempo-abbrev-latex.el, pi-tempo-abbrev-meta.el and pi-tempo-abbrev-lips.el
;;which comes with this file.

;; Code:

(require 'cl)
(require 'tempo)
(require 'advice)

(setq-default tempo-interactive t)
;; The definition in tempo.el is false.
(setq-default tempo-match-finder "\\b\\([^\b]+\\)\\=")

(defvar pi-tempo-table-list '())

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
(defun pi-tempo-add (hooks table taglist tempolist)
  "* Construct tempo-template and insert abbrev in 'table'.
- HOOKS is a list of hook name for which the tempo-table will be available.
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
(pi-tempo-add
 '(lisp-mode-hook emacs-lisp-mode-hook) ;; List of modes where the following table will use.
 'tempo-lisp-table    ;; Table name (* MUST BE UNIQUE *).
 'tempo-lisp-tagslist ;; Name of the variable where the tag list should be added.
 '((\"lambda\" (> \"lambda (\" p \")\" n> p > \")\" > %))
 (\"defun\" (> \"defun \" p \" (\" p \")\" n> \"\\\"\" p \"\\\"\" n> r \")\" > %))))
"
  (if (memq table pi-tempo-table-list)
      (read-string (concat "* Error, " (symbol-name table) " already defined.\n  Press return to continue."))
    (progn
      (funcall `(lambda ()
                  (defvar ,taglist '()
                    "List of `tempo-template' used via tempo-abbrev.\n
It's variable is automatically created by `pi-tempo-add'")))
      (push table pi-tempo-table-list)
      (dolist (h hooks)
        (add-hook h
                  `(lambda ()
                     (tempo-use-tag-list ',taglist))))
      (mapcar
       (lambda (tempodef)
         (let* ((tag (car tempodef))
                (element (nth 1 tempodef))
                (template-name (concat (symbol-name table) "-" tag)))
           (tempo-define-template
            template-name ;;name of the template
            element       ;;definition
            tag           ;;tag used for completion
            "Added by `pi-tempo-add'." ;;documentation
            taglist ;;the tag list that "tag" should be added to.
            )))
       tempolist))))

(provide 'pi-tempo)

;;; pi-tempo.el ends here
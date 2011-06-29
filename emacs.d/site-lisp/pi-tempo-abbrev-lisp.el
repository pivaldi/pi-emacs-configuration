;;: -*- emacs-lisp -*-
;;; pi-tempo-abbrev-lisp.el
;;; Author: Philippe Ivaldi
;;; Last modified: Sun Jul  1 01:02:00 CEST 2007

(require 'pi-tempo-abbrev)

;; ;; *=======================================================*
;; ;; *..............Abbreviations for lisp-mode..............*
;; ;; *=======================================================*

(tempo-abbrev-add
 '(lisp-mode-hook emacs-lisp-mode-hook) ;; List of modes where the following table will use.
 'tempo-abbrev-lisp-table    ;; Table name (* MUST BE UNIQUE *).
 'tempo-abbrev-lisp-tagslist ;; Name of the variable where the tag list should be added.
 '(("lambda" (> "lambda (" p ")" n> p > ")" > %))
   ("defun" (> "defun " p " (" p ")" n> "\"" p "\"" n> r ")" > %))
   ("defvar" (> "defvar " p  n> "\"" p "\")" > %))
   ("if" ("if " p n> r")"))
   ("ifp" ("if " p n> "(progn" n> p ")" n> "(progn" n> p "))" > %))
   ("progn" (> "progn" n> p ")" > %))
   ("prog1" (> "prog1" n> p ")" > %))
   ("cond" ("cond ((" p ") " r "))" > %))
   ("require" (> "require '" p ")" > %))
   ("provide" (> "provide '" p ")" > %))
   ("let" (> "let (("p"))" n> p ")" > %))
   ("lete" (> "let* (("p"))" n> p ")" > %))
   ("defcustom" ( > "defcustom " p "" n> "\"" p "\"" n> ":type '" p n> ":group '" p ")" > %))
   ;; `Place_here_your_abbreviations_for_lisp-mode'
   ))

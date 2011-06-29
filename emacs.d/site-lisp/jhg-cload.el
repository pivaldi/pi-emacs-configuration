;;; jhg-cload.el --- Byte compile elisp when loaded.
;;
;; ~/share/emacs/jhg/jhg-cload.el ---
;;
;; $Id: jhg-cload.el,v 1.15 2005/05/05 06:00:23 harley Exp $
;;

;; Author:    Harley Gorrell <harley@panix.com>
;; URL:       http://www.mahalito.net/~harley/elisp/jhg-cload.el
;; License:   GPL v2
;; Keywords:  emacs, compile, load

;;; Commentary:
;; * Attempt to compile elisp right before it is loaded.
;;   Only compile files which are under your chosen paths and
;;   are older than the source files.
;; * If you put '(jhg-cload-try "~/.emacs")' your ~/.emacs
;;   it will be recompiled when needed.  However, this
;;   method will result in one 'stale' start after a
;;   change is made.  (A small price to pay for auto compiles.)

;; FIXME: cload wont compile autoloaded functions.
;;        eval calls do_autoload which "Fload"s directly.
;; maybe use (file-truename) to put the elc with the el?

;;; History:

;;; Code:

(defvar jhg-cload t
  "Attempt to compile before loading elisp when non-nil.")

(defvar jhg-cload-verbose nil
  "Be verbose?")
;; (setq jhg-cload-verbose 10)

;; Maybe make this "~/" if you have elisp all over
;; The filenames are pre-expaned.
(defvar jhg-cload-paths (list (expand-file-name "~/"))
  "Path prefixes under which compile on load should be attempted.")

;;; UTIL

(defun jhg-string-prefix-p (str1 str2)
  "Return t if STR1 is a prefix of STR2."
  (let ((l1 (length str1))
        (l 0)
        (isprefix t))
    (if (> l1 (length str2))
      (setq isprefix nil) ;; cant be a prefix if longer
      (while (and isprefix (< l l1))
        (if (/= (aref str1 l) (aref str2 l))
          (setq isprefix nil))
        (setq l (1+ l))))
    isprefix))
;; (jhg-string-prefix-p "/usr/foo" "/usr/local")
;; (jhg-string-prefix-p "/usr" "/usr/foo")

(defun jhg-cload-oktocompile-p (file)
  "Return t if it is ok to attempt to compile FILE.
This just checks that the file has a prefix covered by jhg-cload-paths.
It could be extented to check for write permission, etc."
  (let ((paths jhg-cload-paths)
        (ok nil))
    (while (and (not ok) paths)
      (if (jhg-string-prefix-p (car paths) file)
        (setq ok t))
      (setq paths (cdr paths)))
    ok))
;; (jhg-cload-oktocompile-p "/home/harley/foo.el")
;; (jhg-cload-oktocompile-p "/usr/local/share/foo.el")
;; (jhg-cload-oktocompile-p "/home/harley/share/emacs/foo.el")
;; (jhg-cload-oktocompile-p "/home/harley/share/emacs/pkg/ssh/foo")

;;; CLOAD

(defun jhg-cload (arg)
  "Toggle variable `jhg-cload'.  Positve ARG will set, negative will clear."
  (interactive "P")
  (setq jhg-cload
        (if arg
          (if (< 0 (prefix-numeric-value arg)) t nil)
          (not jhg-cload)))
  ;; tell the user
  (if (interactive-p)
    (message "jhg-cload is '%s'." (if jhg-cload "on" "off")))
  jhg-cload)
;; (jhg-cload t)

(defmacro jhg-cload-msg (lvl &rest args)
  "Pass ARGS to message for debugging when verbose."
  (if (not (numberp lvl))
    (error "LVL must be a number"))
  (if (not (stringp (car args)))
    (error "Second arg must be a string"))
  ;; the expansion
  `(if (and jhg-cload-verbose 
            (or (eq jhg-cload-verbose t) 
                (and (numberp jhg-cload-verbose)
                     (<= ,lvl jhg-cload-verbose))))
     (message ,@args)) )
;; (jhg-cload-msg 1 "%s" "AAAA")
;; (setq jhg-cload-verbose t)
;; (jhg-cload-msg 1 "%s" "BBB")

(defun jhg-cload-compile (file)
  "Compile FILE if it is ok and out of date."
  (let* ((path-base (file-name-sans-extension (locate-library file)))
         (path-el   (concat path-base ".el" ))
         (path-elc  (concat path-base ".elc")) )
    (if (jhg-cload-oktocompile-p path-base)
      (if (file-newer-than-file-p path-el path-elc)
        (progn
          ;; remove the old file -- viano and linux disagree over gids
          (condition-case nil
              (delete-file path-elc)
            (error nil))
          ;; set about compiling it
          (jhg-cload-msg 1 "cload: compiling '%s'..." path-el)
          (byte-compile-file path-el))
        (jhg-cload-msg 2 "cload: ok '%s'" file))
      (jhg-cload-msg 2 "cload: skipping '%s'..." file)) ))
;; (jhg-cload-compile "aaa.el")
;; (jhg-cload-compile "jhg-cload")

(defun jhg-cload-try (file)
  "Try and compile the FILE.  Errors are ignored."
  (condition-case nil
      (jhg-cload-compile file)
    (error nil)))
;; (jhg-cload-try "aaa.el")


;; Advise these two functions to compile before loading.

(defadvice load (before jhg-cload-advice activate)
  "Advise 'load' to try and compile before loading."
  (when jhg-cload
    (jhg-cload-msg 3 "cload: (load \"%s\")" (ad-get-arg 0))
    (jhg-cload-try (ad-get-arg 0))))

(defadvice require (before jhg-cload-advice activate)
  "Advise 'require' to try and compile before loading."
  (let ((feat (ad-get-arg 0)))
    (when (and jhg-cload (not (member feat features)))
      (jhg-cload-msg 3 "cload: (require '%s)" feat)
      (jhg-cload-try (symbol-name feat)))))

;; TESTS:
;; (mapcar 'jhg-cload-try '("advice" "jhg-text" "jhg-cload"))
;; (mapcar 'load '("advice" "jhg-text" "jhg-cload" "jhg-math"))
;; (require 'jhg-shell)

;;
(provide 'jhg-cload)

;;; jhg-cload.el ends here

;; --------------
;; * TypoScript *
(when (locate-library (cuid "site-lisp/ts-mode.el"))
  ;; URL: http://www.emacswiki.org/emacs/ts-mode.el
  (autoload 'ts-mode "ts-mode" "TypoScript file editing mode." t)
  (setq auto-mode-alist (cons '("\\.ts$" . ts-mode) auto-mode-alist)))

;; Local variables:
;; coding: utf-8
;; End:

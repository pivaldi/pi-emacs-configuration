(when (locate-library (cuid "site-lisp/sass-mode.el"))
  (require 'sass-mode)
  (setq auto-mode-alist (cons '("\\.scss$" . sass-mode) auto-mode-alist))
  )
(when (file-exists-p "/usr/local/emacs.d/site-lisp/jde/lisp/jde.el")
  (add-to-list 'load-path (expand-file-name "/usr/local/emacs.d/site-lisp/jde/lisp"))
  (require 'jde))

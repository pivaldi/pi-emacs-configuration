;; -------
;; * Lua *
(when (locate-library (cuid "site-lisp/lua-mode.el"))
  (setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t))

;; Local variables:
;; coding: utf-8
;; End:

;; ---------------------------------
;; * Image de synthèse avec PovRay *
(when (locate-library (cuid "site-lisp/pov-mode/pov-mode"))
  (add-to-list 'load-path (cuid "site-lisp/pov-mode/pov-mode"))
  (autoload 'pov-mode "pov-mode.el" "PoVray scene file mode" t)
  ;; Set autoloading of POV-mode for these file-types.
  (setq auto-mode-alist
        (append '(("\\.pov$" . pov-mode)
                  ("\\.inc$" . pov-mode)
                  ) auto-mode-alist))

  (add-hook 'pov-mode-hook 'turn-on-font-lock)
  (setq pov-indent-level '2)
  ;; Automatically reindents else/end/break
  (setq pov-autoindent-endblocks t)
  (setq pov-indent-under-declare '2)
  ;; When it's non-nil, we fontify *every*
  ;; Povray keyword.  Careful!
  (setq pov-fontify-insanely t)
  ;;Where the pov-helpfile is located
  (setq pov-home-dir "/usr/share/")
  ;; What the helpfile is called
  (setq pov-help-file "povuser.txt")
  ;; external view with the command display
  (setq pov-default-view-internal nil)
  (setq pov-external-viewer-command "display"))

;; Local variables:
;; coding: utf-8
;; End:

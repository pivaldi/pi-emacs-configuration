;; ------------------------
;; * Calculs avec Pari/gp *
(when (locate-library "pari")
  (autoload 'gp-mode "pari" nil t)
  (autoload 'gp-script-mode "pari" nil t)
  (autoload 'gp "pari" nil t)
  (autoload 'gpman "pari" nil t)
  (setq auto-mode-alist (cons '("\\.gp$" . gp-script-mode)
                              auto-mode-alist)))

;; Local variables:
;; coding: utf-8
;; End:

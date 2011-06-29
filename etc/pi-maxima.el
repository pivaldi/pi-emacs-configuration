;; -------------------------------
;; * Calculs formels avec Maxima *
(when (locate-library "imaxima")
  (autoload 'imaxima "imaxima" "Image support for Maxima." t)
  (autoload 'dbl "dbl")
  (setq imaxima-scale-factor 2))
(when (locate-library "maxima")
  ;; Les .max seront en mode Maxima.
  (setq auto-mode-alist (cons '("\\.max" . maxima-mode) auto-mode-alist))
  (autoload 'maxima "maxima" "Running Maxima interactively" t)
  (autoload 'maxima-mode "maxima" "Maxima editing mode" t))

;; Local variables:
;; coding: utf-8
;; End:

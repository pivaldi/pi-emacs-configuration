;; https://github.com/m2ym/popwin-el
(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer)
  (push '("\*.*Completion.*\*" :regexp t :height 15) popwin:special-display-config))
;;; pi-popwin.el ends here

;; Local variables:
;; coding: utf-8
;; End:


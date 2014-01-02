;; (add-to-list 'warning-suppress-types (list '(undo discard-info)))
(when (file-readable-p (cuid "site-lisp/bongo"))
  (add-to-list 'load-path (cuid "site-lisp/bongo"))
  (setq bongo-file-name-field-separator "--")
  ;; (setq bongo-vlc-extra-arguments '("--play-and-exit"))
  (require 'bongo)

  ;; Dispo ici: http://www.brockman.se/software/volume-el/
  (autoload 'volume "volume"
    "Tweak your sound card volume." t))

;; Local variables:
;; coding: utf-8
;; End:

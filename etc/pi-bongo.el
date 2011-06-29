;;(add-to-list 'warning-suppress-types (list '(undo discard-info)))
(when (file-readable-p (cuid "site-lisp/bongo"))
  (add-to-list 'load-path (cuid "site-lisp/bongo"))
  (setq bongo-file-name-field-separator "--")
  ;; (setq bongo-vlc-extra-arguments '("--play-and-exit"))
  (require 'bongo)
  ;; (setq bongo-vlc-extra-arguments '("--play-and-exit"))
  ;;   Corrige un problème avec vlc: http://selfdeprecated.wordpress.com/2009/04/18/windows-emacs-and-bongo/
  ;;   je n'ai modifié que la ligne (list file-name "vlc://quit")
  ;; (eval-after-load 'bongo
  ;;   '(progn
  ;;      (defun bongo-start-vlc-player (file-name &optional extra-arguments)
  ;;        (let* ((process-connection-type nil)
  ;;               (arguments (append
  ;;                           (when bongo-vlc-interactive
  ;;                             (append (list "-I" "rc" "--rc-fake-tty")
  ;;                                     (when (bongo-uri-p file-name)
  ;;                                       (list "-vv"))
  ;;                                     (when (eq window-system 'w32)
  ;;                                       (list "--rc-quiet"))))
  ;;                           (bongo-evaluate-program-arguments
  ;;                            bongo-vlc-extra-arguments)
  ;;                           extra-arguments
  ;;                           (list file-name)
  ;;                           (when (not (bongo-uri-p file-name)) (list "vlc://quit"))))
  ;;               (process (apply 'start-process "bongo-vlc" nil
  ;;                               bongo-vlc-program-name arguments))
  ;;               (player
  ;;                (list 'vlc
  ;;                      (cons 'process process)
  ;;                      (cons 'file-name file-name)
  ;;                      (cons 'buffer (current-buffer))
  ;;                      (cons 'interactive bongo-vlc-interactive)
  ;;                      (cons 'pausing-supported t)
  ;;                      (cons 'seeking-supported bongo-vlc-interactive)
  ;;                      (cons 'time-update-delay-after-seek
  ;;                            bongo-vlc-time-update-delay-after-seek)
  ;;                      (cons 'paused nil)
  ;;                      (cons 'pause/resume 'bongo-vlc-player-pause/resume)
  ;;                      (cons 'seek-to 'bongo-vlc-player-seek-to)
  ;;                      (cons 'seek-unit 'seconds))))
  ;;          (prog1 player
  ;;            (set-process-sentinel process 'bongo-default-player-process-sentinel)
  ;;            (bongo-process-put process 'bongo-player player)
  ;;            (when bongo-vlc-interactive
  ;;              (set-process-filter process 'bongo-vlc-process-filter)))))))

  ;; Dispo ici: http://www.brockman.se/software/volume-el/
  (autoload 'volume "volume"
    "Tweak your sound card volume." t))

;; Local variables:
;; coding: utf-8
;; End:

;; ----------------------------------------
;; * Correction orthographique à la volée *
;; Flyspell http://kaolin.unice.fr/~serrano
(when (locate-library "flyspell")
  ;; Je ne veux pas utiliser M-TAB pour corriger un mot, M-$ me suffit!
  ;; J'utilise M-TAB pour la completion du langage édité
  (setq flyspell-use-meta-tab nil)
  (autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
  ;; (autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
  ;; (setq ispell-program-name "ispell")
  (setq ispell-program-name "aspell")
  (ispell-change-dictionary pi-flyspell-default-dictionary 1)
  (setq flyspell-default-dictionary pi-flyspell-default-dictionary)

  (dolist (hook pi-flyspell-prog-mode-alist)
    (add-hook hook
              (lambda ()
                (flyspell-prog-mode)
                (ispell-change-dictionary pi-flyspell-secondary-dictionary)
                )))

  (dolist (hook pi-flyspell-mode-alist)
    (add-hook hook
              (lambda ()
                (flyspell-mode 1))))
  )

;; ---------------------------
;; * Bascule du dictionnaire *
(defun pi-ispell-toggle-fr-am ()
  "* Toggle between american dictionary and french dictionary."
  (interactive)
  (if (string= ispell-current-dictionary pi-flyspell-default-dictionary)
      (ispell-change-dictionary pi-flyspell-secondary-dictionary)
    (ispell-change-dictionary pi-flyspell-default-dictionary)
    ))
(global-set-key (kbd "<f6>") 'pi-ispell-toggle-fr-am)

;; Local variables:
;; coding: utf-8
;; End:

;;; Author: Philippe Ivaldi

(eval-when-compile
  (require 'cl))

;; I use the Gnus Message package.
(setq mail-user-agent (quote message-user-agent))
;; Definit Gnus comme lecteur courriel
(setq read-mail-command (quote gnus))

;; Où se trouve mon fichier d'initialisation de gnus et son nom
(setq gnus-home-directory "~/.emacs.d/.gnus.d/")
(setq gnus-init-file (cuid "etc/gnus/gnus.el"))
(setq gnus-directory gnus-home-directory)
(setq message-directory (concat gnus-directory "Mails/"))
(setq gnus-startup-file (concat gnus-directory ".newsrc"))

(provide 'pi-gnus)

;;; Local variables:
;;; coding: utf-8
;;; pi-gnus ends here

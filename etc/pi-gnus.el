;;: -*- emacs-Lisp-mode -*-
;;; pi-gnus.el
;;; Author: Philippe Ivaldi

(eval-when-compile
  (require 'cl))

;; I use the Gnus Message package.
(setq mail-user-agent (quote message-user-agent))
;; Definit Gnus comme lecteur courriel
(setq read-mail-command (quote gnus))

;; Où se trouve mon fichier d'initialisation de gnus et son nom
(setq gnus-home-directory (cuid "etc/gnus"))
(setq gnus-init-file (concat gnus-home-directory "/gnus.el"))

(message "pi-gnus.el(c) is loaded")
;; Local variables:
;; coding: utf-8
;; End:

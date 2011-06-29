;;: -*- emacs-Lisp-mode -*-
;;; pi-gnus.el
;;; Author: Philippe Ivaldi

(eval-when-compile
  (require 'cl))

;;;;;;;;;;;;;;;GNUS;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I use the Gnus Message package.
(setq mail-user-agent (quote message-user-agent))
;; Definit Gnus comme lecteur courriel
(setq read-mail-command (quote gnus))

;; Où se trouve mon fichier d'initialisation de gnus et son nom
(setq gnus-home-directory "~/emacs.d/etc/gnus")
(setq gnus-init-file (concat gnus-home-directory "/gnus.el"))

;; Évite d'avoir des fichiers ~ dans les répertoires de mails
(defun turn-off-backup ()
  (set (make-local-variable 'backup-inhibited) t))
(add-hook 'nnfolder-save-buffer-hook 'turn-off-backup)

;;  Switching Identities interactively is as easy as calling one of
;;  the following two functions:
;;  o `gnus-alias-use-identity' - pass in a valid Identity alias to be
;;    used in the current buffer.
;;  o `gnus-alias-select-identity' - will prompt you for an identity
;;    to use and then use it in the current buffer.
;;
;;  If you do either of them frequently, you can bind them to a key:
;;
;;		(defun pi-message-load-hook ()
;;			(gnus-alias-init)
;;			(define-key message-mode-map [(f10)] (function
;;				(lambda () "Set Identity to jcasadonte." (interactive)
;;				  (gnus-alias-use-identity "JCasadonte"))))
;;
;;			(define-key message-mode-map [(f11)]
;;			'gnus-alias-select-identity)
;;			)
;;
;;		(add-hook 'message-load-hook 'pi-message-load-hook)
(require 'gnus-alias)
(gnus-alias-init)

(defvar gnus-ma-signature-newsgroup
  "   Philippe Ivaldi.
http://www.piprime.fr/")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(message "pi-gnus.el(c) is loaded")
;; Local variables:
;; coding: utf-8
;; End:

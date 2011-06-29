;; ------------------------------------
;; * Insertion automatique de modèles *
(require 'pi-template)
;; Où se trouve mes modèles
(setq pi-template-directory (cuid "site-lisp/template/"))
;; Paramètres identifiant (user-... sont défins dans init.el)
(setq pi-template-author user-full-name
      pi-template-email user-obfuscated-mail
      pi-template-address user-address
      pi-template-phone user-phone)
;; Types de document gérés par pi-template via auto-insert
(setq auto-insert-alist
      '(
        (cperl-mode . (lambda () (pi-template "pl")))
        (sh-mode . (lambda () (pi-template "sh")))
        (c-mode . (lambda () (pi-template "h")))
        (python-mode . (lambda () (pi-template "py")))
        ("[Mm]akefile\\'" . (lambda () (pi-template "mk")))
        (emacs-lisp-mode . (lambda () (pi-template "el")))
        ("\\.tex$" . (lambda () (pi-template "tex")))
        ("\\.cls$" . (lambda () (pi-template "cls")))
        ("\\.sty$" . (lambda () (pi-template "sty")))
        ("\\.xhtml$" . (lambda () (pi-template "xhtml")))
        ("\\.html$" . (lambda () (pi-template "html")))
        ;; Ajouter ici les autres conditions
        ))
(add-hook 'find-file-hooks 'auto-insert)
(auto-insert-mode 1)

;; Local variables:
;; coding: utf-8
;; End:

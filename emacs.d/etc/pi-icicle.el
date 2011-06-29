;; -----------------------------------------------------
;; * Completion and cycling of completion candidates.  *
;; Plus d'info: http://www.emacswiki.org/cgi-bin/wiki/Icicles
;; Icicle est utile mais un peu trop envahissant pour l'activer par défaut
;; icicles doit être appelé le plus tard possible
;; comme j'utilise "desktop-save" j'ai choisi la méthode suivante:
(add-to-list 'load-path (cuid "site-lisp/icicles"))
(add-hook 'desktop-after-read-hook
          (lambda ()
            (require 'icicles)
            (icicle-mode 1)))
;; Il faut ABSOLUEMENT aller voir la documentation: http://www.emacswiki.org/emacs/EmacsNewbieWithIcicles
;; Ça vaut vraiment le coup !
;; Quelques exemples à essayer:
;; M-x delete TAB (complètement par prefix)
;; M-x delete S-TAB  (complètement par sous-chaîne)
;; M-x delete S-TAB M-* file S-TAB (wouhaw, complètement par sous-chaînes multiples)
;; Valeur par défaut " (<S-tab>, TAB: list, C-?: help) " trop long!
;; C-x S-TAB (et oui, on peut a aussi la complètion des raccourcis)
;; C-c = (pour naviguer dans les fonctions, classe, constantes etc...)
;; M-x delete TAB C-CLICK_DROIT sur un candidat donne ce menu: http://www.emacswiki.org/emacs/drew-emacs-Minibuf-menu
;; M-x delete TAB M-k (permet de nettoyer le mini buffer)
;; HISTORIQUE: http://www.emacswiki.org/emacs/Icicles_-_History_Enhancements
;; M-x M-n (next history et M-p pour previous, agit sur l'historique des commandes dèja exécutées)
;; M-x C-l (ou C-S-l pour l'historique des ce qui a déjà était tapé mais pas exécuté)
(setq icicle-prompt-suffix "S-TAB TAB C-?")
(global-set-key (kbd "C-x C-f") 'ido-find-file)

;; Local variables:
;; coding: utf-8
;; End:

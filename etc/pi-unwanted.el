;; --------------------------
;; * Bars, menus et curseur *
(tool-bar-mode -1)   ;; pas de barre d'outils.
(scroll-bar-mode -1) ;; pas de scroll bar.
;; (scroll-bar-mode t)          ;; avoir la bar de scroll
;; (set-scroll-bar-mode 'right) ;; à droite ou...
;; (set-scroll-bar-mode 'left)  ;; à gauche.
(blink-cursor-mode -1) ;; pas de curseur clignotant
(menu-bar-mode -1) ;; pas de barre de menu
;; Je veux le prompt de yas/snippet en mode texte
(setq yas/prompt-functions '(yas/dropdown-prompt))

;; Local variables:
;; coding: utf-8
;; End:

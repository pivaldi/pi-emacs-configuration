;; Quelque macros perso que j'ai défini
;; M-x kmacro-start-macro <ret> pour commencer la définition d'un macro
;; Là on fait ce que l'on veut
;; M-x kmacro-end-or-call-macro <ret> pour dire d'arrêter l'enregistrement de la macro
;; M-x kmacro-end-or-call-macro <ret> pour appeler la dernière macro
;; Avec mes raccourcis ça donne S-F4 pour commencer une définition, F4 pour arrêter et encore F4 pour appeler la dernière macro.
;; On peur donner un nom à une macro M-x name-last-kbd-macro <ret>
;; puis l'enregistrer: ouvrir le fichier où les macros seront enregistrées et y faire un M-x insert-kbd-macro <ret>
;; pour connaître votre fichier de macro, presser C-x C-e après la dernière parenthèse de la ligne suivante
;; (insert (cuid (concat ".kbd-macro-" (user-real-login-name))))
;; Maintenant on charge le fichier de macro (le nom est fonction du login)
(when (file-readable-p (cuid (concat ".kbd-macro-" (user-real-login-name))))
  (load (cuid (concat ".kbd-macro-" (user-real-login-name)))))

;; ---------------
;; * Abréviation *
;; ;; utilisation :
;; ;; taper l'abbrev
;; ;; taper C-x ail pour abbrev local et C-x aig pour abrev global
;; ;; taper la definition
;; ;; M-x edit-abbrevs pour modifier les abbrevs M-x write-abbrev-file pour sauver
;; ;; M-x list-abbrevs pour lister
;; (setq-default abbrev-mode t) ;; enable abbreviations
(setq abbrev-file-name (cuid ".abbrevs"))
(if (file-readable-p abbrev-file-name) ;; read the abbreviations every
    (read-abbrev-file abbrev-file-name)) ;; time emacs is started
;; Sauve les abréviations sans demander confirmation.
(setq save-abbrevs (quote silently))

;; ------------------------
;; * Pour créer une macro *
;; Début de définition d'une macro
(if (fboundp 'kmacro-start-macro)
    (global-set-key (kbd "S-<f4>") 'kmacro-start-macro)
  ;; Termine la définition en cours sinon execute la dernière.
  (global-set-key (kbd "<f4>") 'kmacro-end-or-call-macro)
  ;; Edite la dernière macro
  (global-set-key (kbd "<C-f4>") 'kmacro-edit-macro))

;; Bascule du mode abbrev-mode
(global-set-key (kbd "<f7>") 'abbrev-mode)

;; ---------
;; * Tempo *
;; tempo permet de définir des modèles de macros.
;; Plus d'information ici:
;; http://www.emacswiki.org/cgi-bin/wiki/TempoMode
;; L'extension suivante permet de faciliter légèrement la saisie des templates
;; et corrige quelques bogues. Plus d'info en faisant C-h f pi-tempo-add <ret>
(require 'pi-tempo)
;; Voir le manuel de tempo: http://www.lysator.liu.se/~davidk/elisp/tempo.texi
;; La valeur par défaut de `tempo-insert-region' pose des pb chez moi
(setq-default tempo-insert-region nil)
(global-set-key (kbd "<f3>") 'tempo-complete-tag)
(global-set-key (kbd "<M-left>") 'tempo-backward-mark)
(global-set-key (kbd "<M-right>") 'tempo-forward-mark)

;; Local variables:
;; coding: utf-8
;; End:

;; ---------------------------------
;; * Le Menu depuis le clavier svp *
(require 'lacarte)
;; Taper `<ESC> M-x’. On vous demande le nom du menu à executer; commencer à taper son nom...
(global-set-key [?\e ?\M-x] 'lacarte-execute-menu-command)
(global-set-key [?\M-`] 'lacarte-execute-menu-command)

;; Local variables:
;; coding: utf-8
;; End:

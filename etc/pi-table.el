;; -----------------------
;; * Editeur de tableaux *
;; M-x table-insert pour créer un tableau
;; M-x table-generate-source pour l'exporter en LaTeX, html...
;; M-x ltxtab-format pour formater un tableau en LaTeX
(require 'table "table.el" t)
(add-hook 'text-mode-hook 'table-recognize)

;; Local variables:
;; coding: utf-8
;; End:

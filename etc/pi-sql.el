;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-sql.el,v 0.0 2012/10/20 23:27:24 Exp $
;; $Last Modified on 2016/03/25 11:27:48

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Default mode : PostGresql
(add-hook 'sql-mode-hook 'sql-highlight-postgres-keywords)
;; Sauve l'historique (voir http://www.emacswiki.org/emacs/SqlMode )
(defun my-sql-save-history-hook ()
  (let ((lval 'sql-input-ring-file-name)
        (rval 'sql-product))
    (if (symbol-value rval)
        (let ((filename
               (concat (cuid (symbol-name (symbol-value rval)))
                       (user-real-login-name)
                       "-history.sql")))
          (set (make-local-variable lval) filename))
      (error
       (format "SQL history will not be saved because %s is nil"
               (symbol-name rval))))))

(add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)
(add-hook 'sql-interactive-mode-hook '(lambda nil (toggle-truncate-lines 1)))

(when (locate-library "sql-indent")
  (setq sql-indent-offset 2)
  (eval-after-load "sql"
    '(load-library "sql-indent")))

(eval-after-load "sql"
  '(progn
     (define-key sql-interactive-mode-map (kbd "TAB") 'complete-symbol)
     (when pi-use-skeleton-pair-insert-maybe
       (define-key sql-mode-map "\{" 'skeleton-pair-insert-maybe)
       (define-key sql-mode-map "\(" 'skeleton-pair-insert-maybe)
       (define-key sql-mode-map "[" 'skeleton-pair-insert-maybe)
       (define-key sql-mode-map "\"" 'skeleton-pair-insert-maybe)
       (define-key sql-mode-map "'" 'skeleton-pair-insert-maybe))))


;; Local variables:
;; coding: utf-8
;; End:

;;; package --- Tramp config
;; Copyright (c) 2024, Philippe Ivaldi <www.piprime.fr>

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
;;; Commentary:
; PI config


(when (require 'tramp nil t)
  (add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))

  ;; To “turn off” the backup feature for remote files and stop TRAMP from saving to the backup directory :
  ;; See https://www.gnu.org/software/tramp/#Auto_002dsave-File-Lock-and-Backup
  (customize-set-variable 'tramp-backup-directory-alist backup-directory-alist)

  (setq backup-enable-predicate
        (lambda (name) nil))
  )


(provide 'pi-tramp)
;;; pi-tramp.el ends here

;; Local variables:
;; coding: utf-8
;; End:

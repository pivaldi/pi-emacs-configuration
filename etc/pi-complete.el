;;; Package --- auto-complete configuration
;; Copyright (c) 2018, Philippe Ivaldi <www.piprime.fr>

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

;;;; Commentary:

;;; Code:

(when (require 'company nil t)
  (add-hook 'after-init-hook 'global-company-mode)
  (global-set-key (kbd "M-SPC") 'company-complete)
  ;; (when (require 'company-box nil t)
  ;;   (add-hook 'company-mode-hook 'company-box-mode)
  ;;   )
  )

(provide 'pi-complete)
;;; pi-complete.el ends here

;; Local variables:
;; coding: utf-8
;; End:

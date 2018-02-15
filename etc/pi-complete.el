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

(when (require 'auto-complete nil t)
  (require 'auto-complete-config "auto-complete-config.elc" t)
  (ac-config-default)
  (global-auto-complete-mode t)
  ;; Configurations intéressantes:
  ;; Don't start completion automatically
  ;; (setq ac-auto-start nil)
  ;; (global-set-key "\M-/" 'ac-start)
  ;; start completion when entered 3 characters
  (setq ac-comphist-file (user-conf-file "ac-comphist.dat")
        ac-candidate-limit 20 ;; Limit number of candidates. Non-integer means no limit.
        )

  ;; (define-key ac-completing-map "\C-m" nil)
  ;; (setq ac-use-menu-map t)
  ;; (define-key ac-menu-map "\C-m" 'ac-complete)
  )

(when (require 'company nil t)
  (add-hook 'after-init-hook 'global-company-mode)
  (global-set-key (kbd "M-SPC") 'company-complete)
  )

(provide 'pi-complete)
;;; pi-complete.el ends here

;; Local variables:
;; coding: utf-8
;; End:

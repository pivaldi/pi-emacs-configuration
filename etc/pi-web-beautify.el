;; pi-web-beautify -- editing web basis
;; Copyright (c) 2015, Philippe Ivaldi <www.piprime.fr>

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

;; THANKS:

;; BUGS:

;; INSTALLATION:

;;; Code:

(when (and
       (executable-find "prettier")
       (require 'prettier nil t))

  (add-hook 'after-init-hook #'global-prettier-mode)

  ;; (eval-after-load 'js2-mode
  ;;   '(add-hook 'js2-mode-hook 'prettier-js-mode))

  ;; (eval-after-load 'json-mode
  ;;   '(add-hook 'json-mode-hook
  ;;              'prettier-js-mode))

  ;; (eval-after-load 'css-mode
  ;;   '(add-hook 'css-mode-hook
  ;;              'prettier-js-mode)

  ;;   )
  )

(provide 'pi-web-beautify)
;;; pi-web-beautify.el ends here

;; Local variables:
;; coding: utf-8
;; End.

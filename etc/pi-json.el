;;; Package --- pi-json configuration
;; Copyright (c) 2024, Philippe Ivaldi <www.piprim.net>

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

(add-hook
 'json-mode-hook
 (lambda ()
   (add-hook 'before-save-hook 'json-pretty-print-buffer t t)
   (when (locate-library "prettier")
     (prettier-mode -1))
   ))


(provide 'pi-json)
;;; pi-json.el ends here

;; Local variables:
;; coding: utf-8
;; End:

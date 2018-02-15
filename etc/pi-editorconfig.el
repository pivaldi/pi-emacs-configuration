;;; pi-editorconfig.el --- EditorConfig Emacs Plugin configuration
;; Copyright (c) 2016, Philippe Ivaldi <www.piprime.fr>

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
;; See https://github.com/editorconfig/editorconfig-emacs

;;; Code:

(when (require 'editorconfig nil t)
  (if (not (executable-find "editorconfig"))
      (add-to-list 'pi-error-msgs "Please install editorconfig : https://github.com/editorconfig/editorconfig-core-c/blob/master/INSTALL.md"))

  (editorconfig-mode 1))

;;; pi-editorconfig.el ends here

;; Local variables:
;; coding: utf-8
;; End:

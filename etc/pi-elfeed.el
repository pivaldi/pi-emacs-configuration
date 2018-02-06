;;; Package --- pi-elfeed.el is a configuration file for elfeed <https://github.com/skeeto/elfeed>
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

;;; Commentary:

;;; THANKS:

;;; BUGS:

;;; INSTALLATION:

;;; Code:

(when (require 'elfeed nil t)
  (global-set-key (kbd "C-x w") 'elfeed)

  (when (require 'elfeed-goodies nil t)
    (elfeed-goodies/setup)
    )
  )

(provide 'pi-elfeed)
;;; pi-elfeed.el ends here

;; Local variables:
;; coding: utf-8
;; End:

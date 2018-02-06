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

  (defun pi-elfeed-tag-sort (a b)
    "Custom elfeed sort function based on serialization tag list into
a string, falling back on the date to break ties (descending).
See https://github.com/skeeto/elfeed/issues/203#issuecomment-335038206"
    (let* ((a-tags (format "%s" (elfeed-entry-tags a)))
           (b-tags (format "%s" (elfeed-entry-tags b))))
      (if (string= a-tags b-tags)
          (< (elfeed-entry-date b) (elfeed-entry-date a)))
      (string< a-tags b-tags)))

  (setf elfeed-search-sort-function #'pi-elfeed-tag-sort)
  )

(provide 'pi-elfeed)
;;; pi-elfeed.el ends here

;; Local variables:
;; coding: utf-8
;; End:

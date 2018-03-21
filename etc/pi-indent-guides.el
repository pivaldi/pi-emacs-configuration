;;; Package --- Summary pi-indent-guides configures highlights indentation levels
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

;; THANKS:

;; BUGS:

;; INSTALLATION:

;;; Code:

(when (require 'highlight-indent-guides nil t)
  (eval-after-load 'scss-mode
    (add-hook 'scss-mode-hook 'highlight-indent-guides-mode)
    )

  (eval-after-load 'html-mode
    (add-hook 'html-mode-hook 'highlight-indent-guides-mode)
    )

  (add-hook 'python-mode-hook 'highlight-indent-guides-mode)

  ;; This is to intrusive…
  ;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  )

(provide 'pi-indent-guides)
;;; pi-indent-guides.el ends here

;; Local variables:
;; coding: utf-8
;; End:

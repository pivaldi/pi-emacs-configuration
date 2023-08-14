;;; Package --- description here
;; Copyright (c) 2022, Philippe Ivaldi <www.piprime.fr>

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

;; Commentary:

;; THANKS:

;; BUGS:

;; INSTALLATION:

;; Code:

(when (require 'rust-mode nil t)
  (setq rust-format-on-save t)
  (define-key rust-mode-map (kbd "C-c C-c") 'rust-run)

  (add-hook
   'rust-mode-hook
   (lambda ()
     (setq indent-tabs-mode nil)
     (prettify-symbols-mode)
     ))
  )


(provide 'pi-rust)
;;; pi-rust.el ends here

;; Local variables:
;; coding: utf-8
;; End:

;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-font.el,v 0.0 2012/10/16 01:00:00 Exp $
;; $Last Modified on 2017/09/19 16:18:46

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

(defvar pi-use-pi-theme t)

(when (not custom-enabled-themes)
  (defvar zenburn-override-colors-alist
    '(("zenburn-bg-05" . "#303030")))

  (when (require 'smart-mode-line nil t)
    (rich-minority-mode 1)
    (setq sml/theme 'dark)
    (sml/setup)
    (size-indication-mode)
    )

  (load-theme 'zenburn t))

(if (x-list-fonts pi-default-font)
    (set-frame-font pi-default-font)
  (setq pi-default-font "-*-*-medium-r-normal-*-20-*-*-*-*-*-*"))

(provide 'pi-font)
;;; pi-font.el ends here

;; Local variables:
;; coding: utf-8
;; End:

;;; package --- browse kill ring config
;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-popup-kill-ring.el,v 0.0 2012/10/14 23:51:02 Exp $
;; $Last Modified on 2024/04/21 22:40:47

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
; PI config

;;; Code:

(eval-when-compile
  (require 'cl))

(if (require 'browse-kill-ring nil t)
    (progn
      (global-set-key (kbd "C-c y") 'browse-kill-ring)
      (global-set-key (kbd "C-S-<insert>") 'browse-kill-ring))
  (progn
    (defun pi-popup-menu-yank-menu ()
      (interactive)
      (popup-menu 'yank-menu))
    (global-set-key (kbd "C-c y") 'pi-popup-menu-yank-menu)
    (global-set-key (kbd "C-S-<insert>") 'pi-popup-menu-yank-menu)))

(provide 'pi-browse-kill-ring)
;;; pi-popup-kill-ring.el ends here

;; Local variables:
;; coding: utf-8
;; End:

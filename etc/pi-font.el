;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-font.el,v 0.0 2012/10/16 01:00:00 Exp $
;; $Last Modified on 2016/04/11 00:13:48

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

;; (when (and pi-use-pi-theme window-system)
;;   (if (x-list-fonts pi-default-font)
;;       (set-frame-font pi-default-font)
;;     (setq pi-default-font "-*-*-medium-r-normal-*-20-*-*-*-*-*-*"))

;;   (set-face-attribute
;;    'default nil
;;    :background "DarkSlateGray"
;;    :foreground "Wheat"
;;    ;;                       :underline nil
;;    ;;                       :slant 'normal
;;    ;;                       :weight 'bold
;;    ;;                       :height 200
;;    ;;                       :width 'normal
;;    ;;                       :family "xos4-terminus"
;;    )
;;   (set-face-attribute
;;    'menu nil
;;    :background "DarkSlateGray"
;;    :foreground "grey"
;;    :underline nil
;;    :slant 'normal
;;    ;;                        :weight 'bold
;;    ;;                        :height 200
;;    ;;                        :width 'normal
;;    ;;                        :family "xos4-terminus"
;;    ))

(defun pi-theme-load-zenburn ()
  "Load the Zenburn theme (internal use)"
  (load-theme 'zenburn t)
  )

(defun pi-theme-load-solarized-dark ()
  "Load the Solarized Dark theme (internale use)"
  (load-theme 'solarized-dark t)
  )

(defun pi-theme-load-solarized-dark ()
  "Load the Solarized Light theme (internale use)"
  (load-theme 'solarized-light t)
  )

(defun pi-theme-load-sanityinc-tomorrow ()
  "Load the Sanityinc Tomorrow theme (internale use)"
  (require 'color-theme-sanityinc-tomorrow nil t)
  ;; Todo how to choice the correct theme ?
  )

(apply pi-theme-loader nil)

(provide 'pi-font)
;;; pi-font.el ends here

;; Local variables:
;; coding: utf-8
;; End:

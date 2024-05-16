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

;; Commentary:

;; THANKS:

;; BUGS:

;; INSTALLATION:

;;; Code:


;; (defun pi-resize-flycheck-window ()
;;   "See <https://github.com/flycheck/flycheck/issues/303#issuecomment-55510381>."
;;   (-when-let (window (flycheck-get-error-list-window t))
;;     (with-selected-window window
;;       (fit-window-to-buffer window 60))))

(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
               (display-buffer-reuse-window
                display-buffer-in-side-window)
               (side            . bottom)
               (reusable-frames . visible)
               (window-height   . 0.25)))

;; (add-to-list 'display-buffer-alist
;;              `(,(rx bos "*Project errors*" eos)
;;               (display-buffer-reuse-window
;;                display-buffer-in-side-window)
;;               (side            . bottom)
;;               (reusable-frames . visible)
;;               (window-height   . 0.25)))

(when (require 'popwin nil t)
  ;; (popwin-mode 1)

  (use-package flycheck-projectile
    :config
    (add-to-list 'popwin:special-display-config
                 `(,flycheck-projectile-error-list-buffer
                   :regexp nil :dedicated t :position bottom :stick t
                   :noselect nil))))

(when (require 'flycheck nil t)
  (global-flycheck-mode)
  (when (require 'flycheck-pos-tip nil t)
    (with-eval-after-load 'flycheck
      (flycheck-pos-tip-mode)
      ))

  (when (require 'flycheck-status-emoji nil t)
    (with-eval-after-load 'flycheck
      (flycheck-status-emoji-mode)
      ))
)

(provide 'pi-flymake)
;;; pi-flymake.el ends here

;; Local variables:
;; coding: utf-8
;; End:

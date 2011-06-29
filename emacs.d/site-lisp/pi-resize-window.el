;; Copyright (c) 2009, Philippe Ivaldi http://www.piprime.fr/
;; Version: $Id: pi-resize-window.el,v 1.0 2009/12/01 00:02:18 Philippe Ivaldi Exp $

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3 of the License, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.

;; COMMENTARY:

;; Interactively resize the selected window.
;; Use one of this short-key to enter in resize windows mode
;; C-x <up>, C-x <down>, C-x <right>, C-x <left>
;; then use key-up/down/right/left to resize the windows.
;; Press an other key to quit resizing window mode.

;; INSTALLATION:

;; Put this file somewhere in your Emacs load-path and put this line in your .emacs
;; (require 'pi-resize-window)

;; Code:


;; ---------------------------------------
;; * Pour changer la taille des fenêtres *
;; Author: Kevin Rodgers ??
(defvar pi-enlarge-window-vertically 'up)
(defvar pi-shrink-window-vertically 'down)
(defvar pi-enlarge-window-horizontally 'right)
(defvar pi-shrink-window-horizontally 'left)

(defun pi-resize-window (&optional arg)
  "Interactively resize the selected window.
Repeatedly prompt whether to enlarge or shrink the window until the
response is neither
`pi-enlarge-window-vertically' or `pi-shrink-window-vertically' or
`pi-enlarge-window-horizontally' or `pi-shrink-window-horizontally'.
When called with a prefix arg, resize the window by ARG lines."
  (interactive "p")
  (let ((prompt "Enlarge/Shrink window (up/down/right/left/space)?")
        response)
    (while
        (progn
          (setq response (read-event prompt))
          (cond ((equal response pi-enlarge-window-vertically)
                 (enlarge-window arg) t)
                ((equal response pi-shrink-window-vertically)
                 (enlarge-window (- arg)) t)
                ((equal response pi-shrink-window-horizontally)
                 (enlarge-window (- arg) t) t)
                ((equal response pi-enlarge-window-horizontally)
                 (enlarge-window arg t) t)
                (t nil))))))
(global-set-key (kbd "C-x <up>") 'pi-resize-window)
(global-set-key (kbd "C-x <down>") 'pi-resize-window)
(global-set-key (kbd "C-x <right>") 'pi-resize-window)
(global-set-key (kbd "C-x <left>") 'pi-resize-window)

(provide 'pi-resize-window)
;;; pi-resize-window.el ends here

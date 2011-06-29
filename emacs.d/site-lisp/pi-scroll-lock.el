;; Copyright (c) 2006, Philippe Ivaldi <x@sfr.fr> x = pivaldi
;; Version: $Id: pi-scroll-lock.el,v 0.0 2006/12/06 18:36:51 Philippe Ivaldi Exp $

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
;; 02110-1301, USA.

;; Commentary:
;; By activating pi-scroll-lock-mode, keys for moving point by line or
;; paragraph using some pc-select keys binding (arrow keys only) will
;;  scroll the buffer by the respective amount of lines
;; instead.  Point will be kept vertically fixed relative to window
;; boundaries.
;; Use <Scroll_Lock> key to toggle pi-scroll-lock-mode
;; Amuse with the arrows/next/prior keys and the modifiers Ctrl Shift
;; require `scroll-in-place'

;; THANKS:

;; BUGS:

;; INSTALLATION:
;; Put these lines in your .emacs:
;; (autoload 'pi-scroll-lock-mode "pi-scroll-lock" "Toggle pi-scroll-lock-mode." t)

;; Code:

(eval-when-compile
  (require 'cl))

(require 'scroll-in-place)
(require 'hl-line "hl-line.elc" t)
(require 'easy-mmode)

(defvar pi-scroll-lock-p nil
  "* Internal use. Don't set.")
(defvar pi-scroll-current-hl nil
  "* Internal use. Don't set.")
(defvar pi-scroll-backup-keys nil
  "* Internal use. Don't set.")
(defvar pi-scroll-hl nil
  "* If value is t, enable hl-line-mode when scroll is locked.")

(defvar pi-scroll-lock-mode-map
      (let ((map (copy-keymap (current-global-map))))
        (define-key map (kbd "<up>") 'pi-down-line-nomark)
        (define-key map (kbd "<down>") 'pi-up-line-nomark)
        (define-key map (kbd "<next>") 'pi-scroll-up-nomark)
        (define-key map (kbd "<prior>") 'pi-scroll-down-nomark)
        (define-key map (kbd "<S-next>") 'pi-scroll-up-mark)
        (define-key map (kbd "<S-prior>") 'pi-scroll-down-mark)
        (define-key map (kbd "<S-up>") 'pi-up-line-mark)
        (define-key map (kbd "<S-down>") 'pi-down-line-mark)
        (define-key map (kbd "<C-S-up>") 'pi-backward-paragraph-mark)
        (define-key map (kbd "<C-S-down>") 'pi-forward-paragraph-mark)
        (define-key map (kbd "<C-up>") 'previous-line)
        (define-key map (kbd "<C-down>") 'next-line)
        map)
      "Keymap for pi-scroll-lock-mode.")

;;;###autoload
(define-minor-mode pi-scroll-lock-mode
  "Minor mode for pager-like scrolling.
Arrow keys which normally move point by line or paragraph will scroll
the buffer by the respective amount of lines instead and point
will be kept vertically fixed relative to window boundaries
during scrolling."
  :init-value nil
  :lighter " PiScrLck"
  :keymap pi-scroll-lock-mode-map
  (if pi-scroll-lock-mode
      (progn
        (setq pi-scroll-current-hl hl-line-mode)
        (setq pi-scroll-lock-p t)
        (let ((hl-line-sticky-flag nil))
          (when (and pi-scroll-hl
                     (fboundp 'hl-line-mode))
            (hl-line-mode 1)))
        (message "Scroll lock on.")
	)
    (progn
      (let ((hl-line-sticky-flag nil))
        (if (and pi-scroll-current-hl
                 (fboundp 'hl-line-mode))
            (hl-line-mode 1) (hl-line-mode -1)))
      (message "Scroll lock off.")
      )))

(setq scroll-command-groups
      (list '(pi-scroll-down-nomark pi-scroll-up-nomark pi-scroll-down-mark pi-scroll-up-mark)))

;; From pc-select
(defun pi-ensure-mark()
  ;; make sure mark is active
  ;; test if it is active, if it isn't, set it and activate it
  (or mark-active (set-mark-command nil)))

(defun pi-down-line-nomark ()
  "Scroll down one line."
  (interactive)
  (scroll-down-in-place 1)
  (setq mark-active nil))

(defun pi-up-line-nomark ()
  "Scroll down one line."
  (interactive)
  (scroll-down-in-place -1)
  (setq mark-active nil))

(defun pi-down-line-mark ()
  "Ensure mark is active; move cursor vertically up 1 line."
  (interactive)
  (pi-ensure-mark)
  (scroll-down-in-place -1))

(defun pi-up-line-mark ()
  "Ensure mark is active; move cursor vertically down 1 line."
  (interactive)
  (pi-ensure-mark)
  (scroll-down-in-place 1))

(defun pi-scroll-down-nomark (LINES)
  "Scroll the text of the current window downward by LINES lines, leaving point
as close as possible to its current window position (window line and column) with the mark unactived."
  (interactive "P")
  (scroll-down-in-place LINES)
  (setq mark-active nil))

(defun pi-scroll-up-nomark (LINES)
  "Scroll the text of the current window upward by LINES lines, leaving point
as close as possible to its current window position (window line and column)."
  (interactive "P")
  (scroll-up-in-place LINES)
  (setq mark-active nil))

(defun pi-scroll-down-mark (LINES)
  "Scroll the text of the current window downward by LINES lines, leaving point
as close as possible to its current window position (window line and column)."
  (interactive "P")
  (pi-ensure-mark)
  (scroll-down-in-place LINES))

(defun pi-scroll-up-mark (LINES)
  "Scroll the text of the current window downward by LINES lines, leaving point
as close as possible to its current window position (window line and column)."
  (interactive "P")
  (pi-ensure-mark)
  (scroll-up-in-place LINES))

(defun pi-forward-paragraph-mark ()
  "Ensure mark is active; move forward to end of paragraph."
  (interactive)
  (let ((lte (line-number-at-pos))
        (pt (point))
        (ltb (progn
               (forward-paragraph)
               (line-number-at-pos))))
    (goto-char pt)
    (pi-ensure-mark)
    (scroll-down-in-place (- lte ltb))))

(defun pi-backward-paragraph-mark ()
  "Ensure mark is active; move backward to end of paragraph."
  (interactive)
  (let ((lte (line-number-at-pos))
        (pt (point))
        (ltb (progn
               (backward-paragraph)
               (line-number-at-pos)))
        )
    (goto-char pt)
    (pi-ensure-mark)
    (scroll-down-in-place (- lte ltb))))

(global-set-key (kbd "<Scroll_Lock>") 'pi-scroll-lock-mode)


(provide 'pi-scroll-lock)
;;; pi-scroll-lock.el ends here

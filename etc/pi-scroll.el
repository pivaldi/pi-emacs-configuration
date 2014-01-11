;; -------------------
;; * scroll-in-place *
;; scroll-in-place is a package that keeps the cursor on the same line
;; (and in the same column) when scrolling by a page using PgUp/PgDn.
;; (require 'scroll-in-place)
(defun scroll-move-up ()
  "* Scroll up without scroll-in-place."
  (interactive)
  (let ((scroll-preserve-screen-position t))
    (scroll-up 1)))
(defun scroll-move-down ()
  "* Scroll down without scroll-in-place."
  (interactive)
  (let ((scroll-preserve-screen-position t))
    (scroll-down 1)))
(global-set-key (kbd "<C-M-up>") 'scroll-move-up)
(global-set-key (kbd "<C-M-down>") 'scroll-move-down)

;; ----------------------------------
;; * naviguer dans une ligne longue *
;; C-up et C-down pour naviguer dans une ligne longue.
;; En plus le curseur reste immobile (en fait c'est un scroll!).
(defun move-one-up ()
  (interactive)
  (let ((line-move-visual nil))
    (previous-line)))
(defun move-one-down ()
  (interactive)
  (let ((line-move-visual nil))
    (next-line)))
(global-set-key (kbd "<C-up>") 'move-one-up)
(global-set-key (kbd "<C-down>") 'move-one-down)

;; Local variables:
;; coding: utf-8
;; End:

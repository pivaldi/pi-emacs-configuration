;; From http://www.emacswiki.org/cgi-bin/wiki/JumpToPrevPos
(defvar jtpp-prev-pos-stack nil
  "Stack of previous positions.")
(make-variable-buffer-local 'jtpp-prev-pos-stack)

(defvar jtpp-next-pos-stack nil
  "Stack of next positions.")
(make-variable-buffer-local 'jtpp-next-pos-stack)

(defvar jtpp-stack-depth 16
  "*Stack depth for jump-to-prev-pos.")

(defun jtpp-remember-position ()
  (unless (or (equal (point) (car jtpp-prev-pos-stack))
              (equal this-command 'jump-to-prev-pos)
              (equal this-command 'jump-to-next-pos))
    (setq jtpp-next-pos-stack nil)
    (setq jtpp-prev-pos-stack (cons (point) jtpp-prev-pos-stack))
    (when (> (length jtpp-prev-pos-stack) jtpp-stack-depth)
      (nbutlast jtpp-prev-pos-stack))))
(add-hook 'pre-command-hook 'jtpp-remember-position)

(defun jump-to-prev-pos ()
  "Jump to previous position."
  (interactive)
  (when jtpp-prev-pos-stack
    (goto-char (car jtpp-prev-pos-stack))
    (setq jtpp-prev-pos-stack (cdr jtpp-prev-pos-stack))
    (setq jtpp-next-pos-stack (cons (point) jtpp-next-pos-stack))))

(defun jump-to-next-pos ()
  "Jump to next position."
  (interactive)
  (when jtpp-next-pos-stack
    (goto-char (car jtpp-next-pos-stack))
    (setq jtpp-next-pos-stack (cdr jtpp-next-pos-stack))
    (setq jtpp-prev-pos-stack (cons (point) jtpp-prev-pos-stack))))

(provide 'jumptoprevpos)
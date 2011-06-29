(require 'thingatpt)

(defface auto-search-face
  '((t (:weight bold :underline "orange")))
  "")

(defvar auto-search nil)

(defvar auto-search-timer-interval 0.5)

(defvar auto-search-threshold 3)

(defvar auto-search-timer nil)

(defvar auto-search-regexp nil)

(defvar auto-search-overlays nil)

(defun auto-search-clean ()
  (setq auto-search-regexp nil)
  (mapc 'delete-overlay auto-search-overlays)
  (setq auto-search-overlays nil))

(defun auto-search-update ()
  (auto-search-clean)
  (if (and auto-search (not (minibufferp (current-buffer))))
      (let ((symbol (thing-at-point 'symbol)))
        (if (and symbol (>= (length symbol) auto-search-threshold))
            (let ((start (window-start))
                  (end (window-end))
                  overlay)
              (setq auto-search-regexp (regexp-quote symbol))
              (save-excursion
                (goto-char start)
                (while (re-search-forward auto-search-regexp end t)
                  (setq overlay (make-overlay (match-beginning 0) (match-end 0)))
                  (overlay-put overlay 'face 'auto-search-face)
                  (push overlay auto-search-overlays))))
          (setq auto-search-regexp nil)))))

(defun auto-search-next ()
  (interactive)
  (let ((point (point)))
    (forward-char)
    (if (and auto-search-regexp
             (re-search-forward auto-search-regexp nil t))
        (goto-char (match-beginning 0))
      (goto-char point))))

(defun auto-search-previous ()
  (interactive)
  (let ((point (point)))
    (while (and auto-search-regexp
                (re-search-backward auto-search-regexp nil t)
                (> (match-end 0) point)))))

(unless auto-search-timer
  (setq auto-search-timer (run-with-idle-timer auto-search-timer-interval t 'auto-search-update)))

(provide 'auto-search)

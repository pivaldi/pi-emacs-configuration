;;; Philippe Ivaldi http://www.piprime.fr/
;;; $Last Modified on 2011/06/13

(eval-when-compile
  (require 'cl))

;; http://www.emacswiki.org/emacs/HtmlModeDeluxe
;;;###autoload
(defun pi-save-mmm-c-locals ()
  (with-temp-buffer
    (php-mode)
    (dolist (v (buffer-local-variables))
      (when (string-match "\\`c-" (symbol-name (car v)))
        (add-to-list 'mmm-save-local-variables `(,(car v) nil ,mmm-c-derived-modes))))))

;; http://compgroups.net/comp.emacs/filling-a-string/244364
;;;###autoload
(defun pi-wrap-string (s &optional width)
  "* make a string fit in `s' columns"
  (with-temp-buffer
    (insert s)
    (let ((fill-column (or width fill-column)))
      (fill-region (point-min) (point-max)))
    (buffer-string)))


;;;###autoload
(defun xpdf()
  "* Pour voir le .pdf associé au buffer avec xpdf."
  (interactive)
  (let ((tcom (concat "xpdf -z page "  (file-name-sans-extension (buffer-file-name)) ".pdf &")))
    (if (buffer-modified-p) (save-buffer))
    (shell-command tcom)))

;;;###autoload
(defun acro()
  "* Pour voir le .pdf associé au buffer avec acroread."
  (interactive)
  (let ((tcom (concat "acroread "  (file-name-sans-extension (buffer-file-name)) ".pdf &")))
    (if (buffer-modified-p) (save-buffer))
    (shell-command tcom)))

;;;###autoload
(defun gv()
  "* Pour voir le .pdf associé au buffer avec acroread."
  (interactive)
  (let ((tcom (concat "gv "  (file-name-sans-extension (buffer-file-name)) ".pdf &")))
    (if (buffer-modified-p) (save-buffer))
    (shell-command tcom)))

;;;;;;;;;;;;;;;;;;;;

;;;###autoload
(defun pi-revert-all-buffers ()
  "Refreshes all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
         (buffer (car list)))
    (while buffer
      (when (and (buffer-file-name buffer)
                 (not (buffer-modified-p buffer)))
        (set-buffer buffer)
        (revert-buffer t t t))
      (setq list (cdr list))
      (setq buffer (car list))))
  (message "Refreshed open files"))

;; Author: David Biesack (David.Biesack@sas.com  or biesack@mindspring.com)
(defvar scissors "8<------"
  "string to insert in \\[separe]")

;;;###autoload
(defun separe ()
  "Insert a line of SCISSORS in the buffer"
  (interactive)
  (or (bolp) (beginning-of-line 2))
  (while (<= (current-column) (- (or fill-column 70) (length scissors)))
    (insert scissors))
  (newline))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ----------------------------------------------
;; * Retourne le code pour définir un raccourci *
;;;###autoload
(defun moy-insert-set-key (key function)
  "Retourne le code pour définir un raccourci.
Auteur: Matthieu MOY."
  (interactive "kKey to bind:
aFunction to bind: ")
  (insert "(global-set-key (kbd \"" (key-description key) "\") '"
          (symbol-name function) ")"))

;; ;; ------------------------
;; ;; * LaTeX vers ascii-art *
;; ;;;###autoload
;; (defun textomail-region (beginr endr)
;;   ;;Convertir la région de LaTeX en ascii-art
;;   (interactive "r")
;;   (write-region beginr endr "~/textomail" nil nil)
;;   (kill-region beginr endr)
;;   (insert (shell-command-to-string "perl /home/pi/bin/tex2mail ~/textomail")))

;; ------------------------------------------
;; * Increments any numbers found in a line *
;; From ;;http://www.emacswiki.org/cgi-bin/wiki/IncrementNumber
;;;###autoload
(defun pi-increment-number-line (num-lines)
  "Copies line, preserving cursor column, and increments any numbers found.
  Copies a block of optional NUM-LINES lines.  If no optional argument is given,
  then only one line is copied."
  (interactive "p")
  (if (not num-lines) (setq num-lines 0) (setq num-lines (1- num-lines)))
  (let* ((col (current-column))
         (bol (save-excursion (forward-line (- num-lines)) (beginning-of-line) (point)))
         (eol (progn (end-of-line) (point)))
         (line (buffer-substring bol eol)))
    (goto-char bol)
    (while (re-search-forward "[0-9]+" eol 1)
      (let ((num (string-to-number (buffer-substring
                                    (match-beginning 0) (match-end 0)))))
        (replace-match (int-to-string (1+ num))))
      (setq eol (save-excursion (goto-char eol) (end-of-line) (point))))
    (goto-char bol)
    (insert line "\n")
    (move-to-column col)))

;; http://www.emacswiki.org/emacs/IncrementNumber
;;;###autoload
(defun pi-increment-number-decimal (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))
(defun pi-decrement-number-decimal (&optional arg)
  (interactive "p*")
  (my-increment-number-decimal (if arg (- arg) -1)))

(global-set-key (kbd "C-c +") 'pi-increment-number-decimal)
(global-set-key (kbd "C-c -") 'pi-decrement-number-decimal)

(defconst pi-last-modified-date-prefix
  "$Last Modified on "
  "This string is inserted immediately before the date.")

;; From http://guillaume.salagnac.free.fr/monoeuvre/geek/dotfiles/showfile.php?file=.emacs
(defun pi-last-modified-date (&optional force)
  "Update a file last-modified-date line."
  (interactive "P*")
  (save-excursion
    (beginning-of-buffer)
    (let ((regex (concat ".+ " pi-last-modified-date-prefix "\\w")))
      (when (or force (search-forward-regexp regex nil t))
        (progn
          (search-backward-regexp regex nil t))
        (if force
            (progn
              (insert "\n")
              (previous-line)
              (insert pi-last-modified-date-prefix (format-time-string "%Y/%m/%d"))
              (comment-region 0 (point)))
          (progn
            (let ((date-start (+ 2 (point))))
              (end-of-line)
              (delete-region date-start (point))
              (insert pi-last-modified-date-prefix (format-time-string "%Y/%m/%d %H:%M:%S")))))))))

(global-set-key (kbd "<f11>") 'pi-last-modified-date)

(defun pi-insert-str-at-end-of-line (str)
  (save-excursion
    (end-of-line)
    (if (not (char-equal (char-before) (string-to-char str))) (insert str))
    ))

(defun pi-insert-semicol-at-end-of-line  nil
  (interactive)
  (pi-insert-str-at-end-of-line ";"))
(defun pi-insert-comma-at-end-of-line nil
  (interactive)
  (pi-insert-str-at-end-of-line ","))

(defun pi-flyspell-force-bind-key-insert-str-at-end-of-line (key f)
  ""
  (let ((kkey (read-kbd-macro key)))
    (local-unset-key kkey)
    (local-set-key kkey '(lambda nil (interactive) (funcall f)))
    (if (boundp 'flyspell-mode-map)
        (define-key flyspell-mode-map
          kkey '(lambda nil (interactive) (funcall f))))))

(provide 'pi-functions)
;; Local variables:
;; coding: utf-8
;; End:

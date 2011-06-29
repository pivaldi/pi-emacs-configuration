;; ------------------------------------------------
;; * Permutation aléatoire de lettres ds un texte *
;; Sélectionner un texte et M-x scramble-region <RET>
;; Auteur: http://christophe.deleuze.free.fr/emacs.html
(defun create-permutation (n)
  "Return as a vector a permutation of the first n integers (including 0)."
  (defun swap (vec i j)
    (let ((vec_i (aref vec i)))
      (aset vec i (aref vec j))
      (aset vec j vec_i)))

  (let ((prmt (make-vector n 0)) i)
    (dotimes (i n) (aset prmt i i))
    (dotimes (i n) (swap prmt (random n) (random n)))
    prmt))

;;;###autoload
(defun scramble-word (&optional arg)
  "Randomly permute non-border letters in word at point."
  (interactive "P")
  (let* ((bow (progn (backward-word 1) (point)))
	 (eow (progn (forward-word 1) (point)))
	 (word (buffer-substring (1+ bow) (1- eow)))
	 (len  (length word))
	 (prmt (create-permutation len))
	 (rslt (make-string len ?a))
	 i)
    (if (< len 2) ()
      (dotimes (i len)
	(aset rslt i (aref word (aref prmt i))))
      (goto-char (1+ bow))
      (delete-char len)
      (insert rslt)
      (forward-word 1))))

;;;###autoload
(defun scramble-region (beg end)
  "Randomly permute non-border letters of words in region."
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (while (< (point) end)
      (scramble-word)
      (forward-word 1))))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Local variables:
;; coding: utf-8
;; End:

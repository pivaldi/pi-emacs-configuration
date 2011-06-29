;; -----------------------------------------
;; * Conversion d'expressions parenthésées *
;; Par exemple, sélectionner la ligne:
;; (a + b * (c + d* (e + f))) - a * (c + d (e + f))
;; M-x pi-exp-paren-region <RET> produit:
;; \Big(a + b * \big(c + d* (e + f)\big)\Big) - a * \big(c + d (e + f)\big)
(defun pi-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis."
  ;;  (interactive "p")
  (cond ((looking-at "[([{]") (forward-sexp 1) (backward-char))
	((looking-at "[])}]") (forward-char) (backward-sexp 1))
	(t )))

(defun pi-paren-depth-at-point (begin)
  ;;Retourne la profondeur du point dans les parenthèses
  (save-excursion
    (let ((thedepth -1) (notbegin t))
      (if (eq ?\) (char-after (point)))
	  (backward-char 1))
      (while (and (>= (point) begin) notbegin) ;;Problème avec le début
	;;du buffer
	(if (eq ?\( (char-after (point)))
	    (incf thedepth)
	  (if (eq ?\) (char-after (point)))
	      (decf thedepth)))
	(if (not (bobp)) (backward-char 1) (setq notbegin nil))
	)
      thedepth)))

(defun pi-paren-max-depth-region (beginr endr)
  ;;Retourne le profondeur maximale des parenthèses de la région
  (interactive "r")
  (save-excursion
    (let ((max-depth 0) (curr-depth 0))
      (goto-char beginr)
      (while (and (< (point) endr) (re-search-forward "(" nil t 1))
	(setq curr-depth (pi-paren-depth-at-point beginr))
	(if (> curr-depth max-depth)
	    (setq max-depth curr-depth)))
      max-depth)))

(defvar pi-mm-paren-list '("" "\\big" "\\Big" "\\bigg" "\\Bigg"))

(defun pi-match-paren-point ()
  (let ((pos 0))
    (pi-match-paren 1)
    (setq pos (point))
    (pi-match-paren 1)
    pos))

;;;###autoload
(defun pi-exp-paren-region (beginr endr)
  "Convertit la région avec les \big"
  (interactive "r")
  (let ((list pi-mm-paren-list) (maxdepth 0) (paren-size 0))
    (narrow-to-region beginr endr)
    (goto-char beginr)
    (when (re-search-forward "(*)" nil t 1)
      (setq maxdepth (pi-paren-max-depth-region beginr endr)) ;;Prof max
      (if (< maxdepth 5)
	  (progn
	    (goto-char beginr)
	    (while (re-search-forward "(" nil t 1)
	      (backward-char 1)
	      (setq paren-size (pi-paren-max-depth-region (point) (pi-match-paren-point)))
	      (insert (nth paren-size list))
	      (pi-match-paren 1)
	      (insert (nth paren-size list))
	      (pi-match-paren 1)
	      (forward-char 1)
	      ))
	(message "Profondeur maximale dépassée..."))
      (widen) ;;En cas de pb C-x n w
      )))

;; Local variables:
;; coding: utf-8
;; End:

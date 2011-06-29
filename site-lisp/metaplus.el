;;; -*- mode: Emacs-Lisp; coding: iso-8859-15 -*-
;;; metaplus.el
;;; a mode for metapost and metafont
;;; extending meta-mode.el
;;;
;;; le TeXnicien de surface, metapostier urbain
;;; beginning 2004-03-04

;;; pour utiliser metapost dans emacs avec un menu et tout ça
;;; works in progress

;;;(require 'meta-mode)


(defcustom meta-condition-ending ": "
  "*Default string to mark end of condition in for-endfor loop"
  :group 'meta-environment
  :type 'string)

(defcustom meta-endfor-str "endfor; "
  "*Default string to mark end of condition in for-endfor loop"
  :group 'meta-environment
  :type 'string)

(defcustom meta-endfor-alt-str "endfor "
  "*Default alternate string to mark end of condition in for-endfor loop"
  :group 'meta-environment
  :type 'string)

(defcustom meta-upto-str " upto "
  "*Default string to mark 'upto' "
  :group 'meta-environment
  :type 'string)

(defcustom meta-downto-str " downto "
  "*Default string to mark 'downto' "
  :group 'meta-environment
  :type 'string)

(defcustom meta-exitif-str " exitif "
  "*Default string to mark 'exitif' "
  :group 'meta-environment
  :type 'string)

(defcustom meta-exitunless-str " exitunless "
  "*Default string to mark 'exitunless' "
  :group 'meta-environment
  :type 'string)

(defvar re-list-word-to-jump
  (regexp-opt '("if " "else " "elseif " ": " "fi;" "fi " "endfor " 
		"endfor;" "upto " "downto " "step " "until "
		"for " "forever " "exitif " "exitunless "
		"forsuffixes " "etex,"))
"list of meta words to be jumped over with meta-jump-over")


;;;; à revoir, peut-être utiliser une liste déjà constituée
;;;; dans meta-mode.el mais pb

(defvar fig-num-prop "1"
  "number of the first figure, used by meta-insert-fig")
;;; il faudra bouger la fonction pour qu'elle ne soit qu'en metapost
;;; et fournir un équivalent pour metafont

(defvar fig-numbers-list nil
  "points to the history list of figures numbers
keeps track of the already used numbers.")
(defvar garbagge-history nil
  "points to the history list of points coordinates should be void almost always")

(defun string-incr(strnb)
  "Add 1 to the number given as a string."
  (number-to-string (1+ (string-to-number strnb))))

(defun insert-barto(barto  valeur)
  (insert barto valeur meta-condition-ending))

(defun seq-with-barto(barto)
  (let ((to-val (read-string "to: ")))
    (insert-barto barto  to-val)))

(defun seq-with-to-step()
  (let ((step-val (read-string "step: "))
	(to-val (read-string "until: ")))
    (insert " step  " step-val " until " to-val  meta-condition-ending)))

(defun seq-with-commas()
  (let ((next-val-p "a"))
    (while  next-val-p
      (let ((next-val (read-string "next value: ")))
	(cond ((zerop (length next-val)) (setq next-val-p nil))
	      (t (insert ", " next-val))))))
  (insert meta-condition-ending))

(defun meta-for-endfor-gen(jump-option ending)
  "General function to insert the for--endfor environment.
jump-option is a boolean and branches to the good sequence.
Asks for 'u', 'd', 's', ',' or an number to determine the kind
of loop desidered; respectively with upto, downto, step ... until, 
with a list of values or upto again."
  (insert "for ")
  (let ((var-name (read-string "variable name: " "i"))
	(from-val (read-string "from: " "0")))
    (insert var-name "=" from-val))
  (let ((sequel-var (read-string "sequel ('u', 'd', 's', ',' or an number): " )))
    (cond ((string-match "^u" sequel-var) (seq-with-barto meta-upto-str))
	  ((string-match "[[:digit:]+]" sequel-var) 
	   (insert-barto meta-upto-str sequel-var))
	  ((string-match "^d" sequel-var) (seq-with-barto meta-downto-str))
	  ((string-match "^s" sequel-var) (seq-with-to-step))
	  ((string-match "^," sequel-var) (seq-with-commas))))
  (cond (jump-option (newline) (newline))
	(t (insert "  ")))
  (if ending
      (insert meta-endfor-alt-str)
    (insert meta-endfor-str))
  (indent-according-to-mode)
  (cond (jump-option (forward-line -1))
	(t (forward-char -9)))
  (indent-according-to-mode))

(defun meta-forever-loop-gen(jump-option ending)
  "General function to insert the forever loop environement
jump-option is a boolean and branches to the good sequence.
It asks for 'u', 'i'  or nil to determine if it needs
to put an 'exitunless', 'exitif' or nothing respectively."
  (insert "forever" meta-condition-ending)
  (when jump-option (newline-and-indent))
  (let* ((middle-name (read-string "'i' for 'exitif', 'u' for 'exitunless', RET for nothing: "))
	 (middle-p (not (zerop (length middle-name)))))
    (cond ((string-match "^i" middle-name)
	   (insert "exitif   ; ")
	   (when jump-option (newline-and-indent)))
	  ((string-match "^u" middle-name)
	   (insert "exitunless   ; ")
	   (when jump-option (newline-and-indent)))
	  (t nil))
    (when (not jump-option) (insert "  "))
    (if ending
	(insert meta-endfor-alt-str)
      (insert meta-endfor-str))
    (indent-according-to-mode)
    (re-search-backward (regexp-quote "forever"))
    (cond (middle-p (re-search-forward (regexp-opt '("exitif " "exitunless "))))
	  (t (re-search-forward (regexp-quote ": "))))))

(setq meta-common-mode-hook
      '(lambda nil
	 (defun meta-insert-brackets ()
	   (interactive)
	   (insert "()")
	   (forward-char -1))
	 (defun meta-insert-square-brackets ()
	   (interactive)
	   (insert "[]")
	   (forward-char -1))
	 (defun meta-insert-betex ()
	   (interactive)
	   (insert "btex  etex, ")
	   (forward-char -7))
	 (defun meta-insert-braces ()
	   (interactive)
	   (insert "{}")
	   (forward-char -1))
	 (defun meta-insert-point-defn ()
	   (interactive)
	   (let ((point-id (read-string "point id: " "" 'point-ids-history "" t)))
;;; pour la gestion de la liste d'historique
;;; passer 'point-ids-history et pas point-ids-history (vu le ' ?)
;;; solution par Boris Smilga <smilga@irin-univ-nantes.fr> sur <<fr.comp.lang.lisp>>
   	     (if (string-match "[[:digit:]]+" point-id)
   		 (setq mpost-point-id point-id)
   	       (if (string-match "^\\[" point-id)
		   (setq mpost-point-id (concat point-id "]"))
		 (setq mpost-point-id (concat "." point-id))))
	     (insert "z" mpost-point-id))
	   (let ((x-value (read-string "x-value: " "" 'garbagge-history "" t))
		 (y-value (read-string "y-value: " "" 'garbagge-history "" t)))
	     (insert "=(" x-value ", " y-value ");")))
	 (defun meta-insert-parentheses ()
	   (interactive)
	   (insert "(,);")
	   (forward-char -3))
	 (defun meta-insert-fig ()
	   (interactive)
	   (newline)
	   (setq point-ids-history nil)
	   (let ((fig-number (read-string "figure number: " fig-num-prop)))
	     (insert "beginfig(" fig-number ")")
	     (setq fig-numbers-list (cons fig-number fig-numbers-list))
	     (setq fig-num-prop (string-incr fig-number)))
	   (newline)
	   (newline)
	   (insert "endfig;")
	   (forward-line -1)
	   (indent-according-to-mode))
	 (defun meta-insert-def-enddef()
	   (interactive)
	   (newline)
	   (insert "def () =")
	   (dotimes (i 2)
	     (newline)
	     (indent-according-to-mode))
	   (insert "enddef;")
	   (forward-line -4)
	   (forward-char 5))
	 (defun meta-insert-group()
	   (interactive)
	   (insert "begingroup")
	   (meta-indent-line)
	   (newline)
	   (newline)
	   (insert "endgroup")
	   (meta-indent-line)
	   (forward-line -1)
	   (forward-char 0)
	   (meta-indent-line))
	 (defun meta-For-upto-endfor(&optional ending)
	   "Insert a for-endfor loop with newline"
	   (interactive "P")
	   (meta-for-endfor-gen t ending))
	 (defun meta-for-upto-endfor(&optional ending)
	   "Insert a for-endfor loop on the same line"
	   (interactive "P")
	   (meta-for-endfor-gen nil ending))
	 (defun meta-Forever-endfor(&optional ending)
	   "Insert a for-endfor loop with newline"
	   (interactive "P")
	   (meta-forever-loop-gen t ending))
	 (defun meta-forever-endfor(&optional ending)
	   "Insert a for-endfor loop on the same line"
	   (interactive "P")
	   (meta-forever-loop-gen nil ending))
	 (defun meta-jump-over()
	   "Jump over some words defined in re-list-word-to-jump 
but does not leave the enclosing figure environment"
	   (interactive)
	   (save-excursion 
	     (re-search-forward "endfig" nil t))
	   (re-search-forward re-list-word-to-jump (match-beginning 0)  t))
      (define-key meta-mode-map "\C-c(" 'meta-insert-brackets)
      (define-key meta-mode-map "\C-c[" 'meta-insert-square-brackets)
      (define-key meta-mode-map "\C-cT" 'meta-insert-betex)
      (define-key meta-mode-map "\C-c{" 'meta-insert-braces)
      (define-key meta-mode-map "\C-cz" 'meta-insert-point-defn)
      (define-key meta-mode-map "\C-cp" 'meta-insert-parentheses)
      (define-key meta-mode-map "\C-cF" 'meta-insert-fig)
      (define-key meta-mode-map "\C-c\C-d" 'meta-insert-def-enddef)
      (define-key meta-mode-map "\C-c\C-g" 'meta-insert-group)
      (define-key meta-mode-map "\C-c\C-mF" 'meta-For-upto-endfor)
      (define-key meta-mode-map "\C-c\C-mf" 'meta-for-upto-endfor)
      (define-key meta-mode-map "\C-c\C-j" 'meta-jump-over) 
      (define-key meta-mode-map "\C-c\C-mV" 'meta-Forever-endfor)
      (define-key meta-mode-map "\C-c\C-mv" 'meta-forever-endfor)
))

;;; de David Cobac, recupéré sur <<fr.comp.applications.emacs>>

(defun mpost-compile ()
  (interactive)
  (save-buffer)
  (shell-command (format mpost-compile-command buffer-file-name)))

(defvar mpost-compile-command "mpost %s")

(add-hook 'metapost-mode-hook
	  '(lambda nil
	     (define-key meta-mode-map "\C-c\C-c" 'mpost-compile)))

(autoload 'metafont-mode "meta-mode" "Metafont editing mode." t)
(autoload 'metapost-mode "meta-mode" "MetaPost editing mode." t)

(provide 'metaplus)

;; Un mot de commentaire :
;; les macros pour for endfor et if fi s'obtiennent avec \C-c\C-m puis f ou F (for), 
;; v ou V (forever), i ou I (if). Les versions avec majuscules donnent des sauts de ligne.
;; En tapant \C-u avant \C-c\C-m etc, on obtient la finale donnée par la chaine de
;; caractères meta-machin-alt-str à la place de metat-machin-str, machin valant ici
;; soit endfor soit fi.
;;: -*- emacs-lisp -*-
;;; pi-tex.el
;;; Author: Philippe Ivaldi
;;; Last modified: Mon Jul  2 23:41:54 CEST 2007

(eval-when-compile
  (require 'cl))

;; *=======================================================*
;; *.........................LaTeX.........................*
;; *=======================================================*

;; ------------------------
;; * Activation de AucTeX *
(require 'tex-site)

;; ------------------------
;; * Paramétrage d'AucTeX *
(eval-after-load "latex"
  '(progn
     ;; In order to get support for many of the LaTeX packages you will use
     ;;in your documents, you should enable document parsing as well, which
     ;;can be achieved by putting
     (setq
      TeX-auto-default (concat (cuid "auctex-auto_") (user-real-login-name))
      TeX-auto-save nil
      TeX-parse-self t)

     (setq LaTeX-verbatim-environments
           (append
            (list "Verbatim" "BVerbatim" "phpcode" "sqlcode" "xmlcode" "htmlcode" "htmlcode*"
                  "Vcolor" "lstlisting" "minted"
                  "phpcode*" "sqlcode*" "xmlcode*" "Vcolor*" "lstlisting*" "minted*")
            LaTeX-verbatim-environments))
     ;; When non-nil AUCTeX will automatically display a help text whenever
     ;; an error is encountered using TeX-next-error (C-c `).
     (setq TeX-display-help t)
     ;; Don't show output of TeX compilation in other window
     (setq TeX-show-compilation nil)
     ;; Pas de confirmation pour sauvegarder avant compilation
     (setq TeX-save-query nil)))

;; Essayer dans un fichier LaTeX enu<f3>.
(load "pi-tempo-latex")

;; ---------------------------------------------------
;; * Commandes appelées à chaque ouverture d'un .tex *
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (LaTeX-math-mode)
            (imenu-add-menubar-index) ;; Ajoute un menu index
            (when (fboundp 'flyspell-mode)
              (flyspell-mode 1))
            (turn-on-reftex) ;; reftex pour AUCTeX LaTeX mode
            (when (fboundp 'paren-activate)
              (paren-toggle-matching-quoted-paren 1)
              (paren-toggle-matching-paired-delimiter 1))
            ))

;; ---------------------
;; * LaTeX en WYSIWYG! *
;; http://cristal.inria.fr/whizzytex/
(when (require 'whizzytex "whizzytex.elc" t)
  ;; M-x whizzytex-mode pour activer
  (setq-default whizzy-viewers '(("-advi" "advi -edit -html Start-Document")
                                 ("-dvi" "xdvi")
                                 ("-ps" "gv")
                                 ("-pdf" "xpdf"))))

;; ----------------------
;; * Raccourcis clavier *
(eval-after-load "latex"
  '(progn
     (when (locate-library "asy-mode")
       ;; Je veux les raccourcis de asy-mode même en latex-mode.
       (define-key LaTeX-mode-map (kbd "<C-return>") 'lasy-view-ps)
       (define-key LaTeX-mode-map (kbd "<C-S-return>") 'asy-master-tex-view-ps-f)
       (define-key LaTeX-mode-map (kbd "<M-return>") 'lasy-view-pdf-via-pdflatex)
       (define-key LaTeX-mode-map (kbd "<M-S-return>") 'asy-master-tex-view-pdflatex-f)
       (define-key LaTeX-mode-map (kbd "<C-M-return>") 'lasy-view-pdf-via-ps2pdf)
       (define-key LaTeX-mode-map (kbd "<C-M-S-return>") 'asy-master-tex-view-ps2pdf-f))

     ;; Gestion des paires.
     (setq skeleton-pair t)
     (when pi-use-skeleton-pair-insert-maybe
       (define-key LaTeX-mode-map "\$" 'skeleton-pair-insert-maybe)
       (define-key LaTeX-mode-map "\{" 'skeleton-pair-insert-maybe)
       (define-key LaTeX-mode-map "\(" 'skeleton-pair-insert-maybe)
       (define-key LaTeX-mode-map "["
       (lambda ()
         (interactive)
         (if (and
              (string= "\\" (char-to-string (char-before)))
              (not (string= "\\" (char-to-string (char-before (- (point) 1))))))
             (progn
               (insert "[\\]")(backward-char 2))
           (skeleton-pair-insert-maybe 1)))))


     ;; Completion avec ESC-Tab
     (define-key LaTeX-mode-map (kbd "M-TAB") 'TeX-complete-symbol)

     (define-key LaTeX-mode-map (kbd "C-$")
       '(lambda ()
          (interactive)
          (insert "$")))

     (define-key LaTeX-mode-map (kbd "M-{")
       (lambda ()
         (interactive)
         (insert "{")))

     (define-key LaTeX-mode-map (kbd "M-(")
       (lambda ()
         (interactive)
         (insert "(")))

     (define-key LaTeX-mode-map (kbd "M-[")
       (lambda ()
         (interactive)
         (insert "[")))

     (put 'TeX-insert-backslash 'delete-selection t)
     (put 'TeX-insert-punctuation 'delete-selection t)
     (define-key LaTeX-mode-map (kbd "²")
       (lambda ()
         "Insère '\\' à la place de '²'"
         (interactive)
         (setq last-command-char (string-to-char "\\"))
         (TeX-insert-backslash 1)))
     (define-key LaTeX-mode-map (kbd "C-*")
       (lambda ()
         (interactive)
         (insert "\\times{}")))
     ;; ---------------------------
     ;; * Indentation automatique *
     (define-key LaTeX-mode-map "\C-m"
       (lambda()
         (interactive)
         (newline)
         (indent-for-tab-command)))

     ;; In math mode _ inserts _{*} and ^ inserts ^{*}
     ;;      where *=cursor. It's very useful
     (if (require 'texmathp "texmathp.elc" t)
         (progn
           (define-key LaTeX-mode-map [(^)] (lambda ()
                                              (interactive)
                                              (if (texmathp)
                                                  (progn
                                                    (insert "^{}")
                                                    (backward-char))
                                                (insert "^"))))

           (define-key LaTeX-mode-map [(_)] (lambda ()
                                              (interactive)
                                              (if (texmathp)
                                                  (progn
                                                    (insert "_{}")
                                                    (backward-char))
                                                (insert "_")))))
       (progn
         (message "texmathp not find...")))))

(message "pi-tex.el(c) is loaded")
;; Local variables:
;; coding: utf-8
;; End:

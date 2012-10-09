;; --------------------------------------------------
;; * Asymptote pour créer des figures scientifiques *
;; http://asymptote.sourceforge.net/
(when (locate-library "asy-mode")
  (require 'asy-mode)
  (load "pi-tempo-asy")
;;;   (setq lasy-ps2pdf-command "ps2pdf14 -dPDFSETTINGS=/prepress -dAutoFilterGrayImages=false -dAutoFilterColorImages=false -dColorImageFilter=/FlateEncode -dGrayImageFilter=/FlateEncode -dAutoRotatePages=/None")
  (setq lasy-ps2pdf-command "ps2pdf14")
  (setq lasy-pdflatex-command "latexmk -pdf")
  (setq lasy-latex-command "latexmk -ps")

  (setq asy-compilation-buffer 'none)
  ;; Mes variables perso pour la coloration en asy-mode
  (setq asy-command "LC_NUMERIC=\"french\" asy -V")
  ;; Permet d'avoir les raccourcis de lasy-mode dans AucTeX.
  ;; (setq lasy-extra-key nil)
  (eval-after-load "asy-mode"
    '(progn
       (when (featurep 'etags)
         (define-key asy-mode-map (kbd "<f1> RET")
           (lambda ()
             "Génère le fichier de TAGS pour Asymptote."
             (interactive)
             (shell-command "etags -l c++ *.asy"))))

       ;; Gestion des paires ", ', {, [, (
       (when pi-use-skeleton-pair-insert-maybe
         (define-key asy-mode-map "\"" 'skeleton-pair-insert-maybe)
         (define-key asy-mode-map "\'" 'skeleton-pair-insert-maybe)
         (define-key asy-mode-map "\{" 'skeleton-pair-insert-maybe)
         (define-key asy-mode-map "\[" 'skeleton-pair-insert-maybe))
       ;; (define-key asy-mode-map "\(" 'skeleton-pair-insert-maybe)
       ;; mets des paires de () -avec le ; après si fin de ligne-.
       (define-key asy-mode-map "\("
         (lambda ()
           (interactive)
           (let* ((beg (save-excursion (beginning-of-line)(point)))
                  (pt (point))
                  (exclude (list (list "if" (- pt 2))
                                 (list "^ *\\<\\w+\\> \\<\\w+\\>" beg)))
                  lp op)
             (if (and
                  (or (not (char-after)) (string= (char-to-string (char-after)) "\n"))
                  (progn
                    (setq lp (pop exclude))
                    (while (and (not op) lp)
                      (setq op (save-excursion
                                 (re-search-backward (nth 0 lp) (nth 1 lp) t)))
                      (setq lp (pop exclude)))
                    (not op))
                  (not (or (eq last-command 'mouse-drag-region)
                           (and transient-mark-mode mark-active))))
                 (progn
                   (insert "();")
                   (backward-char-nomark 2))
               (let ((last-command-char (string-to-char "(")))
                 (skeleton-pair-insert-maybe nil))))))

       (add-hook 'asy-mode-hook
                 (lambda ()
                   (setq skeleton-pair 1
                         abbrev-mode nil)))


       ;; Un petit truc pour faire des animations avec Beamer à partir de code .asy
       (defun pi-asy-to-pdf-anime()
         "Compile and view Asymptote file(s) with beamer."
         (interactive)
         (let ((compile-command
                (concat "asy-to-pdf.sh "
                        (file-name-sans-extension (buffer-file-name)))))
           (when (buffer-modified-p) (save-buffer))
           (compile compile-command t)))
       (defun pi-asy-to-pdf()
         "Compile and view Asymptote file(s) with beamer."
         (interactive)
         (let ((compile-command
                (concat "LC_NUMERIC=en_US asy -V -f pdf "
                        (file-name-sans-extension (buffer-file-name)))))
           (when (buffer-modified-p) (save-buffer))
           (shell-command compile-command)))
       (define-key asy-mode-map  (kbd "C-c C-a") 'pi-asy-to-pdf-anime)
       (define-key asy-mode-map  (kbd "C-c C-p") 'pi-asy-to-pdf)
       (define-key asy-mode-map (kbd "RET") 'newline-and-indent))))
;; Local variables:
;; coding: utf-8
;; End:

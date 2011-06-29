;; -----------------------
;; * Calculs avec Scilab *
(when (locate-library "scilab")
  (load "scilab")
  (setq auto-mode-alist (cons '("\\(\\.sci$\\|\\.sce$\\)" . scilab-mode) auto-mode-alist))
  (setq scilab-mode-hook '(lambda () (setq fill-column 74)))
  (defun pi-scilab-compile ()
    "Compile current file with Scilab."
    (interactive)
    (save-buffer)
    (let* ((compilation-buffer-name-function
            (lambda (mj) "*Scilab-compilation*")))
      (compile (concat "scilab -nwni -f "
                       (file-name-nondirectory buffer-file-name)))))
  (eval-after-load "scilab"
    '(progn
       (define-key scilab-mode-map (kbd "C-c C-c") 'pi-scilab-compile))))

;; Local variables:
;; coding: utf-8
;; End:

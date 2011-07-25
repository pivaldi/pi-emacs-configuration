;; (when (locate-library "espresso.el")
;;   (autoload #'espresso-mode "espresso" "Start espresso-mode" t)
;;   (add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
;;   (add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
;;   (eval-after-load 'espresso
;;     '(progn
;;        (define-key espresso-mode-map (kbd "RET") 'newline-and-indent)
;;        (define-key espresso-mode-map (kbd "C-t C-u")
;;          (lambda ()
;;            (interactive)
;;            (insert "<?=$user[''];?>")
;;            (forward-char -5))))))


;; Local variables:
;; coding: utf-8
;; End:

(when (and (require 'espresso nil t) (fboundp 'js2-mode))
  (autoload 'espresso-mode "espresso")
  (autoload 'js2-mode "js2" nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (eval-after-load 'js2-mode
    '(progn
       (setq js2-basic-offset 2) ;; because NodeJS team uses 2 spaces
       (defvar pi-js-indent-offset js2-basic-offset "")
       (setq espresso-indent-level pi-js-indent-offset)

       (setq js2-auto-indent-flag t
             js2-bounce-indent-flag nil
             js2-indent-on-enter-key t
             js2-enter-indents-newline t
             js2-mode-escape-quotes nil
             )
       (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
       (add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))

       (define-derived-mode dojo-mode js2-mode "dojo")
       (add-hook 'js2-mode-hook 'pi-js2-mode-hook)
       ))


  ;; [-- Come from http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode
  (defun pi-js2-indent-function ()
    (interactive)
    (save-restriction
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (save-excursion (syntax-ppss (point-at-bol))))
             (offset (- (current-column) (current-indentation)))
             (indentation (espresso--proper-indentation parse-status))
             node)

        (save-excursion

          ;; I like to indent case and labels to half of the tab width
          (back-to-indentation)
          (if (looking-at "case\\s-")
              (setq indentation (+ indentation (/ espresso-indent-level 2))))

          ;; consecutive declarations in a var statement are nice if
          ;; properly aligned, i.e:
          ;;
          ;; var foo = "bar",
          ;;     bar = "foo";
          (setq node (js2-node-at-point))
          (when (and node
                     (= js2-NAME (js2-node-type node))
                     (= js2-VAR (js2-node-type (js2-node-parent node))))
            (setq indentation (+ pi-js-indent-offset indentation))))

        (indent-line-to indentation)
        (when (> offset 0) (forward-char offset)))))

  (defun pi-indent-sexp ()
    (interactive)
    (save-restriction
      (save-excursion
        (widen)
        (let* ((inhibit-point-motion-hooks t)
               (parse-status (syntax-ppss (point)))
               (beg (nth 1 parse-status))
               (end-marker (make-marker))
               (end (progn (goto-char beg) (forward-list) (point)))
               (ovl (make-overlay beg end)))
          (set-marker end-marker end)
          (overlay-put ovl 'face 'highlight)
          (goto-char beg)
          (while (< (point) (marker-position end-marker))
            ;; don't reindent blank lines so we don't set the "buffer
            ;; modified" property for nothing
            (beginning-of-line)
            (unless (looking-at "\\s-*$")
              (indent-according-to-mode))
            (forward-line))
          (run-with-timer 0.5 nil '(lambda(ovl)
                                     (delete-overlay ovl)) ovl)))))

  (defun pi-js2-mode-hook ()
    (setq comment-start "// ")
    (setq comment-end "")
    (when (featurep 'col-highlight)
      (column-highlight 95))

    (c-toggle-auto-state 0)

    (set (make-local-variable 'indent-line-function) 'pi-js2-indent-function)
    (define-key js2-mode-map [(meta control \;)]
      '(lambda()
         (interactive)
         (insert "/* -----[ ")
         (save-excursion
           (insert " ]----- */"))
         ))
    (define-key js2-mode-map [(return)] 'newline-and-indent)
    (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
    (define-key js2-mode-map [(control meta q)] 'pi-indent-sexp)
    (define-key js2-mode-map "\{" 'skeleton-pair-insert-maybe)
    (define-key js2-mode-map "\(" 'skeleton-pair-insert-maybe)
    (define-key js2-mode-map "[" 'skeleton-pair-insert-maybe)
    (define-key js2-mode-map "\"" 'skeleton-pair-insert-maybe)
    (define-key js2-mode-map "'" 'skeleton-pair-insert-maybe)

    (defvar pi-js-compile-command "/usr/bin/smjs")

    (define-key js2-mode-map (kbd "C-c C-c") (lambda nil
                                               (interactive)
                                               (compile (concat
                                                         pi-js-compile-command
                                                         " " (buffer-file-name)))))

    (defvar pi-node-compile-command "/usr/local/bin/node")

    (define-key js2-mode-map (kbd "<C-return>") (lambda nil
                                               (interactive)
                                               (when (buffer-modified-p) (save-buffer))
                                               (shell-command (concat
                                                               pi-node-compile-command
                                                               " -e \"$(cat "
                                                               (buffer-file-name)
                                                               ")\" &"
                                                               ))))

    (if (featurep 'js2-highlight-vars)
        (js2-highlight-vars-mode))
    (message "js2 hook applied"))
  ;; --]

  )
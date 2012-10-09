;; -------
;; * PHP *
(when (locate-library (cuid "site-lisp/pi-php-mode/pi-php-mode.el"))
  (add-to-list 'load-path (cuid "site-lisp/pi-php-mode/"))
  (setq php-user-functions-name '("a" "abbr" "acronym" "address" "applet" "area" "b" "base" "basefont" "bdo" "big" "blockquote" "body" "br" "button" "caption" "center" "cite" "code" "col" "colgroup" "dd" "del" "dfn" "dir" "div" "dl" "dt" "em" "fieldset" "font" "form" "frame" "frameset" "h1" "h2" "h3" "h4" "h5" "h6" "head" "hr" "html" "i" "iframe" "img" "input" "ins" "isindex" "kbd" "label" "legend" "li" "link" "map" "menu" "meta" "noframes" "noscript" "object" "ol" "optgroup" "option" "p" "param" "pre" "q" "s" "samp" "script" "select" "small" "span" "strike" "strong" "style" "sub" "sup" "table" "tbody" "td" "textarea" "tfoot" "th" "thead" "title" "tr" "tt" "u" "ul" "var"))

  (require 'pi-php-mode)
  (setq php-warned-bad-indent t)
  (eval-after-load 'pi-php-mode
    '(progn

       (when (featurep 'flymake)
         (add-hook 'php-mode-hook
                   (lambda nil
                     (when (not (tramp-file-name-p (buffer-file-name)))
                       (flymake-mode 1))
                     (set-fill-column 95)
                     (turn-on-auto-fill))))

       (when (featurep 'gtags)
         (add-hook 'php-mode-hook
                   (lambda nil
                     (gtags-mode 1))))

       (when (featurep 'col-highlight)
         (add-hook 'php-mode-hook
                   (lambda nil
                     (column-highlight 95))))

       (defvar pi-mmm-c-locals-saved nil)

       (add-hook 'php-mode-hook
                 (lambda nil
                   ;; Add all c-locals to mmm-save-local-variables
                   ;; See http://www.emacswiki.org/emacs/HtmlModeDeluxe
                   (when (and (featurep 'mmm-mode)
                              (not pi-mmm-c-locals-saved))
                        (setq pi-mmm-c-locals-saved t)
                        (pi-save-mmm-c-locals))

                   (let ((keysm (kbd "C-;"))
                         (keyco (kbd "C-,")))
                     (local-set-key keysm 'pi-insert-semicol-at-end-of-line)
                     (if (boundp 'flyspell-mode-map)
                         (define-key flyspell-mode-map
                           keysm 'pi-insert-semicol-at-end-of-line))
                     (local-set-key keyco 'pi-insert-comma-at-end-of-line)
                     (if (boundp 'flyspell-mode-map)
                         (define-key flyspell-mode-map
                           keyco 'pi-insert-comma-at-end-of-line)))))

       (define-key php-mode-map (kbd "²")
         '(lambda nil
            (interactive)
            (insert "->")))

       (defun pi-phpArrowArray nil
         (interactive)
         (let ((sp (if (= 32 (char-before)) "" " ")))
           (insert (concat sp "=> "))))
       (define-key php-mode-map (kbd "¹") 'pi-phpArrowArray)

       (define-key php-mode-map (kbd "§")
         '(lambda nil
            (interactive)
            (insert "\\")))

       (defun pi-phplint-thisfile (&optional debug)
         (interactive "P*")
         (let ((option (if debug "-l" "")))
           (compile (format "php5 %s %s" option (buffer-file-name)))))

       (when (require 'php-doc nil t)
         (setq php-doc-directory php-manual-path)
         (setq eldoc-idle-delay 0)
         (add-hook 'php-mode-hook
                   (lambda ()
                     (local-set-key (kbd "\C-c h") 'php-doc)
                     (set (make-local-variable 'eldoc-documentation-function)
                          'php-doc-eldoc-function)
                     (if (not eldoc-mode) (eldoc-mode 1)))))

       ;; With prefix don't run, check syntax only
       (define-key php-mode-map (kbd "C-c C-c") 'pi-phplint-thisfile)
       (define-key php-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
       (define-key php-mode-map (kbd "M-TAB") 'php-complete-function)
       (when pi-use-skeleton-pair-insert-maybe
         (define-key php-mode-map "\{" 'skeleton-pair-insert-maybe)
         (define-key php-mode-map "\(" 'skeleton-pair-insert-maybe)
         (define-key php-mode-map "[" 'skeleton-pair-insert-maybe)
         (define-key php-mode-map "\"" 'skeleton-pair-insert-maybe)
         (define-key php-mode-map "'" 'skeleton-pair-insert-maybe))
       (define-key php-mode-map [(control d)] 'c-electric-delete-forward)
       (define-key php-mode-map [(control meta q)] 'indent-sexp))))


;; nxhtml est trop bogué :(
;; ----------------
;; * PHP et XHTML *
;; (when (and (locate-library (cuid "site-lisp/nxhtml/autostart.el")))
;;   ;; Pour ne pas que nummao fasse n'importe quoi avec mes raccourcis clavier. Merci !
;;   (setq mumamo-map nil)
;;   (load (cuid "site-lisp/nxhtml/autostart.el"))
;;   ;; (fset 'xml-mode 'nxml-mode)
;;   (when (not user-set-coding-system-latin)
;;     (setq nxhtml-default-encoding "utf-8"))

;;   (setq php-manual-path "/usr/share/doc/php-doc/html/")
;;   (setq php-completion-file (concat (cuid "site-lisp/") "php-completion-file"))

;;   (eval-after-load 'php-mode
;;     '(progn
;;        ;; Commentaires // pas /* */
;;        (set-variable 'comment-start "// " t)
;;        (set-variable 'comment-end "" t)
;;        (when (featurep 'gtags)
;;          (add-hook 'php-mode-hook
;;                    (lambda nil
;;                      (gtags-mode 1))))

;;        (define-key php-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
;;        (define-key php-mode-map (kbd "M-TAB") 'php-complete-function)
;;        (define-key php-mode-map "\{" 'skeleton-pair-insert-maybe)
;;        (define-key php-mode-map "\(" 'skeleton-pair-insert-maybe)
;;        (define-key php-mode-map "[" 'skeleton-pair-insert-maybe)
;;        (define-key php-mode-map "\"" 'skeleton-pair-insert-maybe)
;;        (define-key php-mode-map "'" 'skeleton-pair-insert-maybe)))

;;   ;; Pour éviter que certains raccourcis claviers entre en conflit avec les miens
;;   ;; (setq nxml-mode-map
;;   ;;       (let ((map (make-sparse-keymap)))
;;   ;;         (define-key map "\M-\C-u" 'nxml-backward-up-element)
;;   ;;         (define-key map "\M-\C-d" 'nxml-down-element)
;;   ;;         (define-key map "\M-\C-n" 'scroll-move-down)
;;   ;;         (define-key map "\M-\C-p" 'scroll-move-up)
;;   ;;         (define-key map "\M-{" 'nxml-backward-paragraph)
;;   ;;         (define-key map "\M-}" 'nxml-forward-paragraph)
;;   ;;         (define-key map "\M-h" 'nxml-mark-paragraph)
;;   ;;         (define-key map "\C-c\C-f" 'nxml-finish-element)
;;   ;;         (define-key map "\C-c\C-m" 'nxml-split-element)
;;   ;;         (define-key map "\C-c\C-b" 'nxml-balanced-close-start-tag-block)
;;   ;;         (define-key map "\C-c\C-i" 'nxml-balanced-close-start-tag-inline)
;;   ;;         (define-key map "\C-c\C-x" 'nxml-insert-xml-declaration)
;;   ;;         (define-key map "\C-c\C-d" 'nxml-dynamic-markup-word)
;;   ;;         (define-key map (kbd "<C-M-right>") 'nxml-forward-element)
;;   ;;         (define-key map (kbd "<C-M-left>") 'nxml-backward-element)
;;   ;;         ;; u is for Unicode
;;   ;;         (define-key map "\C-c\C-u" 'nxml-insert-named-char)
;;   ;;         (define-key map "\C-c\C-o" 'nxml-outline-prefix-map)
;;   ;;         (define-key map [S-mouse-2] 'nxml-mouse-hide-direct-text-content)
;;   ;;         (define-key map "/" 'nxml-electric-slash)
;;   ;;         (define-key map [C-return] 'nxml-complete)
;;   ;;         (when nxml-bind-meta-tab-to-complete-flag
;;   ;;           (define-key map "\M-\t" 'nxml-complete))
;;   ;;         map))

;;   (setq nxml-slash-auto-complete-flag t)

;;   ;; To use flyspell-prog-mode
;;   (eval-after-load 'flyspell
;;     '(progn
;;        (add-to-list 'flyspell-prog-text-faces 'nxml-text-face)))
;;   ;; (add-hook 'nxhtml-mode
;;   ;;           '(progn
;;   ;; ;;              (tabkey2-mode 1))
;;   ;;              )
;;   )
;;
;; Local variables:
;; coding: utf-8
;; End:

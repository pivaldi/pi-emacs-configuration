;; -------
;; * PHP *
(when (require 'php-mode nil t)
  (setq php-user-functions-name '("a" "abbr" "acronym" "address" "applet" "area" "b" "base" "basefont" "bdo" "big" "blockquote" "body" "br" "button" "caption" "center" "cite" "code" "col" "colgroup" "dd" "del" "dfn" "dir" "div" "dl" "dt" "em" "fieldset" "font" "form" "frame" "frameset" "h1" "h2" "h3" "h4" "h5" "h6" "head" "hr" "html" "i" "iframe" "img" "input" "ins" "isindex" "kbd" "label" "legend" "li" "link" "map" "menu" "meta" "noframes" "noscript" "object" "ol" "optgroup" "option" "p" "param" "pre" "q" "s" "samp" "script" "select" "small" "span" "strike" "strong" "style" "sub" "sup" "table" "tbody" "td" "textarea" "tfoot" "th" "thead" "title" "tr" "tt" "u" "ul" "var"))

  (defcustom pi-php-highlight-function-call t
    "When set to true highlight official PHP functions.
This can slow buffer loading."
    :type 'boolean
    :group 'php)

  (setq php-completion-file
        (concat
         (cuid "etc/")
         "php-completion-file.txt"))

  (setq php-warned-bad-indent t)
  (eval-after-load 'php-mode
    '(progn
       (when (and pi-php-highlight-function-call
                  (file-readable-p php-completion-file))

         (defun php-add-function-keywords (function-keywords face-name)
           (let* ((keyword-regexp (concat "\\<\\("
                                          (regexp-opt function-keywords)
                                          "\\)(")))
             (font-lock-add-keywords 'php-mode
                                     `((,keyword-regexp 1 ',face-name)))))

         (defun php-nth-list (list first count)
           "Return a copy of LIST, which may be a dotted list.
       The elements of LIST are not copied, just the list structure itself."
           (if (consp list)
               (let ((res nil)
                     (n first)
                     (last (min (+ first count) (length list))))
                 (while
                     (and (push (nth n list) res)
                          (setq n (+ 1 n))
                          (< n last))) (nreverse res)) nil))

         (defun php-lines-to-list-from-file (file)
           "Return a list of lines of 'file'."
           (with-temp-buffer
             (insert-file-contents file)
             (split-string (buffer-string) "\n" t)))

         (let* ((all-func (php-lines-to-list-from-file php-completion-file))
                (l (length all-func))
                (n 0)
                (php-functions-name nil))

           ;; regexp-opt cannot parse all-func at once (failed in php-add-function-keywords)
           (while (and (< n l)
                       (add-to-list 'php-functions-name (php-nth-list all-func n 150) t)
                       (setq n (+ n 150))))

           (add-to-list 'php-functions-name php-user-functions-name)

           (mapcar #'(lambda (x)
                       (php-add-function-keywords
                        x
                        'font-lock-function-name-face))
                   php-functions-name)))



       (add-hook 'php-mode-hook
                 (lambda nil
                   (setq c-basic-offset 4)
                   (when (featurep 'flymake)
                     (flymake-mode -1))
                   (set-fill-column 95)))

       ;; (when (featurep 'gtags)
       ;;   (add-hook 'php-mode-hook
       ;;             (lambda nil
       ;;               (gtags-mode 1))))

       (when (featurep 'col-highlight)
         (add-hook 'php-mode-hook
                   (lambda nil
                     (column-highlight 95))))

       (add-hook 'php-mode-hook 'php-enable-symfony2-coding-style)

       (defvar pi-mmm-c-locals-saved nil)

       (defun pi-get-uc-directory-part (offset &optional addFilename)
         "Get the longest uc directory.
/var/www/costespro/App/CPro/Model/Poi/Zone will return App/CPro/Model/Poi/Zone"
         (let ((dir (if addFilename
                        (buffer-file-name)
                      (file-name-directory (buffer-file-name))))
               (ext (if addFilename ".php" "/")))
           (substring dir
                      (+ offset (let ((case-fold-search nil))
                                  (string-match
                                   (concat "\\\(/[A-Z][a-zA-Z0-9]+\\\)+" ext "$") dir))))))

       (defun pi-insert-rename-buffer-clause ()
         "Insert a statement as local variable to rename the buffer according to
a upper case naming convention"
         (interactive)
         (insert (format
                  "// Do not remove for Emacs users
// Local Variables:
// eval: (rename-buffer \"%s\")
// End:" (pi-get-uc-directory-part 1 t))))

       (defun pi-insert-php-namespace ()
         "Insert php namespace clause, based on camel case directory
notation. Eg. \"/var/www/costespro/App/CPro/App.php\" gives \"namespace App\\CPro;\""
         (interactive)
         (insert
          (concat
           "namespace "
           (replace-regexp-in-string
            "\\\\+$" ""
            (replace-regexp-in-string
             "^_+" ""
             (mapconcat
              #'identity
              (split-string
               (pi-get-uc-directory-part 1) "/") "\\"))) ";")))
       (define-key php-mode-map (kbd "<C-S-f8>") 'pi-insert-php-namespace)
       (define-key php-mode-map (kbd "C-;") 'pi-insert-semicol-at-end-of-line)
       (define-key php-mode-map (kbd "C-,") 'pi-insert-comma-at-end-of-line)

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
                     (when (boundp 'flyspell-mode-map)
                       (define-key flyspell-mode-map
                         keysm 'pi-insert-semicol-at-end-of-line)
                       (define-key flyspell-mode-map
                         keyco 'pi-insert-comma-at-end-of-line)))))

       (defun pi-add-php-class-to-kill-ring ()
         "Add to the kill-ring the class name that the current PHP file would must contain.
E.g /a/b/c/D/E/F.php gives D\\E\\F"
         (interactive)
         (let ((className
                (replace-regexp-in-string
                 "\.php$" ""
                 (replace-regexp-in-string
                  "^_+" ""
                  (mapconcat
                   #'identity
                   (split-string
                    (pi-get-uc-directory-part 0 t) "/") "\\")))))
           (kill-new className)
           (message (concat className " was pushed in the kill ring"))))
       (define-key php-mode-map (kbd "<M-f8>") 'pi-add-php-class-to-kill-ring)

       (define-key php-mode-map (kbd "²")
         '(lambda nil
            (interactive)
            (insert "->")))
       (define-key php-mode-map (kbd "œ")
         '(lambda nil
            (interactive)
            (insert "->")))

       (define-key php-mode-map (kbd "¹") 'pi-arrowPhpLike)
       (define-key php-mode-map (kbd "Œ") 'pi-arrowPhpLike)

       (define-key php-mode-map (kbd "§")
         '(lambda nil
            (interactive)
            (insert "\\")))

       (defun pi-phplint-thisfile (&optional debug)
         (interactive "P*")
         (let ((option (if debug "-l" "")))
           (compile (format "php %s %s" option (buffer-file-name)))))

       (when (require 'php-doc nil t)
         (setq php-doc-directory php-manual-path)
         (setq eldoc-idle-delay 0)
         (add-hook 'php-mode-hook
                   (lambda ()
                     (local-set-key (kbd "\C-c h") 'php-doc)
                     (set (make-local-variable 'eldoc-documentation-function)
                          'php-doc-eldoc-function)
                     (eldoc-mode 1))))

       ;; With prefix don't run, check syntax only
       (define-key php-mode-map (kbd "C-c C-c") 'pi-phplint-thisfile)
       (define-key php-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
       (define-key php-mode-map (kbd "M-TAB") 'php-complete-function)
       (define-key php-mode-map (kbd "C-c C-y") 'yas/create-php-snippet)

       (when pi-use-skeleton-pair-insert-maybe
         (define-key php-mode-map "\{" 'skeleton-pair-insert-maybe)
         (define-key php-mode-map "\(" 'skeleton-pair-insert-maybe)
         (define-key php-mode-map "[" 'skeleton-pair-insert-maybe)
         (define-key php-mode-map "\"" 'skeleton-pair-insert-maybe)
         (define-key php-mode-map "'" 'skeleton-pair-insert-maybe))
       (define-key php-mode-map [(control d)] 'c-electric-delete-forward)
       (define-key php-mode-map [(control meta q)] 'indent-sexp)

       (add-hook 'php-mode-hook
                 '(lambda ()
                    (auto-complete-mode t)
                    ;; (company-mode t)
                    ;; (require 'company-php)
                    (when (require 'ac-php nil t)
                      (setq ac-sources  '(ac-source-php ) )
                      (ac-php-core-eldoc-setup)
                      (define-key php-mode-map  (kbd "M-.") 'ac-php-find-symbol-at-point)   ;goto define
                      (define-key php-mode-map  (kbd "<M-left>") 'ac-php-location-stack-back) ;go back
                      (define-key php-mode-map  (kbd "M-?") 'ac-php-show-tip)
                      )))
       ))

  (when (locate-library (cuid "site-lisp/php-cs-fixer/php-cs-fixer.el"))
    (if (not (executable-find "php-cs-fixer"))
        (add-to-list 'pi-error-msgs "Please install php-cs-fixer : https://github.com/FriendsOfPHP/PHP-CS-Fixer"))

    (add-to-list 'load-path (cuid "site-lisp/php-cs-fixer/"))
    (require 'php-cs-fixer)
    (setq php-cs-fixer-config-option (expand-file-name "~/emacs.d/bin/php-cs-fixer-config.php"))
    (add-hook 'before-save-hook 'php-cs-fixer-before-save))
  )

(provide 'pi-php)
;;
;; Local variables:
;; coding: utf-8
;; End:

;;; pi-php ends here

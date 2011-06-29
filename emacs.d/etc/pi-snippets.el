;; http://code.google.com/p/yasnippet/
(when (file-exists-p (cuid "site-lisp/yasnippet"))
  (add-to-list 'load-path (cuid "site-lisp/yasnippet"))
  (require 'yasnippet)

  ;; (defun pi-basic-snippet-expand-condition ()
  ;;   (or (not (char-after)) (string-match (int-to-string (char-after)) "\(32\|10\|41\|44\|45\|36|\|59\|39\)")))

  (defun pi-basic-snippet-expand-condition ()
    (let ((char (char-to-string (char-after))))
      (not (string-match "[a-zA-Z]" char))))

  ;; (load (cuid "site-lisp/tab-completion-everywhere.el")) ;; Tab for all
  ;; Load the snippets
  (setq yas/root-directory
        `(,(cuid "site-lisp/pi-snippets")
          ,(cuid "site-lisp/yasnippet/snippets/")))
  (mapc 'yas/load-directory yas/root-directory)
  (yas/global-mode 1)

  ;; remaps some keys that makes some behavior change.
  ;; In my case it changed the TAB key, and thereby disabled Yasnippet.
  ;; http://tuxicity.se/emacs/javascript/js2-mode/yasnippet/2009/06/14/js2-mode-and-yasnippet.html
  (eval-after-load 'js2-mode
    '(progn
       (define-key js2-mode-map (kbd "TAB") (lambda()
                                              (interactive)
                                              (let ((yas/fallback-behavior 'return-nil))
                                                (unless (yas/expand)
                                                  (indent-for-tab-command)
                                                  (if (looking-back "^\s*")
                                                      (back-to-indentation))))))))
  (when (featurep 'auto-complete)
    (require 'auto-complete-yasnippet "auto-complete-yasnippet.elc" t)))

;; Debian yas emacs23 package does not work properly
;; (when  (require 'yasnippet "yasnippet.elc" t) ;; part of debian Squeeze (emacs23 package)
;;   (let ((yasdir (if (listp yas/root-directory) (cdr yas/root-directory) yas/root-directory)))
;;         (setq yas/root-directory (list (cuid "site-lisp/pi-snippets") yasdir)))
;;   (mapc 'yas/load-directory yas/root-directory)
;;   (when (featurep 'auto-complete)
;;     (require 'auto-complete-yasnippet "auto-complete-yasnippet.elc" t))
;;   )

;; Local variables:
;; coding: utf-8
;; End:

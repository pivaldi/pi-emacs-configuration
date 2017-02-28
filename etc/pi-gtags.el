;; gtags c'est mieux que etags :-o
;; La documentation est rapidement comprise: http://www.gnu.org/software/global/globaldoc.html
(when (and (executable-find "gtags") (require 'gtags nil t))
  ;; On commence par faire en sorte que la fenêtre se ferme automatiquement
  ;; quand on a choisit un gtags (mais on crée C-RET pour garder la fenêtre)
  (define-key gtags-select-mode-map (kbd "<C-return>") 'gtags-select-tag)
  (define-key gtags-select-mode-map (kbd "RET")
    (lambda ()
      (interactive)
      (let ((cb (current-buffer)))
        (gtags-select-tag)
        (kill-buffer cb))))

  (when (require 'php-mode nil t)
  (eval-after-load 'auto-complete
    (lambda ()
        (add-to-list 'ac-gtags-modes 'php-mode))))

  ;; Sources: http://www.emacswiki.org/emacs/CyclingGTagsResult
  (defun ww-next-gtag ()
    "Find next matching tag, for GTAGS."
    (interactive)
    (let ((latest-gtags-buffer
           (car (delq nil  (mapcar (lambda (x) (and (string-match "GTAGS SELECT" (buffer-name x)) (buffer-name x)) )
                                   (buffer-list)) ))))
      (cond (latest-gtags-buffer
             (switch-to-buffer latest-gtags-buffer)
             (next-line)
             (gtags-select-it nil))
            )))

  (add-hook 'gtags-select-mode-hook
            '(lambda ()
               (hl-line-mode 1)))

  (global-set-key "\M-;" 'ww-next-gtag)             ;; M-; cycles to next result, after doing M-. C-M-. or C-M-,
  (global-set-key "\M-." 'gtags-find-tag)           ;; M-. finds tag
  (global-set-key (kbd "C-M-.") 'gtags-find-rtag)   ;; C-M-. find all references of tag
  (global-set-key (kbd "C-M-,") 'gtags-find-symbol) ;; C-M-, find all usages of symbol.
  )

;; ;; --------------------------------------
;; ;; * Pour une meilleur gestion des TAGS *
;; ;; * `M-.’ (‘find-tag’) – find a tag, that is, use the Tags file to look up a definition
;; ;; * `M-*’ (‘pop-tag-mark’) – jump back
;; ;; * ‘tags-search’ – regexp-search through the source files indexed by a tags file (a bit like ‘grep’)
;; ;; * ‘tags-query-replace’ – query-replace through the source files indexed by a tags file
;; ;; * `M-,’ (‘tags-loop-continue’) – resume ‘tags-search’ or ‘tags-query-replace’ starting at point in a source file
;; ;; * ‘tags-apropos’ – list all tags in a tags file that match a regexp
;; ;; * ‘list-tags’ – list all tags defined in a source file
;; (when (locate-library "etags-table")
;;   (require 'etags-table)
;;   ;; Max depth to search up for a tags file.  nil means don't search.
;;   (setq  etags-table-search-up-depth 4
;;          ;; Map filename to tag. À paramétrer suivant ses projets
;;          etags-table-alist (list
;;                             `(,(cuid "/.*\\.el$") "~/.tags/TAGS-el")
;;                             '("~/essais/asy/.*\\.asy$" "~/.tags/TAGS-asy")
;;                             '(".*\\.php$" "~/.tags/TAGS-php")
;;                             '("/var/lib/.*\\.php$" "~/.tags/TAGS-TYPO3")))
;;   (global-set-key (kbd "<C-M-tab>") 'complete-tag))

;; ;; ----------------
;; ;; * etags-select *
;; (when (require 'etags-select "etags-select.el" t)
;;   (global-set-key "\M-?" 'etags-select-find-tag-at-point))

;; ;; -----------------------------------------------
;; ;; * Pour générer les fichiers TAG recurcivement *
;; (when (require 'traverselisp "traverselisp.el" t)
;;   (setq traverse-use-avfs t) ;; Attention il faut avoir installé avfs: apt-get install avfs fuse-utils
;;   (global-set-key (kbd "C-c f") 'traverse-deep-rfind)
;;   (global-set-key (kbd "C-c u") 'traverse-build-tags-in-project)
;;   (global-set-key (kbd "C-c o") 'traverse-occur-current-buffer)
;;   ;; (add-to-list 'traverse-ignore-files ".ledger-cache")
;;   )

;; Local variables:
;; coding: utf-8
;; End:

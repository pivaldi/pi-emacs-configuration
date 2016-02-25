;; ----------------------
;; * browse-apropos-url *
;; Most  of modern  browsers  allow  you to  write  keywords in  the
;; location bar  for doing easy  and fast searching. For  example in
;; opera "g emacswiki" googles for "emacswiki".
;; browse-apropos-url  provide this functionality and more
;; to elisp coders independently of which browser does browse-url
;; start.
;; From http://www.emacswiki.org/cgi-bin/wiki/BrowseAproposURL
(setq apropos-url-alist
      '(("^gw?:? +\\(.*\\)" . ;; Google Web
         "http://www.google.fr/search?q=\\1")

        ("^gg:? +\\(.*\\)" . ;; Google Groups
         "http://groups.google.com/groups?q=\\1")

        ("^gt:? +\\(\\w+\\)|? *\\(\\w+\\) +\\(.*\\)" . ;; Google Translate Text
         "http://translate.google.com/translate_t?langpair=\\1|\\2&text=\\3")

        ("^dic:? +\\(\\w+\\)" . ;; Trésor de la Langue Française informatisé
         "http://www.cnrtl.fr/lexicographie/\\1")

        ("^conj:? +\\(\\w+\\)" . ;; Conjugaison avec le bescherelle.
         "http://bescherelle.leconjugueur.com/frconjugue.php?verbe=\\1")
        ))

(defun browse-apropos-url (text &optional new-window)
  (interactive "sLocation: ")
  (let ((text (replace-regexp-in-string
               "^ *\\| *$" ""
               (replace-regexp-in-string "[ \t\n]+" " " text))))
    (let ((url (assoc-default
                text apropos-url-alist
                '(lambda (a b) (let () (setq __braplast a) (string-match a b)))
                text)))
      (browse-url (replace-regexp-in-string __braplast url text) new-window))))

(defun browse-apropos-url-on-region (min max text &optional new-window)
  (interactive "r \nsAppend region to location: \nP")
  (browse-apropos-url (concat text " " (buffer-substring min max)) new-window))

(global-set-key (kbd "C-b") 'browse-apropos-url)
(global-set-key (kbd "C-S-b") 'browse-apropos-url-on-region)
;; Exemple sélectionner le mot "myriade" C-S-b dic <RET> et aller voir votre navigateur...

;; -----------------------
;; * WebBrowser in emacs *
(when (require 'w3m-load "w3m-load.elc" t)
  ;;  Où se trouve les icons pour w3m
  (setq w3m-icon-directory (cuid "etc/icons"))
  ;; Définit google-chrome comme navigateur web, pour suivre les liens
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program user-web-browser
        browse-url-generic-args (list "-new-tab"))
  (add-hook 'w3m-mode-hook
            (lambda ()
              ;; Use "M" (default) in w3m-mode to view url with external browser
              ;; (local-set-key [f4] 'w3m-view-url-with-external-browser)
              (define-key w3m-mode-map (kbd "<down>") 'next-line)
              (define-key w3m-mode-map (kbd "<up>") 'previous-line)
              (define-key w3m-mode-map (kbd "<right>") 'forward-char-nomark)
              (define-key w3m-mode-map (kbd "<left>") 'backward-char-nomark)))
  )

;; ------------
;; * smallurl *
(require 'smallurl "smallurl.el" t)
;; smallurl-replace-at-point - replace the url at point with a tiny one.
;; smallurl                  - print and put into the kill ring the tiny
;;                             version of the url prompted for.
;; Setting `smallurl-service' will let you choose a service.
(setq smallurl-service 'tinyurl)
(defalias 'sml 'smallurl-replace-at-point)

;; Local variables:
;; coding: utf-8
;; End:

;;; Author: Philippe Ivaldi

(eval-when-compile
  (require 'cl))

;; Don't want that rss read break my mail reading
(setq nnrss-directory "/dev/null")

;; Your preference for a mail composition package.
(setq mail-user-agent 'message-user-agent)

;; From Searching IMAP in Gnus.
(require 'nnir)

;; Évite d'avoir des fichiers ~ dans les répertoires de mails
(defun turn-off-backup ()
  (set (make-local-variable 'backup-inhibited) t))
(add-hook 'nnfolder-save-buffer-hook 'turn-off-backup)

;; Fonctions utiles utilisées dans la suite
(defun To (u) (concat "^\\([Cc][Cc]\\|[Tt][Oo]\\|Sender\\|Mailing-List\\|X-Loop\\):.*" u))
(defun ToMml (u) (To (concat u "@\\(mandrakesoft\\|linux-mandrake\\).com")))
(defun xloop (u) (concat "^X-Loop: " u))
(defun date (u) (concat (format-time-string "%Y%m." (current-time)) u))

(defun pi-mml-insert-inline-code ()
  (interactive)
  (mml-insert-tag 'part 'type "text/html" 'disposition "inline")
  (insert "<pre style=\"font-family: monospace;\">")
  (insert "\n</pre>")
  (insert "\n<#/part>")
  (forward-line -1))

;; Pour que Gnus construise l'enveloppe from deouis le From du message
;; C'est important quand on a pas un nom de domaine avec un login valide
;; (setq message-sendmail-envelope-from nil) ;; utilise la valeur de user-mail-address
(setq message-sendmail-envelope-from 'header) ;; utilise la valeur du From
(setq message-sendmail-f-is-evil nil)
;; pour éviter un champ Sender dans les messages
(require 'message)
(add-to-list 'message-syntax-checks '(sender . disabled))

;;  Switching Identities interactively is as easy as calling one of
;;  the following two functions:
;;  o `gnus-alias-use-identity' - pass in a valid Identity alias to be
;;    used in the current buffer.
;;  o `gnus-alias-select-identity' - will prompt you for an identity
;;    to use and then use it in the current buffer.
;;
;;  If you do either of them frequently, you can bind them to a key:
;;
;;  (defun pi-message-load-hook ()
;;   (gnus-alias-init)
;;   (define-key message-mode-map [(f10)] (function
;;    (lambda () "Set Identity to jcasadonte." (interactive)
;;      (gnus-alias-use-identity "JCasadonte"))))
;;
;;   (define-key message-mode-map [(f11)]
;;   'gnus-alias-select-identity)
;;   )
;;
;;  (add-hook 'message-load-hook 'pi-message-load-hook)
(when (require 'gnus-alias nil t)
  (gnus-alias-init))

;; mail.gandi.net
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-auth-credentials "~/.authinfo.gpg"
      smtpmail-smtp-service 587
      starttls-use-gnutls t)

;; smtp protonmail
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-auth-credentials "~/.authinfo.gpg"
;;       smtpmail-smtp-server "127.0.0.1"
;;       smtpmail-smtp-service 1025)

;; (setq message-send-mail-function 'message-send-mail-with-sendmail)
;; (setq gnus-permanently-visible-groups ".*");

(require 'nnimap)

;; Activate topic mode each time you start Gnus
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-secondary-select-methods
      '((nnimap "ovya"
                (nnimap-address "imap.gmail.com")
                (nnimap-authenticator login)
                (nnimap-stream ssl)
                (nnir-search-engine imap))
        ;; (nnimap "piprime_gmail"
        ;;         (nnimap-address "imap.gmail.com")
        ;;         (nnimap-authenticator login)
        ;;         (nnimap-stream ssl)
        ;;         (nnir-search-engine imap))
        ;; (nnimap "piprime"
        ;;         (nnimap-address "mail.gandi.net")
        ;;         (nnimap-authenticator login)
        ;;         (nnimap-stream ssl)
        ;;         (nnimap-server-port 993)
        ;;         (nnimap-expunge-on-close 'never)
        ;;         (nnir-search-engine imap))
        ;; (nnimap "castanies"
        ;;         (nnimap-address "mail.gandi.net")
        ;;         (nnimap-authenticator login)
        ;;         (nnimap-stream ssl)
        ;;         (nnimap-server-port 993)
        ;;         (nnimap-expunge-on-close 'never)
        ;;         (nnir-search-engine imap))
        ;; (nnimap "xyz"
        ;;         (nnimap-address "mail.gandi.net")
        ;;         (nnimap-authenticator login)
        ;;         (nnimap-server-port 993)
        ;;         (nnimap-expunge-on-close 'never)
        ;;         (nnimap-stream ssl)
        ;;         (nnir-search-engine imap))
        ;; (nnimap "me"
        ;;         (nnimap-address "mail.gandi.net")
        ;;         (nnimap-authenticator login)
        ;;         (nnimap-server-port 993)
        ;;         (nnimap-expunge-on-close 'never)
        ;;         (nnimap-stream ssl)
        ;;         (nnir-search-engine imap))
        ;; (nnimap "proton"
        ;;         (nnimap-address "127.0.0.1")
        ;;         (nnimap-authenticator login)
        ;;         (nnimap-server-port 1143)
        ;;         (nnimap-expunge-on-close 'never)
        ;;         (nnimap-stream starttls)
        ;;         (nnir-search-engine imap))
        (nnimap "acmontpellier"
                (nnimap-address "courrier.ac-montpellier.fr")
                (nnimap-authenticator login)
                (nnimap-server-port 993)
                (nnimap-expunge-on-close 'never)
                (nnimap-stream ssl)
                (nnir-search-engine imap))
        ))

(setq gnus-parameters
      '((".*"
         (gnus-use-scoring nil))))

;; (setq nnimap-split-inbox
;;       '("INBOX" ))

;; (setq nnimap-split-predicate "UNDELETED")
;; (setq nnimap-split-crosspost nil)
;; (setq nnimap-split-fancy
;;       '(|
;;         ("Subject"
;;          "\\(Logs:.*\\|Mail Stats\\|eicq Daily Usenet\\|var/log/.*\\)" "INBOX.private.logs")
;;         (from ".*redmine@costes-viager\\.com" "INBOX.redmine")
;;         (from ".*linkedin.com" "INBOX.linkedin")
;;         (any ".*@piprime\\.fr" "INBOX.piprime")
;;  (any ".*syracuse@melusine.eu.org.*" "INBOX.syracuse")
;;  ("Subject\\|to" ".*\\[asymptote - Help\\].*\\|.*asymptote-developers@lists.sourceforge.net.*" "INBOX.asymptote")
;;  (any ".*AmiTeX.*" "INBOX.AmiTeX")
;;         ;;Achat
;;  (any ".*amazon.*\\|.*rueducommerce.*\\|.*Surcouf.*\\|.*cdiscount.*\\|.*ldlc.com" "INBOX.achat")
;;  (any ".*ebay.*\\|.*eBay.*" "INBOX.ebay")
;;         ;; To me, personally
;;         (naany "Bowman\\|Hammerlindl\\|Shardt" "INBOX.asy-dev")
;;         (from "gandi.net" "INBOX.gandi")
;;         (from ".*@guideregional\\.fr.*" "INBOX.gr-interne")
;;         (to ".*@guideregional\\.fr.*" "INBOX.guideregional.fr")
;;        à (any ".*@lescastanies\\.fr.*" "INBOX.lescastanies")
;;         (to "\\(.*philippe.ivaldi@sfr\\.fr.*\\)\\|\\(.*pivaldi@sfr\\.fr.*\\)" "INBOX.pivaldi")
;;         (any "\\(.*@ovya\\.fr.*\\)\\|\\(.*@costes-.*\\)" "INBOX.ovya")
;;         (to ".*ac-montpellier\\.fr.*" "INBOX.montpellier")
;;         ;; Catch all
;;         "INBOX.unsorted")

;;       nnimap-split-rule '(
;;                           ("ovya" ("INBOX" nnimap-split-fancy))
;;                           ("mailsfr" ("INBOX" nnimap-split-fancy))
;;                           ("piprime" ("INBOX" nnimap-split-fancy))
;;                           ("philippe.ivaldi.xyz" ("INBOX" nnimap-split-fancy))
;;                           )
;;       )


;; (setq gnus-parameters
;;       '(("nnimap ovya:.*"
;;          (display . all)
;;          (posting-style
;;           (name "Philippe Ivaldi")
;;           (address "pi@ovya.fr"))
;;          (expiry-target . delete))
;;         ("nnimap piprime:.*"
;;          (display . all)
;;          (posting-style
;;           (name "Philippe Ivaldi")
;;           (address "contact@piprime.fr")
;;           (organization "PIPRIME"))
;;          (expiry-wait . delete))
;;         ("nnimap philippe.ivaldi.xyz:.*"
;;          (display . all)
;;          (posting-style
;;           (name "Philippe Ivaldi")
;;           (address "philippe@ivaldi.xyz"))
;;          (expiry-wait . delete))
;;         ))

;; ;;***********************
;; ;;* Paramètres généraux *
;; ;;***********************

(setq mm-url-use-external t)
(setq mm-url-program "wget")
(setq mm-url-arguments '("--user-agent=Mozilla/5.0 (X11; Linux i686) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36" "-q" "-t" "1" "-T" "10" "-O" "-"))

;; (setq mm-url-use-external nil) ;;If non-nil, use external grab program `mm-url-program'.
;; (setq mm-url-program "wget")
;; (setq mm-url-arguments '("--user-agent=Drupal" "-q" "-O" "-"))

(setq
 ;; Doing some music
 ;; gnus-play-startup-jingle t
 ;; la valeur 40 permet, chez moi, de toujours voir les infos supplémentaires (buffer, lignes...)
 ;; gnus-mode-non-string-length 40
 url-cookie-confirmation nil
 ;;Pour la lecture des Message-ID:
 ;; gnus-refer-article-method '(nntp "nntpserver.tele2.fr")

 ;; Here I define how to display subject lines etc...
 ;; I wanna see thoses groups everytime
 ;; Use G c
 ;;  gnus-permanently-visible-groups
 ;;  "^mail.*\\|^fr.comp.*\\|^comp.*"

 ;; Ne pose pas de question en quittant.
 gnus-interactive-exit 'nil

 ;; The message buffer will be killed after sending a message.
 message-kill-buffer-on-exit t
 ;; always center the current summary buffer (verticaly only)
 gnus-auto-center-summary 'vertical
 ;; Pas de taille limite pour l'envoi de pièce jointe
 message-send-mail-partially-limit nil
 )

;; fichier de scores, pour donner un score aux artivles et les classer
(setq gnus-kill-files-directory "~/emacs.d/etc/gnus/gnus-score")
(setq  gnus-use-scoring  t)

;; We choose nnml: everybody says it's the fastest backend on earth.
(setq gnus-select-method '(nnml "private"))

;; We trash duplicates mails.
(setq nnmail-treat-duplicates 'warn)

;; vérifie les nouveaux groupes à chaque démarrage
;; si votre serveur est lent, vous avez intérêt à mettre cette variable à 'nil'
(setq gnus-check-new-newsgroups t)

;; le serveur de news à utiliser
;; remplacer 'news.alphanet.ch' par le nom de votre serveur de news
;; (setq gnus-select-method '(nntp "news.alphanet.ch"))

;; que faire des nouveaux groupes
(setq gnus-subscribe-newsgroup-method 'gnus-subscribe-hierarchically)

;; pour ceux qui veulent cliquer sur des boutons plutôt que d'utiliser
;; les raccourcis clavier cette option rajoute une espèce de barre
;; d'outil sur laquelle on peut cliquer.
                                        ;(setq gnus-carpal t)

;; génère le maximum de header à la création du message
;; plutôt qu'au moment de l'envoyer
;; si vous ne voyez pas à quoi ça sert, laisser donc le commentaire
(setq message-generate-headers-first t)

;; le nombre de jour de l'expire
(setq nnmail-expiry-wait 10)

;; à partir de combien d'articles demander la confirmation
;; d'ouverture d'un forum.
;; si vous n'utilisez pas un serveur local vous avez peut-être
;; intérêt à baisser cette valeur.
(setq gnus-large-newsgroup 1000)
;; Archives are marked as read when I send a message.
(setq gnus-gcc-mark-as-read t)

(add-to-list 'mm-inlined-types "application/msword")

(setq gnus-default-charset (quote iso-8859-1))
(setq message-default-charset (quote iso-8859-1)
      mm-body-charset-encoding-alist '((iso-8859-1 . 8bit)
                                       (iso-8859-15 . 8bit)
                                       (utf-8 . 8bit))
      )
(add-to-list 'mm-charset-synonym-alist '(iso8859-15 . iso-8859-15))
(add-to-list 'mm-charset-synonym-alist '(iso885915 . iso-8859-15))
(setq mm-coding-system-priorities
      '(iso-latin-1 iso-latin-9 mule-utf-8))

;; ! place the article in the cache.
;; making article (accessible even it expires server side
(setq gnus-use-cache t)
                                        ; View all the MIME parts in current article
(setq gnus-mime-view-all-parts t)
(setq gnus-ignored-mime-types
      '("text/x-vcard"))
;; all MIME parts get buttons.
(setq gnus-inhibit-mime-unbuttonizing t)
(setq
 gnus-treat-display-face 'head
 ;; Add buttons
 gnus-treat-buttonize t
 ;; Add buttons to the head
 gnus-treat-buttonize-head 'head
 ;; Emphasize text
 gnus-treat-emphasize t
 ;; Fill the article
 gnus-treat-fill-article nil
 ;; Remove carriage returns
 gnus-treat-strip-cr 'last
 ;; Hide headers
 gnus-treat-hide-headers 'head
 ;; Hide boring headers
 gnus-treat-hide-boring-headers 'head
 ;; Hide the signature
 gnus-treat-hide-signature nil
 ;; Hide cited text
 gnus-treat-hide-citation nil
 ;; Strip PEM signatures
 gnus-treat-strip-pem 'last
 ;; Highlight the headers
 gnus-treat-highlight-headers 'head
 ;; Highlight cited text
 gnus-treat-highlight-citation 'last
 ;; Highlight the signature
 gnus-treat-highlight-signature 'last
 ;; Display the Date in UT (GMT)
 gnus-treat-date-ut nil
 ;; Display the Date in the local timezone
 gnus-treat-date-local nil
 ;; Display the date in the original timezone
 gnus-treat-date-original nil
 ;; Strip trailing blank lines
 gnus-treat-strip-trailing-blank-lines 'last
 ;; Strip leading blank lines
 gnus-treat-strip-leading-blank-lines 'last
 ;; Strip multiple blank lines
 gnus-treat-strip-multiple-blank-lines 'last
 ;; Strip all blank lines
 ;; gnus-treat-strip-blank-lines nil
 ;; Treat overstrike highlighting
 gnus-treat-overstrike 'last
 )

;;* show the text/plain part before the text/html part in multpart/alternative
(require 'mm-decode)

;; ;; Read atom feed http://www.emacswiki.org/emacs/GnusRss#toc6
;; (require 'mm-url)
;; (defadvice mm-url-insert
;;     (after DE-convert-atom-to-rss () )
;;   "Converts atom to RSS by calling xsltproc."
;;   (when
;;       (re-search-forward
;;        "xmlns=\"http://www.w3.org/.*/Atom\""
;;        nil t)
;;     (goto-char (point-min))
;;     (message "Converting Atom to RSS... ")
;;     (call-process-region
;;      (point-min)
;;      (point-max)
;;      "xsltproc"
;;      t t nil
;;      (expand-file-name
;;       "~/emacs.d/etc/gnus/atom2rss.xsl") "-")
;;     (goto-char (point-min))
;;     (message
;;      "Converting Atom to RSS... done")))
;; (ad-activate 'mm-url-insert)


;;***********************
;; ARCHIVES: one file per month
(setq gnus-message-archive-group
      '((if (message-news-p)
            "news.sent"
          (concat "mail.sent" (format-time-string
                               "%Y-%m" (current-time)))))
      )


;;***********************
;;************* INTERFACE

(setq gnus-auto-select-first nil)

;;; I like it verbose
(setq gnus-verbose 2000)

;;; I wanna be able to access my previous post
(setq gnus-fetch-old-headers t)

;;; I wanna keep track of the last time I rode a group
(add-hook 'gnus-select-group-hook 'gnus-group-set-timestamp)

;;; Pour ne pas recopier les signatures
(setq message-cite-function 'message-cite-original-without-signature)

;;; Pour automatiser le décodage d'un article Usenet en mime/quoted-printable
(add-hook 'gnus-article-display-hook 'gnus-article-de-quoted-unreadable)

;;:*=======================
;;:* Mail-Copies-To - not me!
;;
;; I hate it when people reply to my posts on mailing lists or
;; newsgroups that I'm subscribed to and they send to the list or
;; newsgroup *and* Cc to me.  This function sets a "Mail-Copies-To:
;; never" header to any mailing list or newsgroup post.  It's just
;; a shame that there are so many broken MUA's out there that don't
;; honour this header.  Oh well, this cuts down a fair amount of
;; them.  Just hang this off `message-header-setup-hook'.
(defun steve-message-header-setup-hook ()
  (let ((group (or gnus-newsgroup-name "")))
    (when (or (message-fetch-field "newsgroups")
              (gnus-group-find-parameter group 'to-address)
              (gnus-group-find-parameter group 'to-list))
      (insert "Mail-Copies-To: never\n"))))
(add-hook 'message-header-setup-hook 'steve-message-header-setup-hook)

;;:*=======================
;;:* Signature Separator
(setq gnus-signature-separator
      '("^--$"
        "^-- *$"
        "^__.*$"))

;;;Apparence de la signature
(add-hook 'gnus-article-prepare-hook 'gnus-article-highlight-signature)

;;;increase the scoring of threads i participated
(add-hook 'message-sent-hook
          '(lambda ()
             (if (message-news-p)
                 (progn
                   (gnus-score-followup-article)
                   (gnus-score-followup-thread))))
          )

;;; Group* buffer: how to format each group entry.
;; The important thing in it is that we've replaced the normal %G in
;; it with %uG which instructs Gnus to run the function
;; gnus-user-format-function-G to get the string to put in the
;; group-line instead of the string "%uG".
(setq gnus-group-line-format
      "%M%m %4N/%5t : %-30,30G depuis le %2,2~(cut 6)\
d/%2,2~(cut 4)d à %2,2~(cut 9)dh%2,2~(cut 11)d\n"
      ;;
      ;; %var details C-h i
      ;;`M' An asterisk if the group only has marked articles.
      ;;'N' Number of unread articles.
      ;;`t' Estimated total number of articles.
      ;;`G' Group name.
      ;;`D' Newsgroup description.
      ;;`m' `%' (`gnus-new-mail-mark') if there has arrived new mail to the
      ;;    group lately.
      ;;`D' Last time the group as been accessed.
      ;;
      ;; For the record, a default group line format
      ;;(setq gnus-group-line-format "%M\%S\%p\%P\%5y: %(%-40,40g%) %6,6~(cut 2)d\n")
      )
;;;--------------------------------------------
;;; Gnus summary avec les threads en arbre, ...
(setq gnus-sum-thread-tree-indent "  ")

(if window-system
    (setq
     gnus-sum-thread-tree-root "\x25CF "
     gnus-sum-thread-tree-leaf-with-other "\x251C\x2500\x2500\x25BA "
     gnus-sum-thread-tree-single-leaf "\x2514\x2500\x25BA "
     gnus-sum-thread-tree-vertical "\x2502")
  (setq gnus-sum-thread-tree-root "> "                        ; "> "
        gnus-sum-thread-tree-false-root "> "                  ; "> "
        gnus-sum-thread-tree-single-indent ""                 ; ""
        gnus-sum-thread-tree-leaf-with-other "+-> "           ; "+-> "
        gnus-sum-thread-tree-vertical "| "                    ; "| "
        gnus-sum-thread-tree-single-leaf "`-> "))


;; `s' Subject if the article is the root of the thread or the previous
;;     article had a different subject, `gnus-summary-same-subject'
;;     otherwise.  (`gnus-summary-same-subject' defaults to `""'.)
;; `n' The name (from the `From' header).
;; `L' Number of lines in the article.
;; `I' Indentation based on thread level (*note Customizing Threading::).
;; `>' One space for each thread level.
;; `<' Twenty minus thread level spaces.
;; `U' Unread.
;; `R' This misleadingly named specifier is the "secondary mark".  This
;;     mark will say whether the article has been replied to, has been
;;     cached, or has been saved.
;; `D'  `Date'.
;; `d'  The `Date' in `DD-MMM' format.
;;`o'     The `Date' in YYYYMMDD`T'HHMMSS format.
;;
;; For the record the default string is
;; `%U%R%z%I%(%[%4L: %-20,20n%]%) %s\n'.

;; Valeur pas défaut de `gnus-summary-line-format'
;; (setq gnus-summary-line-format "%U%R%z%I%(%[%4L: %-20,20n%]%) %s\n")
(setq
 gnus-summary-line-format (concat
                           "%U%R%z"     ;info
                           "%4{|%} "
                           "%5{%-10&user-date;%}"
                           ;; "%5{%2,2~(cut 6)o/%2,2~(cut 4)o %2,2~(cut 9)oh%2,2~(cut 11)\ o%} " ;date
                           "%4{|%} "
                           "%5{%-4,4L%}" ;nb ligne
                           "%4{|%}"
                           "%2{%[%}%6{%-20,20f<%-20,20A>%}%2{%]-%}" ;auteur long
                           ;; "%2{%[%}%6{%-24,24f%}%2{%]-%}" ;; auteur court
                           "%3{%B%}"    ;Arbre
                           "%S\n" ;sujet. %s pour n'avoir que le sujet à la racine
                           )
 ;;  gnus-summary-same-subject ""
 gnus-summary-mode-line-format "%V: %%b"
 )

;; affichage de la date en relatif
;; http://sebastien.kirche.free.fr/emacs_stuff/gnus.html
(setq gnus-user-date-format-alist
      '(((gnus-seconds-today) . "     %k:%M") ;dans la journée =      14:39
        ((+ 86400 (gnus-seconds-today)) . "hier %k:%M") ;hier            = hier 14:39
        ((+ 604800 (gnus-seconds-today)) . "%a  %k:%M") ;dans la semaine = sam  14:39
        ((gnus-seconds-month) . "%a  %d") ;ce mois         = sam  28
        ((gnus-seconds-year) . "%b %d")   ;durant l'année  = mai  28
        (t . "%b %d '%y")))             ;le reste        = mai  28 '05
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(cond (window-system
       (copy-face 'default 'mysubject)
       (setq gnus-face-1 'mysubject)

       (copy-face 'default 'myblack)
       (set-face-foreground 'myblack "black")
       (set-face-bold-p 'myblack nil)
       (setq gnus-face-2 'myblack)

       (make-face 'mytree)
       ;; (copy-face 'default 'mytree)
       (set-face-foreground 'mytree "black")
       (set-face-font 'mytree "-misc-fixed-*-*-*-*-*-140-*-*-*-*-*-*")
       (set-face-bold-p 'mytree nil)
       (setq gnus-face-3 'mytree)

       (copy-face 'default 'mygrey)
       (set-face-foreground 'mygrey "grey")
       (setq gnus-face-4 'mygrey)

       (copy-face 'default 'mygreyblack)
       (set-face-foreground 'mygreyblack "grey50")
       (setq gnus-face-5 'mygreyblack)

       (copy-face 'default 'myname)
       (set-face-foreground 'myname "light slate gray")
       (set-face-bold-p 'myname t)
       (setq gnus-face-6 'myname)
       ))

;;---------------------------------------------------------------------
;; Window configuration.
(if (eq window-system 'x)
    (progn
      (gnus-add-configuration
       '(article
         (vertical 1.0
                   (horizontal 0.3
                               ;;           ("*BBDB*" 0.4)
                               (summary 1.0 point))
                   (horizontal 1.0
                               ;;          (group 0.3)
                               (article 1.0)))))
      (gnus-add-configuration
       '(summary
         (horizontal 1.0
                     (vertical 1.0
                               ;;           ("*BBDB*" 0.25)
                                        ;             (group 1.0))
                               (summary 1.0))
                     )))

      (gnus-add-configuration
       '(reply
         (vertical 1.0
                   (article 0.3)
                   (message 1.0 point))))
      )
  )

;;*************************
;;*Décoaration des groupes*
;;*************************
(setq font-lock-maximum-decoration t
      font-lock-maximum-size nil)
(require 'font-lock)
(cond (window-system
       (setq custom-background-mode 'light)
       (defface pi-group-face-1
         '((t (:foreground "Red" :bold t))) "First group face")
       (defface pi-group-face-2
         '((t (:foreground "#E0E033" :bold t))) "Second group face")
       (defface pi-group-face-3
         '((t (:foreground "Green2" :bold t))) "Third group face")
       (defface pi-group-face-4
         '((t (:foreground "SteelBlue" :bold t))) "Fourth group face")
       (defface pi-group-face-5
         '((t (:foreground "SkyBlue" :bold t))) "Fifth group face")
       (defface pi-group-face-6
         '((t (:foreground "grey" :bold t))) "Fourth group face")
       (defface pi-group-face-7
         '((t (:foreground "white" :bold t))) "Fourth group face")
       (setq gnus-group-highlight
             '(
               ;;coloration pour les mails
               ((and mailp (zerop unread)) . pi-group-face-3)
               ((and mailp (not(zerop unread))) . pi-group-face-1)
               ;;coloration pour les flux RSS
               ((and (string= (elt method 0) "nnrss") (zerop unread)) . pi-group-face-6)
               ((and (string= (elt method 0) "nnrss") (not(zerop unread))) . pi-group-face-7)
               ;;coloration pour les newsgroup
               ((string= (elt method 0) "nntp") . pi-group-face-5)
               ;;les autres
               ((zerop unread) . pi-group-face-4)
               (t . pi-group-face-5)
               ))))

;;*****************************
;; Décoration du summary-mode*
;;*****************************
(add-hook 'gnus-summary-mode-hook 'pi-setup-hl-line)
(add-hook 'gnus-group-mode-hook 'pi-setup-hl-line)

(defun pi-setup-hl-line ()
  (hl-line-mode 1)       ;; accentue la ligne courante
  (setq cursor-type nil) ;; Comment this out, if you want the cursor to
                                        ; stay visible.
  ;; En attendant la correction d'un bogue on fixe la variable `srcoll-margin' a 0.
  (set (make-local-variable 'scroll-margin) 0) ;; Une autre valeur peut poser des problème
  )


;; permet de développer, respectivement réduire les threads en appuyant
;; sur la touche "flèche gauche", respectivement "flèche droite"
;; Sur une idée de Ingo Ruhnke <grumbel@gmx.de>
(defun pi-gnus-summary-show-thread ()
  "Show thread without changing cursor positon."
  (interactive)
  (gnus-summary-show-thread)
  (beginning-of-line)
  (forward-char 1))
(define-key gnus-summary-mode-map [(right)] 'pi-gnus-summary-show-thread)
(define-key gnus-summary-mode-map [(left)]  'gnus-summary-hide-thread)

;; I want my replies to begin with something like "<user> writes:"
(defun message-insert-citation-line ()
  "La fonction qui insere une ligne aux reponses"
  (when message-reply-headers
    (let ((_la_date_ (gnus-date-get-time (mail-header-date message-reply-headers))))
      (if (string-match "AREGEXP" gnus-newsgroup-name) ;; Inutilisé pour l'instant...
          (progn
            (insert "Le "
                    (format-time-string "%d" _la_date_) " "
                    (elt calendar-month-name-array (- (string-to-number (format-time-string "%m" _la_date_)) 1)) " "
                    (format-time-string "%Y" _la_date_)
                    ", vous avez écrit :\n\n"))
        (progn
          (insert "Le "
                  (format-time-string "%d" _la_date_) " "
                  (elt calendar-month-name-array (- (string-to-number (format-time-string "%m" _la_date_)) 1)) " "
                  (format-time-string "%Y" _la_date_)
                  ", "
                  (replace-regexp-in-string
                   "\"" ""
                   (replace-regexp-in-string "<.*>" "" (mail-header-from message-reply-headers)))
                  "a écrit :\n\n"))))))

;;:*=======================
;;:* Splitting mail
;;
;; This sorts the mail into various mail groups.  Yeah, sure you could
;; use procmail to do this, but why use procmail when you can use
;; lisp. :-) Besides, once you get used to it, splitting mail with
;; Gnus is easier than with procmail.
;;
;; M-: (Info-goto-node "(gnus)Splitting Mail") RET
;; M-: (Info-goto-node "(gnus)Fancy Mail Splitting") RET
;;
;; Some split abbrevs to make things a little easier.
(setq nnmail-split-abbrev-alist
      '((any . "from\\|to\\|cc\\|sender\\|apparently-to\\|resent-from\\|resent-to\\|resent-cc\\|reply-To")
        (mail . "mailer-daemon\\|postmaster\\|uucp")
        (to . "to\\|cc\\|apparently-to\\|resent-to\\|resent-cc")
        (from . "from\\|sender\\|resent-from")
        (nato . "to\\|cc\\|resent-to\\|resent-cc")
        (naany . "from\\|to\\|cc\\|sender\\|resent-from\\|resent-to\\|resent-cc")))

;; I use fancy mail splitting.
(setq nnmail-split-methods 'nnmail-split-fancy
      nnmail-message-id-cache-length 5000
      nnmail-crosspost nil
      nnmail-split-fancy '(|
                           (to ".*pi2009@sfr\\.fr.*" "mail.2009")
                           (to ".*pi2011@sfr\\.fr.*" "mail.2011")
                           ("Subject"
                            "\\(Logs:.*\\|Mail Stats\\|eicq Daily Usenet\\|var/log/.*\\)" "private.logs")
                           (from ".*redmine.*" "mail.rcv.redmine")
                           (from ".*linkedin.com" "list.linkedin")
                           (any ".*@piprime\\.fr" "INBOX.piprime")
                           (any ".*veille@ml.geonef.fr.*" "list.veille.geonef")
                           (any ".*syracuse@melusine.eu.org.*" "list.syracuse")
                           ("Subject\\|to" ".*\\[asymptote - Help\\].*\\|.*asymptote-developers@lists.sourceforge.net.*" "list.asymptote")
                           ("Subject" ".*\\[cphalcon\\].*" "list.phalcon")
                           (any ".*AmiTeX.*" "list.AmiTeX")
                           (any ".*debian-user-french.*" "list.debian-user-french")
                           ;;Achat
                           (any ".*amazon.*\\|.*rueducommerce.*\\|.*Surcouf.*\\|.*cdiscount.*\\|.*ldlc.com" "mail.achat")
                           (any ".*ebay.*\\|.*eBay.*" "mail.ebay")
                           ;; To me, personally
                           (naany "Bowman\\|Hammerlindl\\|Shardt" "mail.asy-dev")
                           (from "gandi.net" "mail.gandi")
                           (from ".*@guideregional\\.fr.*" "mail.gr-interne")
                           (to ".*@guideregional\\.fr.*" "mail.guideregional.fr")
                           (any ".*@lescastanies\\.fr.*" "mail.lescastanies")
                           (to ".*philippe.ivaldi@sfr\\.fr.*" "mail.sfr")
                           (any ".*cpro\\.bug@ovya\\.fr.*" "mail.bug.cpro")
                           (any "\\(.*@ovya\\.fr.*\\)\\|\\(.*@costes-.*\\)" "mail.ovya")
                           (to ".*pivaldi@sfr\\.fr.*" "mail.pivaldi")
                           (to ".*ac-montpellier\\.fr.*" "mail.montpellier")
                           ;; Catch all
                           "inbox.unsorted"))
(setq nnmail-resplit-incoming t) ;active le splitting avec procmail ???
;;:=========================================================================


;; ,----
;; | spliting move/copy, default rules
;; `----
(setq gnus-move-split-methods
      '((from ".*julesfil.*" "sauv_Jules_Fil")
        (to ".*@ac-montpellier\\.fr.*" "sauv_montpellier")
        ("^Newsgroups:.*emacs" "sauv_emacs")
        ("^Newsgroups:\\(.*linux\\)\\|\\(.*unix\\)" "sauv_linux")
        ("^Newsgroups:.*unix" "sauv_linux")
        ("^Newsgroups:.*tex" "sauv_tex")
        ("^Newsgroups.*math" "sauv_maths")
        (".*" "nnfolder:sauv_divers")))

;;Fonction utiliser pour gérer les identités dans les liste
;;avec gnus-alias-select-indentity (voir gnus-alias-identity-rules)
(define-key message-mode-map "\C-c\C-p" 'gnus-alias-select-identity)


;;Def d'une fonction utilisée par gnus non présente dans emacs22
(defun message-functionp (form)
  "Return non-nil if FORM is funcallable."
  (or (and (symbolp form) (fboundp form))
      (and (listp form) (eq (car form) 'lambda))))


;;*********************
;;Displaing du header *
;;*********************
(setq
 gnus-visible-headers "^From:\\|^Reply-To:\\|^Return-Path:\\|^Subject:\\|^Date:\\|^Newsgroups:\\|^X-Mailer:\\|^X-Newsreader:\\|^Organization:\\|^Organisation:\\|^Followup-To:\\|^User-Agent:\\|^X-User-Agent:\\|^To:\\|^Cc:\\|^Approved:\\|^Content-Type:\\|^Summary:\\|^[BGF]?Cc:\\|^X-Gnus-Warning:\\|^X-Diary"

 gnus-sorted-header-list '("^From:"  "^Reply-To:" "^To:" "^Cc:"
                           "^Followup-To:" "^Return-Path:"
                           "^[BGF]?Cc:" "^Subject:" "^Newsgroups:"
                           "^Date:" "^X-Mailer:" "^X-Newsreader:" "^User-Agent:"
                           "^X-User-Agent:" "^Organization:"
                           "^Organisation:" "^Approved:" "^Summary:" "^Content-Type:" "^X-Gnus-Warning:" "^X-Diary")
 )
;;---------------------------------------------------------------------

;; Support X-face
(setq gnus-treat-display-x-face 'head)

;; I don't want HTML nor richText.
(setq mm-discouraged-alternatives '("text/html" "text/richtext"))
(setq mm-text-html-renderer 'w3m)
;; Open link with browse-url
(add-hook 'gnus-article-mode-hook
          (lambda ()
            (set (make-local-variable 'w3m-goto-article-function)
                 'browse-url)))

;;:*=======================
;;:* Sorting group
(setq gnus-group-sort-function
      '(gnus-group-sort-by-method
        gnus-group-sort-by-alphabet))

;; ---------------------- ;;
;; Implementation Of BBDD ;;
;; ---------------------- ;;
;;; Which a data-base very usefull for gnus.
;;; Don't wait and get it at http://bbdb.sourceforge.net/
(require 'bbdb)

;; initialization
(bbdb-initialize 'gnus 'message)
(bbdb-mua-auto-update-init 'gnus 'message)

;; What do we do when invoking bbdb interactively
(setq bbdb-mua-update-interactive-p '(query . create))

;; Make sure we look at every address in a message and not only the
;; first one
(setq bbdb-message-all-addresses t)

;; To force bbdb to cite the name *and* address of people when
;; completing address.
;; Expl : Matthieu Moy <matthieu.moy@imag.fr>
(setq bbdb-dwim-net-address-allow-redundancy t)
;; (defadvice bbdb-complete-name
;;     (after bbdb-complete-name-default-domain activate)
;;   (let* ((completed ad-return-value))
;;     (if (null completed)
;;         (expand-abbrev))))

;; If non-nil, display an auto-updated BBDB window while using a MUA.
;; If ’horiz, stack the window horizontally if there is room.
;; If this is nil, BBDB is updated silently.
(setq bbdb-mua-pop-up nil)

;; use : on a message to invoke bbdb interactively
(add-hook
 'gnus-summary-mode-hook
 (lambda ()
   (define-key gnus-summary-mode-map (kbd ":") 'bbdb-mua-edit-field)
   (define-key gnus-group-mode-map (kbd "S-<iso-lefttab>") 'gnus-topic-unindent)
))
;;; end of BBDB configuration


;;=======================
;;* Scan for new mail every x minutes.
(setq
 gnus-play-sound-for-new-mail-p nil
 gnus-sound-command-for-new-mail "/usr/bin/play ~/Documents/mes_sons/system/Nouveau_message.wav")

(defun drkm-gnus-grp:number-of-unread-mail (level)
  "Return the number of unread mails in groups of LEVEL and below."
  (let ((total 0))
    (dolist (rc (cdr gnus-newsrc-alist) total)
      (when (<= (gnus-info-level rc) level)
        (let ((unread (gnus-group-unread (gnus-info-group rc))))
          (when (integerp unread)
            (incf total unread)))))))

;;Mes mails sont mis au niveau 2 (recommandé) (raccourcis 'S-l prompt 2')
(require 'gnus-demon)

(defun pi-notify-message ()
  "Notifying new emails."
  (if (> number-of-unread last-time-number-of-unread)
      (progn
        ;;Il y a des nouveaux messages
        (if gnus-play-sound-for-new-mail-p
            (shell-command gnus-sound-command-for-new-mail))
        (message (let ((number-of-new (- number-of-unread last-time-number-of-unread))
                       (plus (if (> (- number-of-unread last-time-number-of-unread) 1) "s" "")))
                   (concat
                    "***** "
                    (int-to-string number-of-new)
                    " nouveau" (if (> number-of-new 1) "x" "")
                    " message" plus
                    " reçu" plus " *****"
                    (if (> number-of-unread last-time-number-of-unread)
                        (concat
                         " (+ "
                         (int-to-string last-time-number-of-unread)
                         " ancien"
                         (if (> last-time-number-of-unread 1) "s" "")
                         ")"))))))
    (if (= number-of-unread 0)
        (message "-- Pas de nouveau message --")
      (message
       (let ((plus (if (> number-of-unread 1) "s" "")))
         (concat "** "
                 (int-to-string number-of-unread)
                 " ancien" plus " message" plus " non-lu" plus " **"
                 ))))))

(defun pi-gnus-demon-handler ()
  "Scan for new mail."
  (interactive)
  (message "Vérification des nouveaux messages ...")
  (let ((cpoint (point)))
    (save-window-excursion
      ;;   (save-excursion
      (when (gnus-alive-p)
        (set-buffer gnus-group-buffer)
        (gnus-group-get-new-news 2 t)
        (setq last-time-number-of-unread number-of-unread)
        (setq number-of-unread (drkm-gnus-grp:number-of-unread-mail 2))
        (pi-notify-message)))
    ))

(setq last-time-number-of-unread 0)
(setq number-of-unread 0)

(setq gnus-demon-timestep 60)
(gnus-demon-add-handler 'pi-gnus-demon-handler 1 1)
;;(gnus-demon-add-handler 'gnus-group-get-new-news 15 10);;risque de plantage...
(gnus-demon-init)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;:*=======================
;;:* Neato things with Subject headers.
;; I think this stuff is now part of Gnus proper.

(defconst steve-obsolete-subject " (?était: .*"
  "*Regexp matching obsolete subjects.")

(defun steve-clear-subject ()
  "Remove steve-obsolete-subject from subject-header."
  (interactive)
  (let ((case-fold-search nil))
    (save-excursion
      (goto-line 0)
      (re-search-forward "^Subject: ")
      (if (re-search-forward steve-obsolete-subject nil t)
          (replace-match "")))))

(defun etait (new-subject)
  "Introduces new subject.
Argument NEW-SUBJECT The subject to change to."
  (interactive "sNew Subject: ")
  (let ((case-fold-search nil))
    (save-excursion
      (goto-line 0)
      (re-search-forward "^Subject: ")
      (if (re-search-forward "R[Ee]: " nil t)
          (replace-match ""))
      (insert new-subject)
      (insert " (était: ")
      (end-of-line)
      (insert ")"))))

;; Pour  éviter  le  problème  des  lignes  longues,  tu  peux  faire  avec
;; filladapt (dans le .gnus):
;; Avec ça  tu reformattes les  lignes intelligemment, faut juste  des fois
;; mettre  un coup  de  M-x filladapt-mode  pour désactiver  temporairement
;; quand tu veux poster des extraits de code sinon il reformatte ça aussi.
;; M-q aide aussi pour formatter un paragraphe.
;; Auteur : Sébastien Kirche
;; Couper les lignes à X caractères pour rédiger

;; (require 'filladapt)
(defun sk-gnus-message-hook ()
  (set-fill-column 72)
  (turn-on-auto-fill)
  ;; (filladapt-mode)
  (setq adaptive-fill-mode t)
  (flyspell-mode 1)
  (footnote-mode)
  (setq footnote-spaced-footnotes nil
        footnote-section-tag      ""
        footnote-style            'latin))

(add-hook 'message-mode-hook 'sk-gnus-message-hook)
(font-lock-add-keywords
 'message-mode
 '(("^[^\n]\\{72\\}\\(.*\\)$"
    1 font-lock-warning-face prepend)))
;; Raccourci pour les ciseaux (originalement scissors mais renomé `separe')
(when (fboundp 'separe) (define-key message-mode-map (kbd "M-s") 'separe))

;; Quitter Emacs proprement
(push (lambda () (when (gnus-alive-p) (gnus-group-exit)))
      kill-emacs-hook)

;; Ne pas se tromper en répondant
;; Tous les messages postés depuis le nom list.bidule utilise l'identité liste
;; et R demande si l'on veut vraiment répondre à l'auteur.
;; Voir la variable gnus-alias-identity-rules
(defun pi-group-name-list-p ()
  "Retourne t si le nom du groupe contient la chaine list."
  (interactive)
  (string-match "^list\." gnus-newsgroup-name))

(defun y-n-p-or-followup nil
  (if (y-or-n-p "Voulez-vous vraiment répondre à l'auteur ? ")
      t (gnus-summary-followup-with-original 1)))

(defadvice gnus-summary-reply (around reply-in-news activate)
  "Ask for correct replying."
  (interactive)
  (if (or (and (not (pi-group-name-list-p)) (not (gnus-news-group-p gnus-newsgroup-name)))
          (not (gnus-news-group-p gnus-newsgroup-name))
          (y-n-p-or-followup))
      ad-do-it))


;; (when (require 'nnrss nil t)
;;   (add-to-list 'nnmail-extra-headers nnrss-description-field)
;;   (add-to-list 'nnmail-extra-headers nnrss-url-field)

;;   ;; from usenet : "The following code may be useful to open an nnrss
;;   ;; url directly from the summary buffer."
;;   (defun browse-nnrss-url( arg )
;;     (interactive "p")
;;     (let ((url (assq nnrss-url-field
;;                      (mail-header-extra
;;                       (gnus-data-header
;;                        (assq (gnus-summary-article-number)
;;                              gnus-newsgroup-data))))))
;;       (if url
;;           (browse-url (cdr url))
;;         (gnus-summary-scroll-up arg))))

;;   ;;
;;   ;; do some special twiddling when we're reading nnrss groups
;;   ;; - turn off threading
;;   ;; - make C-c RET open the RSS item's URL in our browser
;;   ;; - apply our customized summary line formats
;;   ;;
;;   (add-hook 'gnus-summary-mode-hook
;;             (lambda ()
;;               (if (string-match "nnrss" gnus-newsgroup-name)
;;                   (progn
;;                     (make-local-variable 'gnus-show-threads)
;;                     (make-local-variable 'gnus-article-sort-functions)
;;                     (make-local-variable 'gnus-use-adaptive-scoring)
;;                     (make-local-variable 'gnus-use-scoring)
;;                     (make-local-variable 'gnus-score-find-score-files-function)
;;                     (make-local-variable 'gnus-summary-line-format)

;;                     (define-key gnus-summary-mode-map (kbd "C-c <RET>") 'browse-nnrss-url)

;;                     (setq gnus-show-threads nil)
;;                     (setq gnus-article-sort-functions 'gnus-article-sort-by-subject)

;;                     (setq gnus-use-adaptive-scoring nil)
;;                     (setq gnus-use-scoring t)
;;                     (setq gnus-score-find-score-files-function 'gnus-score-find-single)
;;                     (setq gnus-summary-line-format "%U%R%z%d %I%(%[ %s  ]%)\n")
;;                     ;;  )
;;                     ))))
;;   )

;; (setq
;;  ;; Yay (seen here: `https://github.com/cofi/dotfiles/blob/master/gnus.el')
;;  ;; gnus-cached-mark ?☍
;;  ;; gnus-canceled-mark ?↗
;;  gnus-del-mark ?✗
;;  ;; gnus-dormant-mark ?⚐
;;  gnus-expirable-mark ?♻
;;  gnus-forwarded-mark ?↪
;;  ;; gnus-killed-mark ?☠
;;  ;; gnus-process-mark ?⚙
;;  gnus-read-mark ?✓
;;  gnus-recent-mark ?✩
;;  gnus-replied-mark ?↺
;;  gnus-unread-mark ?✉
;;  ;; gnus-unseen-mark ?★
;;  ;; gnus-ticked-mark ?⚑
;;  )

;; Handle icalendar meeting requests
(require 'gnus-icalendar)
(gnus-icalendar-setup)

(setq gnus-buttonized-mime-types
      '("multipart/encrypted" "multipart/signed"))

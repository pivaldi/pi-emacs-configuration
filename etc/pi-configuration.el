;;: -*- emacs-Lisp-mode -*-
;;; pi-configuration.el
;;; Author: Philippe Ivaldi

;; Fix missing warning-suppress-types function
(setq warning-suppress-types nil)

(require 'cl)

;; *=======================================================*
;; *..................Paramètres généraux..................*
;; *=======================================================*

;; ----------
;; * Divers *
(setq
 ;; Format du titre
 frame-title-format (list user-real-login-name "@" system-name " : %S" 'default-directory "%b")
 inhibit-startup-message t ;;inibe les messages de Scratch
 ;; Remplace la cloche par un clignotement de la fenêtre
 visible-bell t
 ;; Pour ne pas que Emacs utilise une boîte de dialog graphique
 use-dialog-box nil
 use-file-dialog nil
 tab-width 4
 ;; Le menu buffer n'a pas de taille maximum
 buffers-menu-max-size nil
 ;; fixe la taille de l'historique (t pour infinie !?)
 history-length 200
 ;; Pour que le scroll avec le curseur soit de 1.
 scroll-step 1
 scroll-conservatively 10000
 ;; Pour que kill-line (C-k) coupe la ligne _et_ son newline quand elle est
 ;; invoquée en début de ligne :
 kill-whole-line t
 ;; Augmente le nombre de reccursion des macros
 ;; On peut aussi le mettre à 9999 mais il peut alors y avoir des débordement de pile.
 max-lisp-eval-depth 5000
 max-specpdl-size max-lisp-eval-depth
 ;;permet d'ignorer la case dans le mode d'achévement
 completion-ignore-case t
 read-file-name-completion-ignore-case t
 ;; Stick backup files in temporary directory
 backup-directory-alist '(("." . "~/back.emacs"))
 auto-save-file-name-transforms `((".*" , "~/back.emacs" t))
 ;;when the mark is active, the region is highlighted.
 transient-mark-mode t
 ;; save everything before compiling
 compilation-ask-about-save nil
 ;; Taille de la fenêtre de compilation.
 compilation-window-height 12
 ;; Non-nil to scroll the *compilation* buffer window as output appears.
 compilation-scroll-output t
 ;; Autorise les variable locales
 enable-local-variables t
 ;; Controls if scroll commands move point to keep its screen line unchanged.
 scroll-preserve-screen-position t
 ;; Number of lines of margin at the top and bottom of a window.
 ;; Pose des problèmes avec la version de gnus que j'utilise actuellement...
 ;; rajouter (set (make-local-variable 'scroll-margin 0)) dans le hook de `gnus-summary-mode-hook'
 scroll-margin 4
 ;; Maximum number of lines to keep in the message log buffer.
 message-log-max 1000
 ;; `apropos' cherche tout:
 apropos-do-all t ;; raccourcis "C-h a" plus loin.
 ;; ignorer DE PLUS les fichiers dont le nom se termine par ces suffixes.
 completion-ignored-extensions (append
                                '(".mpx" ".toc" ".nav")
                                completion-ignored-extensions)
 ;; Show all files in the speedbar
 speedbar-show-unknown-files t
 ;; The default grep-find-command is optimized but failed on big directory tree
 grep-find-command '("find . -type f ! -regex '.*\\.svn/.*' ! -regex '.*\\.git/.*' -exec grep -Hni '' {} \\;" . 77)
 grep-compute-defaults grep-find-command
 skeleton-pair t
 ;; Fill bulleted and indented lines
 adaptive-fill-mode t
 ;; Do not add a new string to `kill-ring' when it is the same as the last one.
 kill-do-not-save-duplicates t
 ;; split window preferred horizontally
 split-width-threshold most-positive-fixnum
 )

;; (eval-after-load 'grep
;;   '(progn
;;      (grep-apply-setting
;;       'grep-find-command
;;       '("find . -type f ! -regex '.*\\.svn/.*' -exec grep -Hni '' {} \\;" . 55))))

;; M-x c'est quand même super puissant et ça décharge les raccourcis
;; en plus il y a  le complètement
(defalias '_ll 'longlines-mode)
(defalias '_rb 'revert-buffer)
(defalias '_etw 'ecb-toggle-ecb-windows)
(defalias '_ar 'align-regexp)
(defalias '_gf 'grep-find)
(defalias '_afm 'auto-fill-mode)
(defalias '_sur 'smallurl-replace-at-point)
(defalias '_ib 'ibuffer-list-buffers)

;; After selecting a region, inserting a new character will overwrite
;; the whole region
(delete-selection-mode 1)

;; Standardise l'indentation
;; C-c C-o, met la commande qui gere l'indentation de la ligne
;; par exemple : substatement-open <ret> 4 <ret>.
(defun pi-c-indent-setup ()
  (setq c-basic-offset 2)
  (c-set-offset 'substatement-open '0)
  (c-set-offset 'brace-list-open '0)
  (c-set-offset 'arglist-close '0)
  (c-set-offset 'statement-case-open '0)
  (c-set-offset 'arglist-cont-nonempty '4)
  (c-set-offset 'arglist-intro 'c-basic-offset)
  )
;; (add-hook 'c-mode-hook 'pi-c-indent-setup)
(add-hook 'c++-mode-hook 'pi-c-indent-setup)


;; Voir les espaces inutiles
(setq-default show-trailing-whitespace t)
(setq-default show-leading-whitespace t)
(setq nobreak-char-display t)
;; Draw some chars with the same color as nobreak-char
;; (add-hook 'font-lock-mode-hook
;;           (lambda ()
;;             (font-lock-add-keywords
;;              nil
;;              '((" \\| \\| \\| \\| \\| \\| \\| \\| \\| \\|​\\|‌\\|‍\\|‎\\|‏\\| \\| \\|⁠\\|⠀\\|　\\|﻿\\|\t"
;;                 0 'nobreak-space prepend)))))
;; la face utilisée pour les espaces inutiles.
(set-face-attribute 'trailing-whitespace nil
                    :background "#2F4545")

(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))

;; Remplace yes/no <RET> par y/n.
(fset 'yes-or-no-p 'y-or-n-p)
;;Permanently force Emacs to indent with spaces, never with TABs:
(setq-default indent-tabs-mode nil)
;; Afficher numéro ligne/colonne dans la ligne de mode
(line-number-mode t)
(column-number-mode t)
;; Pour lire automatiquement les .gz et les zip
(auto-compression-mode 1)
;; Pour lire des images directement
(auto-image-file-mode t)
;; ibuffer est beucoup mieux que list-buffer
(defalias 'ibuffer 'list-buffer)

;; -------------------------
;; * Coloration syntaxique *
;;; Coloration maximum
(setq-default font-lock-maximum-decoration t)
;; Active la coloration dans tous les modes
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1))

;; ---------------
;; * Les accents *
(prefer-coding-system 'utf-8)

;; ------------------------------
;; * Suivi des fichiers récents *
(when (require 'recentf "recentf.elc" t)
  (setq recentf-save-file (concat (cuid ".recentf-") (user-real-login-name)))
  (recentf-mode 1))

;; ------------------------------------
;; * Sauvegarde de l'état des buffers *
;; If desktop saving is turned on, the state of Emacs is saved from
;; one session to another
;; The first time you save the state of the Emacs session, you must do
;; it manually, with the command `M-x desktop-save'.
(require 'desktop)
;; The directory in which the desktop file should be saved.
(setq desktop-dirname (cuid ""))
;; Name of file for Emacs desktop, excluding the directory part.
(setq desktop-base-file-name (concat ".desktop-" (user-real-login-name)))
;; Utiliser plutôt M-x customize-variable pour modifier cette variable
;; (setq desktop-save-mode t)
;; Toujours sauvegarder le "desktop" sans confirmation.
(setq desktop-save t)
(when (> emacs-major-version 21)
  ;; Activation
  (desktop-save-mode 1))
;; Ne pas rouvrir les fichiers suivants:
(setq desktop-buffers-not-to-save
      (concat "\\(" "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
              "\\|\\.el\\.gz\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
              "\\)$"))
;; Ne pas rouvrir les modes suivants:
(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

;; ----------------------------
;; * Sauver la place du point *
(require 'saveplace)
(setq-default save-place t) ;; activation
(setq save-place-file (concat (cuid ".places-") (user-real-login-name)))
(setq bookmark-default-file (concat (cuid ".bookmarks-") (user-real-login-name)))

;; -----------------------------------------
;; * Sauvegarder l'historique des actions. *
(when (require 'savehist "savehist.elc" t) ;;Part of emacs22
  (setq savehist-file (concat (cuid ".history-") (user-real-login-name)))
  ;; activation
  (savehist-mode t))

;; ----------------------------------------------------
;; * Auto-fill: coupure automatique de lignes longues *
;; ;; Pour ne pas que le mode auto-fill coupe à l'endroit d'un ":" ou ";" etc..
;; ;; Auteur: Matieux Moy http://www-verimag.imag.fr/~moy/emacs/
;; (defun pi-fill-nobreak-predicate ()
;;   (save-match-data
;;     (or (looking-at "[ \t]*[])}»!?;:]")
;;         (looking-at "[ \t]*\\.\\.\\.")
;;         (save-excursion
;;           (skip-chars-backward " \t")
;;           (backward-char 1)
;;           (looking-at "[([{«]")))))
;; (setq fill-nobreak-predicate (list 'pi-fill-nobreak-predicate))

;; Pas en mode auto-fill en lisp
(add-hook 'lisp-mode-hook 'turn-off-auto-fill)
(dolist (hook pi-auto-fill-mode-hook-alist)
  (add-hook hook
            (lambda ()
              (auto-fill-mode 1))))

;; -------------------------------------------------------
;; * Rendre exécutable certains fichiers à la sauvegarde *
;; From http://www.emacswiki.org/emacs/MakingScriptsExecutableOnSave
(defun hlu-make-script-executable ()
  "If file starts with a shebang, make `buffer-file-name' executable"
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-min))
      (when (and (looking-at "^#!")
                 (not (file-executable-p buffer-file-name)))
        (set-file-modes buffer-file-name
                        (logior (file-modes buffer-file-name) #o100))
        (message (concat "Made " buffer-file-name " executable"))))))
(add-hook 'after-save-hook 'hlu-make-script-executable)

;; -----------------------------------------------------
;; * Active le serveur Emacs pour utiliser emacsclient *
(when (string= system-type "gnu/linux")
  (require 'server)
  (unless server-process (server-start)))

;; ---------------------------
;; * Numérotation des lignes *
;; Pour basculer avec/sans M-x linum <RET>
(require 'linum)

;; ----------------
;; * Windows mode *
;;; Windows.el  enables  you  to  have  multiple  favorite  window
;;; configurations at the same  time, and switch them.  Furthermore,
;;; it  can  save  all  window  configurations and  some  global  or
;;; buffer-local variables into a file and restore them correctly.
;;;	  The default prefix key stroke for Windows is `C-c C-w'.  If it
;;;	causes  you some  troubles, see  the  section  `Customizations'.
;;;	Here are the default key bindings.
;;;
;;;		C-c C-w 1		Switch to window 1 (Q)
;;;		C-c C-w 2		Switch to window 2 (Q)
;;;		   :
;;;		C-c C-w 9		Switch to window 9 (Q)
;;;		C-c C-w 0		Swap windows with the buffer 0 (Q)
;;;					(Select unallocated frame(Emacs 19))
;;;		C-c C-w SPC		Switch to window previously shown (Q)
;;;		C-c C-w C-n		Switch to next window
;;;		C-c C-w C-p		Switch to previous window
;;;		C-c C-w !		Delete current window (Q)
;;;		C-c C-w C-w		Window operation menu
;;;		C-c C-w C-r		Resume menu
;;;		C-c C-w C-l		Local resume menu
;;;		C-c C-w C-s		Switch task
;;;		C-c C-w =		Show window list (Q)
(require 'windows "windows.elc" t)

;; -----------------------
;; * Remote File Editing *
;; I want to open a file remotely
(require 'tramp)
(setq tramp-default-method "scp")

;; -------------------------------------
;; * Rendu HTML de buffers et fichiers *
;; Just call `htmlize-view-buffer' to show the current buffer in
;; your web browser.
(require 'htmlize-view)
(setq htmlize-convert-nonascii-to-entities nil)
(setq htmlize-html-charset "utf-8")
(htmlize-view-add-to-files-menu)


;; -------------------------------------
;; * Incremental minibuffer completion *
(require 'icomplete)
(icomplete-mode 1)
(require 'icomplete+)
(setq icompletep-prospects-length 100)

;; ---------------------------------------
;; * Affichage des paires de parenthèses *
;; (GNU Emacs supports mic-paren only within a window-system but XEmacs
;; supports mic-paren also without X)
(when (or (string-match "XEmacs\\|Lucid" emacs-version) window-system)
  (require 'mic-paren) ;; loading
  (paren-activate)     ;; activating
  (show-paren-mode 1)
  ;; Defines in which situations the whole sexp should be highlighted
  ;; You may customize `paren-face-match' with M-xcustomize-face
  (setq paren-sexp-mode (quote match))
  ;; set here any of the customizable variables of mic-paren:
  ;; Disable mic-paren in minibuffer (useful with the package ido)
  (add-hook 'minibuffer-setup-hook
            '(lambda ()
               (paren-deactivate)))
  (add-hook 'minibuffer-exit-hook
            '(lambda ()
               (paren-activate))))

;; -------
;; * ido *
;; Pour changer de buffer ou ouvrir un fichier en donnant
;; une sous chaine (clavier C-Tab defini dans pi-global-keys.el; C-x b par defaut)
;; Utiliser C-s C-r pour faire défiler le menu.
;; Un paquet indispensable!
(when (require 'ido "ido.elc" t) ;;Part of emacs22
  ;; C-tab ou C-x b pour changer de buffer
  (global-set-key (kbd "<C-tab>") 'ido-switch-buffer)
  (setq ido-case-fold t ;; Insensible à la casse
        ;; File in which the ido state is saved between invocations.
        ido-save-directory-list-file (cuid ".ido.last"))
  (ido-mode t)
  (setq ido-ignore-files
        (append ido-ignore-files
                (list
                 ".*\\.aux$"
                 ".*\\.dvi$"
                 ".*\\.ps$"
                 ".*\\.eps$"
                 ".*\\.toc$"
                 ".*\\.nav$"
                 ".*\\.pdf$"
                 ".*\\.gif$"
                 ".*\\.png$"
                 ".*~$")))

  (setq ido-ignore-buffers
        (append ido-ignore-buffers
                (list
                 "\\*BBDB\\*"))))

;; -------------
;; * Undo/Redo *
;; C-/ pour undo C-: pour redo défini dans pi-keys.el
(require 'redo+)

;; ;; -------------------------------------
;; ;; * Touches de sélection à la Windows *
;; (require 'pc-select)
;; ;; (pc-bindings-mode)
;; (pc-selection-mode)

;; ----------------------------------------------
;; * Indentation automatique dans certains mode *
;; à  revoir en définissant une variable "liste de modes" et ajouter un hook sur les modes
(define-key emacs-lisp-mode-map (kbd "RET") 'newline-and-indent)
(define-key lisp-mode-map (kbd "RET") 'newline-and-indent)
(define-key lisp-interaction-mode-map (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-h a") 'apropos)

;;  Pasted lines are automatically indented, which is extremely time-saving.
;; http://www.emacswiki.org/emacs/AutoIndentation
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode
                        '(emacs-lisp-mode
                          lisp-mode
                          clojure-mode    scheme-mode
                          haskell-mode    ruby-mode
                          rspec-mode      python-mode
                          c-mode          c++-mode
                          objc-mode       latex-mode
                          plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))


;; ----------------------------
;; * Mettre en boite du texte *
;; Commande M-x boxquote-...
;; ,----
;; | Voici du texte en boite
;; `----
(require 'boxquote)

;; ---------------
;; * Les ciseaux *
;; Usage M-x separe <RET> donne
;; 8<------8<------8<------8<------8<------8<------8<------8<------
(autoload (quote separe) "scissors" "Insert a line of SCISSORS in the buffer" t nil)

;; Voir le nom de la fonction courante dans la ligne de mode
(which-func-mode 1)

;; http://demo.icu-project.org/icu-bin/ubrowse?scr=55
;; Symbols http://demo.icu-project.org/icu-bin/ubrowse?scr=55&b=0
;; ☑

;; http://www.fileformat.info/info/unicode/category/So/list.htm
(global-set-key (kbd "C-x 8") nil)
(global-set-key (kbd "C-x 8 1 / 3") "⅓")
(global-set-key (kbd "C-x 8 1 / 3") "⅓")
(global-set-key (kbd "C-x 8 1 / 5") "⅕")
(global-set-key (kbd "C-x 8 1 / 6") "⅙")
(global-set-key (kbd "C-x 8 2 / 3") "⅔")
(global-set-key (kbd "C-x 8 2 / 5") "⅖")
(global-set-key (kbd "C-x 8 3 / 5") "⅗")
(global-set-key (kbd "C-x 8 4 / 5") "⅘")
(global-set-key (kbd "C-x 8 5 / 6") "⅚")

(global-set-key (kbd "C-x 8 <") nil)
(global-set-key (kbd "C-x 8 . >") "→")
(global-set-key (kbd "C-x 8 . <") "←")
(global-set-key (kbd "C-x 8 > >") "↣")
(global-set-key (kbd "C-x 8 < <") "↢")
(global-set-key (kbd "C-x 8 < |") "↤")
(global-set-key (kbd "C-x 8 | >") "↦")
(global-set-key (kbd "C-x 8 < >") "↔")

(global-set-key (kbd "C-x 8 c") "♥")
(global-set-key (kbd "C-x 8 )") "☺")
(global-set-key (kbd "C-x 8 (") "☹")
(global-set-key (kbd "C-x 8 E") "★")
(global-set-key (kbd "C-x 8 e") "☆")

(global-set-key (kbd "C-x 8 z") "☤")
(global-set-key (kbd "C-x 8 v") "☣")
(global-set-key (kbd "C-x 8 r") "☢")
(global-set-key (kbd "C-x 8 !") "⚠")
(global-set-key (kbd "C-x 8 m") "☠")
(global-set-key (kbd "C-x 8 w") "☡")
(global-set-key (kbd "C-x 8 l") "⚡")
(global-set-key (kbd "C-x 8 RET") "⏎")

(global-set-key (kbd "C-x 8 f") "☭")
(global-set-key (kbd "C-x 8 p") "☮")
(global-set-key (kbd "C-x 8 y") "☯")
(global-set-key (kbd "C-x 8 u") "☝")
(global-set-key (kbd "C-x 8 s") "☘")
;; ℼ ⺎ ⺴
(global-set-key (kbd "C-x 8 b") "☕")
(global-set-key (kbd "C-x 8 k") "☑")

(global-set-key (kbd "C-x 8 T") "☎")
(global-set-key (kbd "C-x 8 t") "☏")
;; 𝜋


(defun next-user-buffer ()
  "Switch to the next user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (next-buffer) )))

(defun previous-user-buffer ()
  "Switch to the previous user buffer.
User buffers are those whose name does not start with *."
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (string-match "^*" (buffer-name)) (< i 50))
      (setq i (1+ i)) (previous-buffer) )))

(global-set-key (kbd "<mouse-9>") 'next-user-buffer)
(global-set-key (kbd "<mouse-8>") 'previous-user-buffer)

;; Local variables:
;; coding: utf-8
;; End:

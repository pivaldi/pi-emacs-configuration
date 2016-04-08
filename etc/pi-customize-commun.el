;; Copyright (c) 2016, Philippe Ivaldi <www.piprime.fr>
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Commentary:

;; THANKS:

;; BUGS:

;; INSTALLATION:

;; Code:

;; LIGNES AJOUTEES AUTOMATIQUEMENT PAR EMACS

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-math-list
   (quote
    ((79 "Omega" "nil" nil)
     (111 "omega" "nil" nil)
     (118 "varphi" "nil" nil))))
 '(TeX-outline-extra
   (quote
    (("begin{exercise}" 3)
     ("begin{claim}" 3)
     ("begin{enumerate}" 4))))
 '(TeX-view-style
   (quote
    (("^a5$" "xdvi -thorough %d -paper a5")
     ("^landscape$" "xdvi -thorough %d -paper a4r -s 4")
     ("." "xdvi -s 4 -thorough %d -paper a4"))))
 '(battery-mode-line-format " [Batt: %b%p%%]")
 '(bm-recenter t)
 '(bongo-enabled-backends (quote (mpg123 mplayer ogg123)))
 '(case-fold-search t)
 '(display-battery-mode nil)
 '(ecb-layout-window-sizes nil)
 '(erc-modules
   (quote
    (autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands notify readonly ring smiley sound stamp spelling track)))
 '(font-latex-fontify-sectioning 1.0)
 '(global-auto-revert-mode nil)
 '(gnus-alias-allow-forward-as-reply t)
 '(gnus-alias-overlay-identities nil)
 '(gnus-alias-unknown-identity-rule (quote continue))
 '(history-length 250)
 '(hl-line-face (quote highlight))
 '(icicle-Completions-display-min-input-chars 2)
 '(icicle-region-background "grey")
 '(icicle-reminder-prompt-flag 18)
 '(icicle-show-Completions-help-flag nil)
 '(imaxima-image-type (quote png))
 '(iswitchb-buffer-ignore (quote ("^ " "*BBDB*")))
 '(jabber-alert-info-message-hooks (quote (jabber-info-wave jabber-info-display)))
 '(jabber-alert-presence-hooks nil)
 '(jabber-default-status
   "L'informatique est l'alliance d’une science inexacte et d’une activité humaine faillible")
 '(jabber-info-message-alist
   (quote
    ((roster . "Roster display updated")
     (browse . "Browse request completed"))))
 '(jabber-muc-alert-self nil)
 '(jabber-muc-autojoin nil)
 '(jabber-post-connect-hooks
   (quote
    (jabber-send-current-presence jabber-muc-autojoin jabber-whitespace-ping-start jabber-keepalive-start jabber-vcard-avatars-find-current jabber-autoaway-start)))
 '(js2-basic-offset 2)
 '(js2-global-externs (list "define" "require" "dojo"))
 '(js2-strict-trailing-comma-warning t)
 '(magit-auto-revert-mode nil)
 '(mml-insert-mime-headers-always t)
 '(mouse-wheel-follow-mouse (quote t))
 '(mouse-wheel-mode t nil (mwheel))
 '(mumamo-chunk-coloring 1000)
 '(nxhtml-skip-welcome t)
 '(php-manual-path "/usr/share/doc/php-doc/html/")
 '(pi-auto-fill-mode-hook-alist (quote nil))
 '(pi-features-alist
   (quote
    ("pi-font" "pi-configuration" "pi-flymake" "pi-elisp" "pi-unwanted" "pi-time" "pi-browse-url" "pi-sql.el" "pi-keys" "pi-org" "pi-tex" "pi-abbrev&tempo" "pi-complete" "pi-php" "pi-html" "pi-ctpl" "pi-qt" "pi-python" "pi-cedet" "pi-ecb" "pi-jabber" "pi-muse" "pi-crypt" "pi-lacarte" "pi-ftp" "pi-yaml" "pi-sass" "pi-dired" "pi-bongo" "pi-bm" "pi-markdown" "pi-flyspell" "pi-scroll" "pi-template-conf" "pi-asy" "pi-bbdb" "pi-js" "pi-expand-region" "pi-snippets" "pi-browse-kill-ring")))
 '(pi-flyspell-mode-alist
   (quote
    (message-mode-hook org-mode-hook jabber-chat-mode-hook gfm-mode-hook markdown-mode-hook)))
 '(read-mail-command (quote gnus))
 '(save-place t nil (saveplace))
 '(semantic-decoration-styles
   (quote
    (("semantic-decoration-on-includes" . t)
     ("semantic-decoration-on-protected-members" . t)
     ("semantic-decoration-on-private-members" . t)
     ("semantic-tag-boundary"))))
 '(send-mail-function (quote sendmail-send-it))
 '(tls-checktrust (quote ask))
 '(user-address "MUST BE OVERWROTE")
 '(user-full-name "MUST BE OVERWROTE")
 '(user-mail-address "MUST BE OVERWROTE")
 '(user-obfuscated-mail "MUST BE OVERWROTE")
 '(user-phone "MUST BE OVERWROTE")
 '(user-site-url "<MUST BE OVERWROTE>")
 '(x-select-enable-clipboard t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bm-face ((((class color) (background dark)) (:background "#4F4040"))))
 '(bm-persistent-face ((((class color) (background dark)) (:background "#4F4040" :foreground "yellow"))))
 '(cursor ((t (:background "white"))))
 '(diredp-compressed-file-suffix ((t nil)))
 '(diredp-date-time ((t (:foreground "black"))))
 '(diredp-deletion ((t (:inherit dired-warning))))
 '(diredp-deletion-file-name ((t (:inherit dired-warning))))
 '(diredp-dir-heading ((t (:inherit dired-header))))
 '(diredp-dir-priv ((t (:underline t))))
 '(diredp-display-msg ((t nil)))
 '(diredp-exec-priv ((t (:foreground "black"))))
 '(diredp-executable-tag ((t (:foreground "black"))))
 '(diredp-file-name ((t nil)))
 '(diredp-file-suffix ((t nil)))
 '(diredp-flag-mark ((t (:inherit dired-mark))))
 '(diredp-flag-mark-line ((t (:inherit dired-marked))))
 '(diredp-ignored-file-name ((t (:inherit dired-ignored))))
 '(diredp-link-priv ((t (:inherit dired-symlink))))
 '(diredp-no-priv ((t (:foreground "LightGray"))))
 '(diredp-other-priv ((t (:foreground "PaleGoldenrod"))))
 '(diredp-rare-priv ((t (:foreground "SpringGreen" :underline "SpringGreen"))))
 '(diredp-read-priv ((t (:foreground "MediumAquamarine"))))
 '(diredp-symlink ((t (:inherit dired-symlink))))
 '(diredp-write-priv ((t (:inherit dired-perm-write))))
 '(ecb-default-highlight-face ((((class color) (background dark)) (:background "grey22"))))
 '(flymake-errline ((((class color) (background dark)) (:background "black"))))
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-1-face))))
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-2-face))))
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-3-face))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-4-face))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face))))
 '(font-latex-sectioning-5-face ((((class color) (background dark)) (:foreground "yellow"))))
 '(font-lock-warning-face ((((class color) (min-colors 88) (background dark)) (:foreground "yellow" :weight bold))))
 '(gnus-signature-face ((t (:foreground "gray" :slant italic))) t)
 '(highlight ((((class color) (background dark)) (:background "darkolivegreen"))))
 '(icicle-complete-input ((((background dark)) (:underline t))))
 '(icicle-current-candidate-highlight ((((background dark)) (:background "CadetBlue" :foreground "black"))))
 '(icicle-prompt-suffix ((((type x w32 mac graphic) (class color) (background dark)) (:foreground "white" :box (:line-width 2 :style pressed-button)))))
 '(icicle-special-candidate ((((background dark)) (:background "#DB17FFF4E581" :foreground "black"))))
 '(icicle-whitespace-highlight ((t (:background "Magenta" :foreground "black"))))
 '(imaxima-latex-error-face ((t (:foreground "yellow" :underline t))))
 '(jabber-activity-personal-face ((t (:foreground "violet" :weight bold))))
 '(jabber-chat-prompt-foreign ((t (:foreground "IndianRed" :weight bold))))
 '(jabber-chat-prompt-local ((t (:foreground "lightblue" :weight bold))))
 '(jabber-rare-time-face ((t (:foreground "green3" :underline t))))
 '(jabber-roster-user-away ((t (:foreground "grey" :slant italic :weight normal))))
 '(jabber-roster-user-online ((t (:foreground "white" :slant normal :weight bold))))
 '(jabber-title-large ((t (:inherit variable-pitch :weight bold :height 200 :width ultra-expanded))))
 '(jabber-title-medium ((t (:inherit variable-pitch :weight bold :height 175 :width expanded))))
 '(jabber-title-small ((t (:inherit variable-pitch :weight bold :height 150 :width semi-expanded))))
 '(js2-highlight-vars-face ((((class color) (background dark)) (:background "#203636"))))
 '(menu ((t (:background "DarkSlateGray" :foreground "grey" :underline nil :slant normal))))
 '(message-header-cc ((t (:background "black" :foreground "gold" :weight ultra-bold :height 1.0))))
 '(message-header-name ((((class color) (background dark)) (:background "black" :foreground "Green"))))
 '(message-header-other ((((class color) (background dark)) (:background "black" :foreground "#b00000"))))
 '(message-header-subject ((((class color) (background dark)) (:background "black" :foreground "white"))))
 '(message-header-xheader ((((class color) (background dark)) (:foreground "lightblue"))))
 '(message-separator ((((class color) (background dark)) (:background "red" :foreground "blue3"))))
 '(mumamo-background-chunk-submode ((((class color) (min-colors 88) (background dark)) nil)))
 '(org-level-2 ((t (:foreground "yellow2"))))
 '(paren-face-match ((((class color)) (:background "#2A4747"))))
 '(semantic-highlight-func-current-tag-face ((((class color) (background dark)) nil)))
 '(twit-title-face ((((background light)) (:box (:line-width 2 :color "PowderBlue" :style 0) :underline "DeepSkyBlue" :background "PowderBlue")) (((background dark)) (:box (:line-width 2 :color "grey" :style 0) :underline "LightBlue" :foreground "Black" :background "grey")) (t (:underline "white"))))
 '(twit-zebra-1-face ((((class color) (background light)) (:foreground "black" :background "gray89" :box (:line-width 2 :color "gray89" :style 0))) (((class color) (background dark)) (:foreground "Wheat" :background "DarkSlateGray" :box (:line-width 2 :color "DarkSlateGray" :style 0))) (t (:inverse nil))))
 '(twit-zebra-2-face ((((class color) (background light)) (:foreground "black" :background "AliceBlue" :box (:line-width 2 :color "AliceBlue" :style 0))) (((class color) (background dark)) (:foreground "Wheat" :background "grey4" :box (:line-width 2 :color "grey4" :style 0)))))
 '(whizzy-error-face ((((class color)) (:box (:line-width 2 :color "yellow" :style released-button)))))
 '(whizzy-slice-face ((((class color)) (:inverse-video t)))))

(provide 'pi-customize-commun)
;;; pi-customize-commun.el ends here

;; Local variables:
;; coding: utf-8
;; End:

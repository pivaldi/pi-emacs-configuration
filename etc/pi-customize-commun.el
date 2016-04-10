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
)

(provide 'pi-customize-commun)
;;; pi-customize-commun.el ends here

;; Local variables:
;; coding: utf-8
;; End:

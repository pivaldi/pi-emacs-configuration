;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; $Last Modified on 2016/07/01 14:45:26

;; This program is free software ; you can redistribute it and/or modify
;; it under the terms of the GNU Lesser General Public License as published by
;; the Free Software Foundation ; either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY ; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; Lesser General Public License for more details.

;; You should have received a copy of the GNU Lesser General Public License
;; along with this program ; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

(when (require 'jabber-autoloads nil t)
  (setq jabber-avatar-cache-directory (user-var-file ".jabber-avatars/"))

  (defalias '_jc 'jabber-connect-all)
  (defalias '_jd 'jabber-disconnect)

  (setq
   jabber-muc-participant-colors
   (quote
    (("jig" . "white1")
     ("tba" . "grey")
     ("nbo" . "yellow3")
     ("lsa" . "pink3")))
   jabber-libnotify-timeout 10000
   jabber-chat-fill-long-lines nil
   jabber-auto-reconnect t
   jabber-keepalive-interval 300
   jabber-libnotify-urgency "normal")

  (eval-after-load "jabber"
    (progn

      ;; (defadvice jabber-events-when-sending
      ;;   (around jabber-sound-when-sending (text id))
      ;;   "Play `jabber-alert-sending-wave' when sending message."
      ;;   (unless (equal jabber-alert-sending-wave "")
      ;;     (funcall jabber-play-sound-file jabber-alert-sending-wave))
      ;;   ad-do-it)
      ;; (ad-activate 'jabber-events-when-sending)
      ;; ;; (ad-deactivate 'jabber-events-when-sending)
      (add-hook 'jabber-roster-mode-hook
                '(lambda ()
                   (setq show-trailing-whitespace nil)
                   (setq show-leading-whitespace nil)))
      (add-hook 'jabber-chat-mode
                (lambda ()
                  ;; C-<ret> pour sauter une ligne
                  (define-key jabber-chat-mode-map (kbd "<C-return>") "\n")))
      ))

  ;; Source http://www.emacswiki.org/emacs/AlexSchroederConfigAlpinobombus
  ;; Extract password from ~/.netrc file and add it to the
  ;; jabber-account-list. We extract all the network-server entries from
  ;; jabber-account-list, find the corresponding lines in ~/.netrc, use
  ;; the account name mentioned in there to find the entry in the
  ;; jabber-account-list, and add the password there. This means that
  ;; the JID has to be equal to the login value and the network-server
  ;; has to be equal to the machine value.  This probably doesn't work
  ;; for multiple JIDs connecting to the same network server, yet.
  (when (and (require 'netrc nil t) (file-readable-p "~/.netrc"))
    (dolist (server (mapcar (lambda (elem)
                              (cdr (assq :network-server (cdr elem))))
                            jabber-account-list))
      ;; Here, data should be a list of matching entries, but I'm not
      ;; sure the netrc format allows that.
      (let* ((data (netrc-machine (netrc-parse "~/.netrc") server t))
             (username (netrc-get data "login"))
             (password (netrc-get data "password"))
             (account (assoc username jabber-account-list)))
        (unless (assq :password (cdr account))
          (setcdr account (cons (cons :password password)
                                (cdr account)))))))

  ;; needed to connect with a self-signed cert :(
  (setq starttls-extra-arguments '("--insecure"))
  (setq starttls-use-gnutls t)

  ;; <-- Come from http://emacswiki.org/emacs/JabberEl#toc11
  ;; (defvar libnotify-program "/usr/bin/notify-send")
  ;; (defun pi-notify-send (title message)
  ;;   (start-process "notify" " notify"
  ;;                  libnotify-program title message))

  ;; (defun pi-libnotify-jabber-notify (from buf text proposed-alert)
  ;;   "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
  ;;   (when (or jabber-message-alert-same-buffer
  ;;             (not (memq (selected-window) (get-buffer-window-list buf))))
  ;;     (if (jabber-muc-sender-p from)
  ;;         (pi-notify-send (format "(PM) %s"
  ;;                              (jabber-jid-displayname (jabber-jid-user from)))
  ;;                      (format "%s: %s" (jabber-jid-resource from) text)))
  ;;     (pi-notify-send (format "%s" (jabber-jid-displayname from))
  ;;                  text)))

  ;; (add-hook 'jabber-alert-message-hooks 'pi-libnotify-jabber-notify)

  ;; I prefer osd-cat
  (defvar jabber-xosd-display-time 5)

  (defvar jabber-xosd-display-message-font "-xos4-terminus-bold-r-normal-*-*-320-*-*-*-*-*-*")

  (defun jabber-xosd-display-message (message)
    "Displays MESSAGE through the xosd"
    (let ((process-connection-type nil))
      (start-process "jabber-xosd" nil "osd_cat"
                     "-p" "bottom" ;; POS can be top, middle, or bottom. The default is top.
                     "-i" "20" ;; Indent from the left of screen the text is displayed.
                     "-l" "10" ;; Lines to scroll the display over.
                     "-A" "right" ;; Align can be left, right or center. The default is left.
                     "-f" jabber-xosd-display-message-font
                     "-d" (number-to-string jabber-xosd-display-time) ;; number of seconds the text is displayed.
                     "-c" "blue")
      (process-send-string "jabber-xosd" (pi-wrap-string message 70))
      (process-send-eof "jabber-xosd")))

  (defun jabber-message-xosd (from buffer text propsed-alert)
    (jabber-xosd-display-message text))
  (defun jabber-muc-message-xosd (nick group buffer text propsed-alert)
    (jabber-xosd-display-message text))

  ;; (setq jabber-alert-message-hooks (list 'jabber-message-xosd 'jabber-message-wave))
  ;; (setq jabber-alert-muc-hooks
  ;;       (list 'jabber-muc-message-xosd 'jabber-muc-wave 'jabber-muc-echo))
  ;; -->

  ;; Come from https://www.emacswiki.org/emacs/jabber-libnotify.el
  (defvar jabber-libnotify-icon ""
    "*Icon to be used on the notification pop-up. Default is empty")

  (defvar jabber-libnotify-timeout "2500"
    "*Specifies the timeout of the pop up window in millisecond")

  (defvar jabber-libnotify-message-header "Jabber message"
    "*Defines the header of the pop up")

  (defun jabber-libnotify-message (msg)
    "Show MSG using libnotify"
    (let ((process-connection-type nil))
      (start-process "notification" nil "notify-send"
                     "-t" jabber-libnotify-timeout
                     "-i" jabber-libnotify-icon
                     jabber-libnotify-message-header msg)))


  (define-jabber-alert libnotify "Show a message through the libnotify interface"
    'jabber-libnotify-message)


  ;; Print autoaway status messages
  (setq jabber-autoaway-verbose t)

  )

;; -------
;; * ftp *
(eval-after-load 'ange-ftp
  '(progn
     (setq ange-ftp-dumb-unix-host-regexp "^ftp\\.tripod\\.com\\|ftp\\.geocities\\.com$"
           ange-ftp-try-passive-mode t) ;; Use passive mode

     (add-to-list 'ange-ftp-passive-host-alist '("ftp\\.tuxfamily\\.org|ftp\\.serviatys\\.fr|ftpperso\\.free\\.fr" . "on"))

     ;; Tweaked by eraatikidotfi based on code from
     ;; http://mail.gnu.org/pipermail/help-gnu-emacs/2001-April/006468.html:
     ;; From: Ehud Karni  ehudatunixdotsimonwieseldotcodotil
     ;; Date: Wed, 18 Apr 2001 19:45:08 +0300
     ;; Subject: Ange-ftp: passive mode transfers?
     (defvar ange-ftp-hosts-no-pasv '("localhost")
       "*List of hosts that do not need PASV (e.g. hosts within your firewall).
  Used by `ange-ftp-set-passive'.")	; rephrased, added "*" // era

     (defun ange-ftp-set-passive ()
       "Function to send a PASV command to hosts not named in the variable
  `ange-ft-hosts-no-pasv'. Intended to be called from the hook variable
  `ange-ftp-process-startup-hook'."	; rephrased significantly // era
       (if (not (member host ange-ftp-hosts-no-pasv))
           (ange-ftp-raw-send-cmd proc "passive")))

     ;; Plante avec Tuxfamily
     ;; (add-hook 'ange-ftp-process-startup-hook 'ange-ftp-set-passive)
     ))

;; turn off backup-directory-alist for tramp
;; (add-to-list 'backup-directory-alist
;;              (cons tramp-file-name-regexp nil))
(if (file-readable-p "~/back.emacs/tramp/")
    ;; set a dedicated auto-save directory
    (setq tramp-auto-save-directory "~/back.emacs/tramp/"))

;; Local variables:
;; coding: utf-8
;; End:

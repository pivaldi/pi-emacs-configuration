(when (require 'bbdb nil t)
  (bbdb-initialize 'gnus 'sendmail)

  ;; on définit où se trouve le fichier de bbdb
  (setq bbdb-file (cuid ".bbdb"))

  ;; (add-hook 'mail-mode-hook 'bbdb-insinuate-message)
  ;; (add-hook 'message-mode-hook 'bbdb-insinuate-message)
  ;; (add-hook 'mail-setup-hook 'bbdb-insinuate-sendmail)
  ;; allow cycling of email addresses
  (setq bbdb-complete-name-allow-cycling t)
  ;; (add-hook 'mail-setup-hook 'bbdb-define-all-aliases)
  ;; (bbdb-insinuate-message)
  ;; (add-hook 'message-setup-hook 'bbdb-define-all-aliases)

  (setq bbdb-use-pop-up nil
        bbdb-north-american-phone-numbers-p nil))

;; -------------------------------------
;; * Incremental minibuffer completion *
;; Icomplete mode provides an incremental MiniBuffer Completion
;; preview: As you type in the minibuffer, a list of matching commands
;; is echoed there so you can see how to complete a command.
(require 'icomplete)
(icomplete-mode 1)
(require 'icomplete+)
(setq icompletep-prospects-length 100)

;; -----------------
;; * Complète tout *

(when (require 'auto-complete "auto-complete.elc" t)
  (require 'auto-complete-config "auto-complete-config.elc" t)
  (ac-config-default)
  (global-auto-complete-mode t)
  ;; Configurations intéressantes:
  ;; Don't start completion automatically
  ;; (setq ac-auto-start nil)
  ;; (global-set-key "\M-/" 'ac-start)
  ;; start completion when entered 3 characters
  (setq ac-comphist-file (cuid "ac-comphist.dat")
        ac-candidate-limit 10 ;; Limit number of candidates. Non-integer means no limit.
        )

  ;; (define-key ac-completing-map "\C-m" nil)
  ;; (setq ac-use-menu-map t)
  ;; (define-key ac-menu-map "\C-m" 'ac-complete)

  (global-set-key (kbd "<f1>")
                  (lambda ()
                    (interactive)
                    (when (auto-complete-mode)
                      (when (featurep 'company)
                        (company-mode -1)
                        (message "auto-complete enabled, company disabled"))))))

(when (require 'company nil t)

  (autoload 'company-mode "company" nil t)
  (global-set-key (kbd "S-<f1>")
                  (lambda ()
                    (interactive)
                    (when (company-mode)
                      (when (featurep 'auto-complete)
                        (auto-complete-mode nil)
                        (message "company-mode enabled, auto-complete disabled"))))))

;; Local variables:
;; coding: utf-8
;; End:

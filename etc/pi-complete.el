;; -----------------
;; * Complète tout *

(when (require 'auto-complete "auto-complete.elc" t)
  (require 'auto-complete-config "auto-complete-config.elc" t)
  (ac-config-default)
  ;; (global-auto-complete-mode t)
  ;; Configurations intéressantes:
  ;; Don't start completion automatically
  ;; (setq ac-auto-start nil)
  ;; (global-set-key "\M-/" 'ac-start)
  ;; start completion when entered 3 characters
  (setq ac-comphist-file (cuid "ac-comphist.dat"))
  ;; Limit number of candidates. Non-integer means no limit.
  (setq ac-candidate-limit 10)

  (global-set-key (kbd "<f1>")
                  (lambda ()
                    (interactive)
                    (when (auto-complete-mode)
                      (when (featurep 'company)
                        (company-mode -1))))))

(when (locate-library (cuid "site-lisp/company/company.el"))
  (add-to-list 'load-path (cuid "site-lisp/company/"))
  (autoload 'company-mode "company" nil t)
  (global-set-key (kbd "S-<f1>")
                  (lambda ()
                    (interactive)
                    (when (company-mode)
                      (when (featurep 'auto-complete)
                        (auto-complete-mode nil))))))


;; Local variables:
;; coding: utf-8
;; End:

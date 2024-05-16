
(if (< emacs-major-version 23)
    (progn
      (require 'crypt++ "crypt++.elc" t)
      (setq crypt-encryption-type 'rc4
            ;; Mes fichiers cryptés ont pour extension ".gpg".
            ;; crypt-encryption-file-extension "\\(\\.gpg\\)$"
            crypt-encryption-file-extension nil
            crypt-bind-insert-file nil
            crypt-freeze-vs-fortran nil))
  (progn
    ;; Avec epa il faut générer une clef privée:
    ;; Voir http://emacs.wordpress.com/2008/07/18/keeping-your-secrets-secret/
    (when (require 'epa "epa.elc" t)
      (epa-file-enable)
      (setq epa-file-cache-passphrase-for-symmetric-encryption t)
      )))


(defun pi-hide-password ()
  "Use authinfo--hide-passwords to hide password in file"
  (interactive)
  (when (string-match-p ".*\.gpg~?" (file-name-nondirectory (buffer-file-name)))
    (authinfo--hide-passwords (point-min) (point-max))
    (reveal-mode))
)

(add-hook 'find-file-hook 'pi-hide-password)

;; Local variables:
;; coding: utf-8
;; End:

;; ---------------------------
;; * Chiffrement des buffers *
;; Les fichier dont l'extesion est pgp seront chiffrés.
;; Deux solutions crypt++ (dispo avec emacs22) ou epa (dispo avec Emacs23)
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

;; Local variables:
;; coding: utf-8
;; End:

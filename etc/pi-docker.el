(when (require 'dockerfile-mode nil t)
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(provide 'pi-docker)
;; Local variables:
;; coding: utf-8
;;; pi-docker ends here

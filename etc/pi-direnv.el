(when (and (executable-find "direnv") (require 'direnv nil t))
  (add-hook 'find-file-hook 'direnv-load-environment)
  ;; (add-hook 'buffer-list-update-hook 'direnv-load-environment)
  )

(provide 'pi-direnv)

(eval-when-compile
  (require 'cl))

(autoload 'markdown-mode "markdown-mode.elc"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\(\\.text$\\|\\.mkd$\\|\\.md$\\)" . markdown-mode))

(provide 'pi-markdonw)
;;; pi-markdonw.el ends here

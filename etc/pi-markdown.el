(eval-when-compile
  (require 'cl))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\(\\.text$\\|\\.mdk$\\|\\.md$\\)" . markdown-mode))

(provide 'pi-markdonw)
;;; pi-markdonw.el ends here

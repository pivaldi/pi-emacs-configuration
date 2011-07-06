(eval-when-compile
  (require 'cl))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.text" . markdown-mode) auto-mode-alist))

(provide 'pi-markdonw)
;;; pi-markdonw.el ends here

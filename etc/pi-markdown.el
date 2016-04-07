(eval-when-compile
  (require 'cl))

(autoload 'markdown-mode "markdown-mode.elc"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\(\\.text$\\|\\.mkd$\\|\\.md$\\)" . markdown-mode))
;; (eval-after-load 'markdown-mode
;;   '(progn
;;      (add-hook `gfm-mode-hook
;;                (lambda nil
;;                  (flyspell-mode 1)))))


(provide 'pi-markdonw)
;;; pi-markdown.el ends here

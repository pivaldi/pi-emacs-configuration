(eval-when-compile
  (require 'cl))

(autoload 'markdown-mode "markdown-mode.elc"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\(\\.text$\\|\\.mkd$\\|\\.md$\\)" . markdown-mode))

;; Comme from https://pages.sachachua.com/.emacs.d/Sacha.html
(when (require 'smartparens nil t)
  (sp-with-modes '(markdown-mode gfm-mode rst-mode)
  (sp-local-pair "*" "*" :bind "C-*")
  (sp-local-tag "2" "**" "**")
  (sp-local-tag "s" "```scheme" "```")
  (sp-local-tag "<"  "<_>" "</_>" :transform 'sp-match-sgml-tags)))

(provide 'pi-markdonw)
;;; pi-markdown.el ends here

;;; Package --- parenthesis configuration
;; Copyright (c) 2016, Philippe Ivaldi <www.piprime.fr>

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; THANKS:

;;; BUGS:

;;; INSTALLATION:

;;; Code:



(when (require 'smartparens nil t)
  (show-smartparens-global-mode t)
  (smartparens-global-mode 1)
  (add-hook 'prog-mode-hook 'turn-on-smartparens-mode)
  (add-hook 'markdown-mode-hook 'turn-on-smartparens-mode)
  (add-hook 'text-mode-hook 'turn-on-smartparens-mode)

  (defmacro def-pairs (pairs)
    "Come from https://ebzzry.github.io/emacs-pairs.html"
    `(progn
       ,@(loop for (key . val) in pairs
               collect
               `(defun ,(read (concat
                               "wrap-with-"
                               (prin1-to-string key)
                               "s"))
                    (&optional arg)
                  (interactive "p")
                  (sp-wrap-with-pair ,val)))))

  (def-pairs ((paren        . "(")
              (bracket      . "[")
              (brace        . "{")
              (single-quote . "'")
              (double-quote . "\"")
              (back-quote   . "`")))

  (define-key global-map (kbd "C-p") ctl-x-map)
  (global-set-key (kbd "C-p <left>") 'sp-beginning-of-sexp)
  (global-set-key (kbd "C-p <C-left>") 'sp-down-sexp)
  (global-set-key (kbd "C-p <right>") 'sp-end-of-sexp)
  (global-set-key (kbd "C-p <C-right>") 'sp-up-sexp)
  (global-set-key (kbd "C-p n") 'sp-previous-sexp)
  (global-set-key (kbd "C-p p") 'sp-next-sexp)

  (global-set-key (kbd "C-p (") 'wrap-with-parens)
  (global-set-key (kbd "C-p \"") 'wrap-with-double-quotes)
  (global-set-key (kbd "C-p '") 'wrap-with-simple-quotes)
  (global-set-key (kbd "C-p {") 'wrap-with-braces)
  (global-set-key (kbd "C-p [") 'wrap-with-brackets)
  (global-set-key (kbd "C-p <deletechar>") 'sp-unwrap-sexp)
  (global-set-key (kbd "C-p <backspace>") 'sp-backward-unwrap-sexp)
  (global-set-key (kbd "C-p <C-k>") 'sp-kill-sexp)
  ;; (global-set-key (kbd "C-p <C-k>") 'sp-kill-hybrid-sexp)
  ;; (global-set-key (kbd "C-p <S-backspace>") 'sp-backward-kill-sexp)
  )

(provide 'pi-paren)
;;; pi-paren.el ends here

;; Local variables:
;; coding: utf-8
;; End:

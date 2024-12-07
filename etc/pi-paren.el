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
  (smartparens-strict-mode -1)
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

  ;; (define-key global-map (kbd "C-p") ctl-x-map)
  ;; (global-set-key (kbd "C-p <left>") 'sp-beginning-of-sexp)
  ;; (global-set-key (kbd "C-p <C-left>") 'sp-down-sexp)
  ;; (global-set-key (kbd "C-p <right>") 'sp-end-of-sexp)
  ;; (global-set-key (kbd "C-p <C-right>") 'sp-up-sexp)
  ;; (global-set-key (kbd "C-p w") 'sp-rewrap-sexp)
  ;; (global-set-key (kbd "C-p <deletechar>") 'sp-unwrap-sexp)
  ;; (global-set-key (kbd "C-p <backspace>") 'sp-backward-unwrap-sexp)
  ;; (global-set-key (kbd "C-p <C-k>") 'sp-kill-sexp)

  (defun pi-sp-delete-word-or-unwrap-sexp ()
    "If there is a word at point, delete it.
If there is a paired char at point use sp-unwrap-sexp."
    (interactive)
    (if (or
         (sp--looking-at (sp--get-opening-regexp (sp--get-pair-list-context 'navigate)))
         (sp--looking-at (sp--get-closing-regexp (sp--get-pair-list-context 'navigate)))
         )
        (sp-unwrap-sexp)
      (let* ((oldpoint (point)) (start (point)) (end (point))
             (syntaxes "w")
             (not-syntaxes (concat "^" syntaxes)))
        (skip-syntax-backward syntaxes) (setq start (point))
        (goto-char oldpoint)
        (skip-syntax-forward syntaxes) (setq end (point))
        (if (bolp)
            (progn
              (skip-syntax-forward not-syntaxes
                                   (save-excursion (end-of-line)
                                                   (point)))
              (setq start (point))
              (skip-syntax-forward syntaxes)
              (setq end (point)))
          (setq end (point))
          (skip-syntax-backward syntaxes)
          (setq start (point)))
        (unless (= start end)
          (delete-region start end)))))

  (defun pi-sp-kill-sexp (arg)
    "Call 'beginning-of-sexp' then 'sp-kill-sexp'"
    (interactive "*P")
    (sp-beginning-of-sexp arg)
    (sp-kill-hybrid-sexp nil))

  ;; Read this article : https://ebzzry.com/en/emacs-pairs/
  (bind-keys
   :map smartparens-mode-map
   ("C-M-a" . sp-beginning-of-sexp)
   ("C-M-e" . sp-end-of-sexp)

   ;; ("C-<down>" . sp-down-sexp)
   ;; ("C-<up>"   . sp-up-sexp)
   ;; ("M-<down>" . sp-backward-down-sexp)
   ;; ("M-<up>"   . sp-backward-up-sexp)

   ("C-M-f" . sp-forward-sexp)
   ("C-M-b" . sp-backward-sexp)

   ("C-M-n" . sp-next-sexp)
   ("C-M-p" . sp-previous-sexp)

   ("C-S-f" . sp-forward-symbol)
   ("C-S-b" . sp-backward-symbol)

   ;; ("C-M-t" . sp-transpose-sexp)
   ("C-M-k" . sp-kill-sexp)
   ("C-k"   . sp-kill-hybrid-sexp)
   ("M-k"   . sp-backward-kill-sexp)
   ("C-M-w" . pi-sp-kill-sexp)
   ("C-M-d" . delete-sexp)
   ("C-M-r" . sp-rewrap-sexp)

   ("C-<delete>" . pi-sp-delete-word-or-unwrap-sexp)
   ("M-<delete>" . sp-unwrap-sexp)
   ("M-<backspace>" . sp-backward-unwrap-sexp)
   ("C-<backspace>" . sp-backward-delete-word)
   ([remap sp-backward-delete-word] . backward-delete-word)
   ([remap sp-backward-kill-word] . backward-kill-word)

   ;; ("C-x C-t" . sp-transpose-hybrid-sexp)

   ("C-c ("  . wrap-with-parens)
   ("C-c ["  . wrap-with-brackets)
   ("C-c {"  . wrap-with-braces)
   ("C-c '"  . wrap-with-single-quotes)
   ("C-c \"" . wrap-with-double-quotes)
   ("C-c _"  . wrap-with-underscores)
   ("C-c `"  . wrap-with-back-quotes)))

(provide'pi-paren)
;;; pi-paren.el ends here

;; Local variables:
;; coding: utf-8
;; End:

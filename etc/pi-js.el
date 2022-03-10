;;; package --- javascript emacs config
;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>

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
;;; Code:

(when (require 'js2-mode nil t)
  (when (require 'ac-js2 nil t)
    (add-hook 'js2-mode-hook 'ac-js2-setup-auto-complete-mode))

  (if (< emacs-major-version 24)
      (autoload 'js2-mode "js2" nil t)
    (autoload 'js2-mode "js2-mode" nil t))

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (eval-after-load 'js2-mode
    '(progn
       (setq js2-bounce-indent-p t
             js2-basic-offset 2
             js2-auto-indent-flag t
             js2-bounce-indent-flag nil
             js2-indent-on-enter-key t
             js2-enter-indents-newline t
             js2-mode-escape-quotes nil)

       (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
       (add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))))

  (defun pi-js2-mode-hook ()
    ;; Let flycheck handle parse errors
    (setq-default js2-show-parse-errors nil)
    (flycheck-mode 1)
    (setq comment-end "")

    ;; Fix Issue 107 http://code.google.com/p/js2-mode/issues/detail?id=107
    (set (make-local-variable 'forward-sexp-function) nil)

    (when (featurep 'col-highlight)
      (column-highlight 100))

    (c-toggle-auto-state 0)

    (define-key js2-mode-map [(meta control \;)]
      '(lambda()
         (interactive)
         (insert "/* -----[ ")
         (save-excursion
           (insert " ]----- */"))
         ))
    (define-key js2-mode-map [(return)] 'newline-and-indent)
    (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
    (when pi-use-skeleton-pair-insert-maybe
      (define-key js2-mode-map "\{" 'skeleton-pair-insert-maybe)
      (define-key js2-mode-map "\(" 'skeleton-pair-insert-maybe)
      (define-key js2-mode-map "[" 'skeleton-pair-insert-maybe)
      (define-key js2-mode-map "\"" 'skeleton-pair-insert-maybe)
      (define-key js2-mode-map "'" 'skeleton-pair-insert-maybe))

    (defvar pi-js-compile-command "/usr/bin/nodejs")

    (define-key js2-mode-map (kbd "C-c C-c")
      (lambda nil
        (interactive)
        (compile (concat
                  pi-js-compile-command
                  " " (buffer-file-name)))))

    (defvar pi-node-compile-command "/usr/bin/nodejs")

    (define-key js2-mode-map (kbd "<C-return>")
      (lambda nil
        (interactive)
        (when (buffer-modified-p) (save-buffer))
        (shell-command (concat
                        pi-node-compile-command
                        " -e \"$(cat "
                        (buffer-file-name)
                        ")\" &"))))

    (define-key js2-mode-map (kbd "<f1>")
      (lambda nil
        (interactive)
        (occur "\\(\\([$a-zA-Z_][0-9A-Z_$]*\\) *[:=] *function *\(\\)\\|= *\\(function \\([$a-zA-Z_][0-9A-Z_$]*\\) *\(\\)")
        ))

    )

  (add-hook 'js2-mode-hook 'pi-js2-mode-hook)
  ;; --]

  (if (not (executable-find "prettier"))
      (add-to-list 'pi-error-msgs "Please install prettier : npm -g install prettier"))
  )

(provide 'pi-js)
;;; pi-js ends here

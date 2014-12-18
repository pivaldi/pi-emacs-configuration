;; Copyright (c) 2013, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-go.el,v 0.0 2013/12/30 22:21:05 Exp $

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

;; Commentary:

;; THANKS:

;; BUGS:

;; INSTALLATION:

;; Code:



(eval-when-compile
  (require 'cl))

(add-to-list 'load-path (cuid "site-lisp/go-mode"))
(when (locate-library "go-mode")
  (require 'go-mode-autoloads)
  (require 'go-errcheck)

  (add-hook 'go-mode-hook
            (lambda nil
              (set (make-local-variable 'process-environment) (pi-get-ovya-env))
              ))

  (add-hook 'go-mode-hook
            (lambda nil
              (setq tab-width 2)))

  (add-hook 'before-save-hook 'gofmt-before-save)

  (add-hook 'go-mode-hook
            (lambda ()
              (setq tab-width 2)
              (make-local-variable 'skeleton-pair-alist)
              (setq skeleton-pair-alist '((?` _ ?`)))
              (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
              (local-set-key (kbd "C-c i") 'go-goto-imports)
              (local-set-key (kbd "M-.") 'godef-jump)
              (local-set-key (kbd "C-c C-c") 'goRun)
              ))


  (when (and (locate-library "go-autocomplete")
             (locate-library "auto-complete-config"))
    (require 'go-autocomplete)
    (require 'auto-complete-config))

  (defun goRun ()
    "Run current buffer file name"
    (interactive)
    (compile (concat "go run " (buffer-file-name))))

  (eval-after-load 'go-mode
    '(progn
       (when pi-use-skeleton-pair-insert-maybe
         (define-key go-mode-map "\{" 'skeleton-pair-insert-maybe)
         (define-key go-mode-map "\(" 'skeleton-pair-insert-maybe)
         (define-key go-mode-map "[" 'skeleton-pair-insert-maybe)
         (define-key go-mode-map "\"" 'skeleton-pair-insert-maybe)
         (define-key go-mode-map "`" 'skeleton-pair-insert-maybe)
         (define-key go-mode-map "'" 'skeleton-pair-insert-maybe))

       (define-key go-mode-map [(control d)] 'c-electric-delete-forward)
       (define-key go-mode-map [(control meta q)] 'indent-sexp)))

  (eval-after-load 'go-mode
    '(progn
       (when pi-use-skeleton-pair-insert-maybe
         (define-key go-mode-map "\{" 'skeleton-pair-insert-maybe)
         (define-key go-mode-map "\(" 'skeleton-pair-insert-maybe)
         (define-key go-mode-map "[" 'skeleton-pair-insert-maybe)
         (define-key go-mode-map "\"" 'skeleton-pair-insert-maybe)
         (define-key go-mode-map "'" 'skeleton-pair-insert-maybe))

       (define-key go-mode-map [(control d)] 'c-electric-delete-forward)
       (define-key go-mode-map [(control meta q)] 'indent-sexp)))

  (defun go-fix-buffer ()
    "Tun gofix on current buffer"
    (interactive)
    (show-all)
    (shell-command-on-region (point-min) (point-max) "go tool fix -diff"))

  ;; https://github.com/syohex/emacs-go-eldoc
  (add-to-list 'load-path (cuid "site-lisp/go-eldoc"))
  (require 'go-eldoc)
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  )

(provide 'pi-go)
;;; pi-go.el ends here

;; Local variables:
;; coding: utf-8
;; End:

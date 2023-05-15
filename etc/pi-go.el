;;; package --- Go-mode config file
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

;;; Commentary:

;; THANKS:

;; BUGS:

;; INSTALLATION:

;; Code:



(eval-when-compile
  (require 'cl))

(when (and (executable-find "go") (locate-library "go-mode-autoloads"))
  (load "go-mode-autoloads")
  (add-hook 'go-mode-hook
            (lambda nil
              ;; (set (make-local-variable 'process-environment) (pi-get-ovya-env))
              (setq tab-width 2)
              ))

  (if (executable-find "goimports")
      (setq gofmt-command "goimports")
    (add-to-list 'pi-error-msgs "Please install goimports : https://godoc.org/golang.org/x/tools/cmd/goimports"))

  (if (not (executable-find "godef"))
      (add-to-list 'pi-error-msgs "Please install godef : go install github.com/rogpeppe/godef@latest"))

  (if (not (executable-find "gocode"))
      (add-to-list 'pi-error-msgs "Please install gocode : go install github.com/nsf/gocode@latest"))

  (add-hook 'before-save-hook 'gofmt-before-save)

  (add-hook 'go-mode-hook
            (lambda ()
              (setq tab-width 2)
              (make-local-variable 'skeleton-pair-alist)
              (setq skeleton-pair-alist '((?` _ ?`)))
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
       (define-key go-mode-map [(control d)] 'c-electric-delete-forward)
       (define-key go-mode-map [(control meta q)] 'indent-sexp)
       (define-key go-mode-map (kbd "C-c C-r") 'go-remove-unused-imports)
       (define-key go-mode-map (kbd "C-c i") 'go-goto-imports)
       (define-key go-mode-map (kbd "M-.") 'godef-jump)
       (define-key go-mode-map (kbd "<M-left>") 'pop-tag-mark)
       (define-key go-mode-map (kbd "C-c C-c") 'goRun)
       ))

  (defun go-fix-buffer ()
    "Turn gofix on current buffer"
    (interactive)
    (show-all)
    (shell-command-on-region (point-min) (point-max) "go tool fix -diff"))

  (when (require 'flycheck-golangci-lint nil t)
    (if  (executable-find "golangci-lint")
        (progn
          (setenv "GO111MODULE" "on")
          (eval-after-load 'flycheck
            '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

          )
      (add-to-list 'pi-error-msgs
                   "Please install golangci-lint <https://github.com/golangci/golangci-lint>")))

  (when (require 'go-eldoc nil t)
    (add-hook 'go-mode-hook 'go-eldoc-setup))
  )

(when (require 'lsp-mode nil t)
(add-hook 'go-mode-hook #'lsp))

(provide 'pi-go)
;;; pi-go.el ends here

;; Local variables:
;; coding: utf-8
;; End:

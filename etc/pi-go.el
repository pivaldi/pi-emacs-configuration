;; Copyright (c) 2013, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-go.el,v 0.0 2013/12/30 22:21:05 Exp $
;; $Last Modified on 2014/01/01 16:34:19

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

;; /home/pi/Documents/go/src/camlistore.org/make.go
;; max-specpdl-size
;; max-lisp-eval-depth
;; Error in post-command-hook: (error Lisp nesting exceeds `max-lisp-eval-depth') [9 times]
;; cl-safe-expr-p: Lisp nesting exceeds `max-lisp-eval-depth' [4 times]
;; Error in post-command-hook: (error Lisp nesting exceeds `max-lisp-eval-depth')
;; Quit
;; Mark set [2 times]
;; Region saved
;; Error in post-command-hook: (error Lisp nesting exceeds `max-lisp-eval-depth')
;; cl-safe-expr-p: Lisp nesting exceeds `max-lisp-eval-depth'
;; Error in post-command-hook: (error Lisp nesting exceeds `max-lisp-eval-depth')
;; cl-safe-expr-p: Lisp nesting exceeds `max-lisp-eval-depth'
;; Error in post-command-hook: (error Lisp nesting exceeds `max-lisp-eval-depth')
;; mic-paren-command-hook
;; (remove-hook 'post-command-hook 'mic-paren-command-hook)
(when (locate-library "go-mode")
  (require 'go-mode-load)
  (require 'go-errcheck)

  (add-hook 'before-save-hook 'gofmt-before-save)

  (add-hook 'go-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

  (add-hook 'go-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c i") 'go-goto-imports)))

  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "M-.") 'godef-jump)))

  (when (and (locate-library "go-autocomplete")
             (locate-library "auto-complete-config"))
    (require 'go-autocomplete)
    (require 'auto-complete-config)
    )

  (defun goRun ()
    "Run current buffer file name"
    (interactive)
    (compile (concat "go run " (buffer-file-name))))

  (add-hook 'go-mode-hook (lambda ()
                            (local-set-key (kbd "C-c C-c") 'goRun)))

  (defun go-fix-buffer ()
    "Tun gofix on current buffer"
    (interactive)
    (show-all)
    (shell-command-on-region (point-min) (point-max) "go tool fix -diff"))
  )

(provide 'pi-go)
;;; pi-go.el ends here

;; Local variables:
;; coding: utf-8
;; End:


;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-expand-region.el,v 0.0 2012/09/16 22:29:12 Exp $
;; $Last Modified on 2016/03/31 16:29:12

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

(when (and
       (require 'js2-mode nil t) )
  (require 'ac-js2 nil t)
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
    ;; (if (featurep 'js2-highlight-vars)
    ;;     (eval-after-load "js2-highlight-vars-autoloads"
    ;;       (js2-highlight-vars-mode)))

    (when (featurep 'ac-js2)
      (ac-js2-mode))

    (setq comment-end "")

    ;; Fix Issue 107 http://code.google.com/p/js2-mode/issues/detail?id=107
    (set (make-local-variable 'forward-sexp-function) nil)

    (when (featurep 'col-highlight)
      (column-highlight 95))

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

    (let ((keysm (kbd "C-;"))
          (keyco (kbd "C-,")))
      (local-set-key keysm 'pi-insert-semicol-at-end-of-line)
      (if (boundp 'flyspell-mode-map)
          (define-key flyspell-mode-map
            keysm 'pi-insert-semicol-at-end-of-line))
      (local-set-key keyco 'pi-insert-comma-at-end-of-line)
      (if (boundp 'flyspell-mode-map)
          (define-key flyspell-mode-map
            keyco 'pi-insert-comma-at-end-of-line)))


    (defvar pi-js-compile-command "/usr/bin/smjs")

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

    )

  (add-hook 'js2-mode-hook 'pi-js2-mode-hook)
  ;; --]

  (if (not (executable-find "js-beautify"))
      (add-to-list 'pi-error-msgs "Please install js-beautify : npm -g install js-beautify"))

  )

(provide 'pi-js)
;;; pi-js ends here

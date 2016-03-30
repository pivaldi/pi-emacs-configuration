;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-expand-region.el,v 0.0 2012/09/16 22:29:12 Exp $
;; $Last Modified on 2016/03/30 11:16:41

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
       (require 'espresso nil t) (require 'js2-mode nil t) (require 'js2-highlight-vars nil t))
  (autoload 'espresso-mode "espresso")
  (require 'ac-js2 nil t)
  (if (< emacs-major-version 24)
      (autoload 'js2-mode "js2" nil t)
      (autoload 'js2-mode "js2-mode" nil t))

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

  (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
  (eval-after-load 'js2-mode
    '(progn
       (setq js2-bounce-indent-p t)
       (setq js2-basic-offset 2)
       (defvar pi-js-indent-offset js2-basic-offset "")
       (setq espresso-indent-level pi-js-indent-offset)

       (setq js2-auto-indent-flag t
             js2-bounce-indent-flag nil
             js2-indent-on-enter-key t
             js2-enter-indents-newline t
             js2-mode-escape-quotes nil
             )
       (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
       (add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))))

  ;; [-- Come from http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode
  (defun pi-js2-indent-function ()
    (interactive)
    (save-restriction
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (save-excursion (syntax-ppss (point-at-bol))))
             (offset (- (current-column) (current-indentation)))
             (indentation (espresso--proper-indentation parse-status))
             node)

        (save-excursion

          ;; I like to indent case and labels to half of the tab width
          (back-to-indentation)
          (if (looking-at "case\\s-")
              (setq indentation (+ indentation (/ espresso-indent-level 2))))

          ;; consecutive declarations in a var statement are nice if
          ;; properly aligned, i.e:
          ;;
          ;; var foo = "bar",
          ;;     bar = "foo";
          (setq node (js2-node-at-point))
          (when (and node
                     (= js2-NAME (js2-node-type node))
                     (= js2-VAR (js2-node-type (js2-node-parent node))))
            (setq indentation (+ pi-js-indent-offset indentation))))

        (indent-line-to indentation)
        (when (> offset 0) (forward-char offset)))))

  (defun pi-indent-sexp ()
    (interactive)
    (save-restriction
      (save-excursion
        (widen)
        (let* ((inhibit-point-motion-hooks t)
               (parse-status (syntax-ppss (point)))
               (beg (nth 1 parse-status))
               (end-marker (make-marker))
               (end (progn (goto-char beg) (forward-list) (point)))
               (ovl (make-overlay beg end)))
          (set-marker end-marker end)
          (overlay-put ovl 'face 'highlight)
          (goto-char beg)
          (while (< (point) (marker-position end-marker))
            ;; don't reindent blank lines so we don't set the "buffer
            ;; modified" property for nothing
            (beginning-of-line)
            (unless (looking-at "\\s-*$")
              (indent-according-to-mode))
            (forward-line))
          (run-with-timer 0.5 nil '(lambda(ovl)
                                     (delete-overlay ovl)) ovl)))))

  (defun pi-js2-mode-hook ()
    (if (featurep 'js2-highlight-vars)
        ;; (js2-highlight-vars-mode)
        (eval-after-load "js2-highlight-vars-autoloads"
          (js2-highlight-vars-mode))
      )

    (when (featurep 'ac-js2)
      (ac-js2-mode))

    ;; (setq comment-start "// ")
    (setq comment-end "")
    ;; Fix Issue 107 http://code.google.com/p/js2-mode/issues/detail?id=107
    (set (make-local-variable 'forward-sexp-function) nil)
    (when (featurep 'col-highlight)
      (column-highlight 95))

    (setq js2-basic-offset pi-js-indent-offset)
    (c-toggle-auto-state 0)

    (if pi-js2-fix-indent
        (progn
          (set (make-local-variable 'indent-line-function) 'pi-js2-indent-function)))

    (define-key js2-mode-map [(meta control \;)]
      '(lambda()
         (interactive)
         (insert "/* -----[ ")
         (save-excursion
           (insert " ]----- */"))
         ))
    (define-key js2-mode-map [(return)] 'newline-and-indent)
    (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
    (define-key js2-mode-map [(control meta q)] 'pi-indent-sexp)
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

    (if (featurep 'js2-highlight-vars)
        (js2-highlight-vars-mode))
    (message "js2 hook applied"))

  (add-hook 'js2-mode-hook 'pi-js2-mode-hook)
  ;; --]

  (if (not (executable-find "js-beautify"))
      (add-to-list 'pi-error-msgs "Please install js-beautify : npm -g install js-beautify"))

  (when pi-flymake-jshint-auto-load
    (if (not (or (executable-find "jslint") (executable-find "jshint")))
        (add-to-list 'pi-error-msgs "Please install jshint or jslint : https://github.com/douglascrockford/JSLint"))

    (add-to-list 'load-path (cuid "site-lisp/jshint-mode"))
    (require 'flymake-jshint)
    (add-hook 'javascript-mode-hook
              (lambda () (flymake-mode t)))
    (add-hook 'js2-mode-hook
              (lambda () (flymake-mode t))))
)

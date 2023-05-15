;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>

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

(when (require 'python-mode nil t)
  (require 'python nil t)
  (when (executable-find "ipython")
    (require 'ipython nil t))

  (autoload 'python-mode "python-mode" "Python editing mode." t)

  ;; (when (require 'anaconda-mode nil t)
  ;;   (add-hook 'python-mode-hook
  ;;             (lambda nil
  ;;               (anaconda-mode)
  ;;               (ac-anaconda-setup)
  ;;               (anaconda-eldoc-mode)))

  ;;   )

  (when (require 'jedi nil t)
    (add-hook 'python-mode-hook 'jedi:setup)
    (setq jedi:complete-on-dot t)
    (setq jedi:use-shortcuts t)
    (eval-after-load 'jedi
      '(progn
         (define-key jedi-mode-map (kbd "C-c .") nil)
         (define-key jedi-mode-map (kbd "C-c ,") nil)
         (define-key jedi-mode-map (kbd "<C-tab>") nil)
         ))
    ;; (define-key python-mode-map (kbd "<C-tab>") 'ido-switch-buffer)
    (define-key python-mode-map (kbd "C-M-i") 'jedi:complete)

    )

  (setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
  (setq interpreter-mode-alist (cons '("python" . python-mode)
                                     interpreter-mode-alist))

  (setq py-python-command-args '("-pylab"  "-colors" "DarkBG"))
  (define-key python-mode-map (kbd "<C-return>") '
    (lambda ()
      (interactive)
      (end-of-line)
      (insert "\\")
      (py-newline-and-indent)
      )
    )

  (when pi-use-skeleton-pair-insert-maybe
    (define-key python-mode-map "\{" 'skeleton-pair-insert-maybe)
    (define-key python-mode-map "\(" 'skeleton-pair-insert-maybe)
    (define-key python-mode-map "[" 'skeleton-pair-insert-maybe)
    (define-key python-mode-map "\"" 'skeleton-pair-insert-maybe)
    (define-key python-mode-map "'" 'skeleton-pair-insert-maybe)
    (define-key python-mode-map "\{" 'skeleton-pair-insert-maybe))

  (define-key python-mode-map (kbd "C-c <down>") 'py-down)
  (define-key python-mode-map (kbd "C-c <up>") 'py-up)

  (define-key python-mode-map (kbd "<C-M-up>") 'scroll-move-up)
  (define-key python-mode-map (kbd "<C-M-down>") 'scroll-move-down)

  ;; (global-set-key (kbd "<C-M-up>") 'py-end-of-block-or-clause)
  ;; Because I don't like the default compilation process of python-mode.el
  ;; (one compile = one new tmp file AND buffer)
  (define-key python-mode-map (kbd "C-c C-c")
    (lambda nil
      (interactive)
      (compile (format "python %s" (buffer-file-name)))))

  ;;; Got this error ""Symbol's function definition is void: rope-after-save-actions""
  ;; (when
  ;;     (and
  ;;      (require 'auto-complete-config "auto-complete-config.elc" t)
  ;;      (ac-ropemacs-initialize)
  ;;      )

  ;;   (defvar disable-python-trace nil)
  ;;   (defadvice message(around message-disable-python-trace activate)
  ;;     (if disable-python-trace
  ;;         t
  ;;       ad-do-it)))
  )

;;; pi-python.el ends here

;; Local variables:
;; coding: utf-8
;; End:

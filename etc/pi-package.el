;; Copyright (c) 2016, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-package.el,v 0.0 2016/03/23 15:51:19 Exp $

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

(setq package-user-dir (cuid "site-lisp/melpa"))
(require 'package)
(setq package-enable-at-startup nil)

(dolist (p '(("melpa" . "https://melpa.org/packages/")
             ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
             ;; ("marmalade"   . "https://marmalade-repo.org/packages/")
             ;; ("org"         . "http://orgmode.org/elpa/")
             ))
  (add-to-list 'package-archives p))
(package-initialize)

(defvar pi-packages-list
  '(
    ;; smart-tab
    ;; flx-ido ;; support is included
    ;; ido-vertical-mode
    smex
    ido-completing-read+
    ggtags
    bm
    zenburn-theme
    smart-mode-line
    solarized-theme
    color-theme-sanityinc-tomorrow
    darcula-theme
    mic-paren
    bbdb
    w3m
    ecb
    magit
    ;; An Intelligent auto-completion extension for Emacs
    auto-complete
    company
    projectile
    yaml-mode
    ;; php-mode
    ac-php
    ;; company
    jedi ;; Python auto-completion for Emacs
    yasnippet
    js2-mode
    ;; js2-highlight-vars  ;; break tooltip and buffer message
    ;; ac-js2
    flycheck
    flycheck-status-emoji
    ;; expand-region
    ;; helm
    ;; helm-ag ;; https://github.com/syohex/emacs-helm-ag
    ;; helm-projectile
    ;; helm-swoop ;; https://github.com/ShingoFukuyama/helm-swoop
    sass-mode
    browse-kill-ring
    ;; Go -(
    go-mode
    go-snippets
    go-errcheck
    go-eldoc
    go-autocomplete
    flycheck-gometalinter
    golint
    ;; -)
    web-mode
    ;; web-beautify
    prettier-js
    tide ;; Extended Typescript mode
    ;; Angular 2 & 4 Support for Emacs
    ng2-mode
    bongo
    python-mode
    geben
    markdown-mode
    ;; haskell-mode
    ;; sql-indent ;; Does not work properly…
    move-text
    smartparens
    json-reformat
    textile-mode
    neotree
    ;; volatile-highlights
    direnv
    emojify
    rainbow-mode
    which-key
    origami
    editorconfig
    ;; Minor mode providing support for Zen Coding by producing HTML from CSS-like selectors
    ;; https://github.com/smihica/emmet-mode
    ;; Place point in a emmet snippet and press C-j to expand it (or
    ;; alternatively, alias your preferred keystroke to M-x
    ;; emmet-expand-line) and you'll transform your snippet into the
    ;; appropriate tag structure.
    emmet-mode
    ))

(defvar pi-package-refresh-done nil)

(defun pi-package-maybe-install(pkg)
  "Check and potentially install `PKG'."
  (if (not (package-installed-p pkg))
      (if (not (require pkg nil t))
          (progn
            (when (not pi-package-refresh-done)
              (package-refresh-contents)
              (setq pi-package-refresh-done t)
              )
            (package-install pkg))
        (message "%s is already installed OUT OF the Emacs package manager" pkg)
        )
    (message "%s is already installed by the Emacs package manager but not checked for update..." pkg)
    ))

(defun pi-packages-maybe-install()
  "Refresh package manifest to the defined set."
  (interactive)
  (mapc 'pi-package-maybe-install pi-packages-list))

(defun pi-packages-unaccounted ()
  "Like `package-list-packages', but shows only the packages that
  are installed and are not in `pi-packages-list'.  Useful for
  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x pi-packages-list))
                                   (not (package-built-in-p x))
                                   (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))

(pi-packages-maybe-install)

(provide 'pi-package)
;;; pi-package.el ends here

;; Local variables:
;; coding: utf-8
;; End:

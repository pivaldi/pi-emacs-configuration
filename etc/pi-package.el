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

;;; Code:


(eval-when-compile
  (require 'cl))

(require 'package)
(setq package-enable-at-startup nil)

;; See https://www.reddit.com/r/emacs/comments/cdei4p/failed_to_download_gnu_archive_bad_request/
;; Remove this line for Emacs 26.3+
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(dolist (p '(
             ("melpa" . "https://melpa.org/packages/")
             ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
             ;; ("marmalade"   . "https://marmalade-repo.org/packages/")
             ("org"         . "https://orgmode.org/elpa/")
             ))
  (add-to-list 'package-archives p) t)

(defcustom pi-enabled-packages '(
                                 (expand-region
                                  "pi-expand-region.el"
                                  "Increase/Decrease Selected Region by Semantic Units.
C-+ : Expand region increases the selected region by semantic units.
C-= : Contract region decreases the selected region by semantic units.
Just keep pressing the keys until it selects what you want.
See https://github.com/magnars/expand-region.el
")
                                 (easy-kill
                                  "pi-easy-kill.el"
                                  "Kill & Mark Things Easily in Emacs.
M-w XXX   : Save XXX at point.
C-M-@ XXX : Mark XXX at point.
C-à XXX   : Like C-M-@ XXX (best for french keyboard).
More info here https://github.com/leoliu/easy-kill
")
                                )
  "List of package/config.
Each element is a cons cell (Package . \"Filename Config\").
The filename configuration is relative to the directory etc
of the Emacs root config directory."
:type '(alist :key-type (symbol :tag "Package")
              :value-type (list (string :tag "File Name Config")
                                (string :tag "Description")))
:group 'pi-emacs)

(defvar pi-packages-list
  '(
    ;; smart-tab
    ;; flx-ido ;; support is included
    ;; ido-vertical-mode
    use-package
    async
    smex
    org
    ido-completing-read+
    bm
    zenburn-theme
    smart-mode-line
    solarized-theme
    color-theme-sanityinc-tomorrow
    darcula-theme
    mic-paren
    bbdb
    w3m
;;    ecb
    magit
    noflet
    nginx-mode
    ;; An Intelligent auto-completion extension for Emacs
    projectile
    flycheck-projectile
    go-projectile
    ibuffer-projectile
    yaml-mode
    php-mode
    company
    company-php
    jedi ;; Python auto-completion for Emacs
    yasnippet
    js2-mode
    ;; js2-highlight-vars  ;; break tooltip and buffer message
    flycheck
    flycheck-status-emoji
    ;; helm
    ;; helm-ag ;; https://github.com/syohex/emacs-helm-ag
    ;; helm-projectile
    ;; helm-swoop ;; https://github.com/ShingoFukuyama/helm-swoop
    ;; browse-kill-ring
    ;; Go -(
    go-mode
    go-snippets
    rust-mode
    lsp-mode
    lsp-ui
    go-errcheck
    go-eldoc
    go-autocomplete
    flycheck-golangci-lint
    golint
    web-mode
    prettier
    tide ;; Extended Typescript mode
    ng2-mode
    bongo
    python-mode
    geben
    markdown-mode
    move-text
    smartparens
    json-reformat
    textile-mode
    treemacs
    treemacs-projectile
    direnv
    emojify
    rainbow-mode
    which-key
    origami
    quick-preview
    editorconfig
    ;; Minor mode providing support for Zen Coding by producing HTML from CSS-like selectors
    ;; https://github.com/smihica/emmet-mode
    ;; Place point in a emmet snippet and press C-j to expand it (or
    ;; alternatively, alias your preferred keystroke to M-x
    ;; emmet-expand-line) and you'll transform your snippet into the
    ;; appropriate tag structure.
    emmet-mode
    url-shortener
    ;; This minor mode highlights indentation levels via
    ;; font-lock. Indent widths are dynamically discovered, which
    ;; means this correctly highlights in any mode, regardless of
    ;; indent width, even in languages with non-uniform indentation
    ;; such as Haskell. By default, this mode also inspects your theme
    ;; dynamically, and automatically chooses appropriate colors for
    ;; highlighting. This mode works properly around hard tabs and
    ;; mixed indentation, and it behaves well in large buffers.
    highlight-indent-guides
    ;; Use ripgrep in Emacs.
    ;; Ripgrep is a replacement for both grep like (search one file)
    ;; and ag like (search many files) tools.
    rg
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

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


;; -------
;; * ido *
;; Pour changer de buffer ou ouvrir un fichier en donnant
;; une sous chaine (clavier C-Tab defini dans pi-global-keys.el; C-x b par defaut)
;; Utiliser C-s C-r pour faire défiler le menu.
;; Un paquet indispensable!
(defcustom pi-use-flx-ido-p nil
  "When set to true enable flx integration for ido.
See https://github.com/lewang/flx
You need to restart Emacs when changing the value"
  :type 'boolean
  :group 'pimacs)

(when (require 'ido "ido.elc" t) ;;Part of emacs22
  (when (not (locate-library "helm"))
    ;; C-tab ou C-x b pour changer de buffer
    (global-set-key (kbd "<C-tab>") 'ido-switch-buffer)
    (ido-mode 1)
    (ido-everywhere 1)
    (when (require 'ido-ubiquitous nil t)
      (ido-ubiquitous-mode 1)
      )
    )


  ;; (when (and pi-use-flx-ido-p (require 'flx-ido nil t))
  ;;   ;; disable ido faces to see flx highlights.
  ;;   (setq ido-enable-flex-matching t)
  ;;   (setq ido-use-faces nil))

  (setq ido-case-fold t ;; Insensible à la casse
        ;; File in which the ido state is saved between invocations.
        ido-save-directory-list-file (user-var-file ".ido.last"))

  (setq ido-ignore-files
        (append ido-ignore-files
                (list
                 ".*\\.aux$"
                 ".*\\.dvi$"
                 ".*\\.ps$"
                 ".*\\.eps$"
                 ".*\\.toc$"
                 ".*\\.nav$"
                 ".*\\.pdf$"
                 ".*\\.gif$"
                 ".*\\.png$"
                 ".*~$")))

  (setq ido-ignore-buffers
        (append ido-ignore-buffers
                (list
                 "\\*BBDB\\*")))


  (when (require 'ido-vertical-mode nil t)
    (ido-vertical-mode 1)
    (setq ido-vertical-define-keys 'C-n-and-C-p-only)
    (setq ido-vertical-show-count t)
    )
  )

(provide 'pi-ido)
;;; pi-ido.el ends here

;; Local variables:
;; coding: utf-8
;; End:

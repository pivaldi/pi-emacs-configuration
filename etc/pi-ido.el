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


(setq ido-case-fold t ;; Insensible à la casse
      ;; File in which the ido state is saved between invocations.
      ido-save-directory-list-file (user-conf-file ".ido.last"))

(when (require 'ido "ido.elc" t) ;;Part of emacs22
  (when (not (locate-library "helm"))
    ;; C-tab ou C-x b pour changer de buffer
    (global-set-key (kbd "<C-tab>") 'ido-switch-buffer)
    (ido-mode 1)
    (ido-everywhere 1)

    (when (require 'ido "ido.elc" t)
      (require 'ido-completing-read+)
      (ido-ubiquitous-mode 1))
    )

  ;; Smex allows you to use ido for completion of commands in M-x,
  ;; with enhancements like putting your most-used commands at the
  ;; front of the list.
  (when (require 'smex nil t) ; Not needed if you use package.el
    (smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                                        ; when Smex is auto-initialized on its first run.
    (global-set-key (kbd "M-x") 'smex)
    (global-set-key (kbd "M-X") 'smex-major-mode-commands)
    ;; This is your old M-x.
    (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
    )

  (setq ido-ignore-files
        (append ido-ignore-files
                (list
                 ".*\\.aux$"
                 ".*\\.toc$"
                 ".*\\.nav$"
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

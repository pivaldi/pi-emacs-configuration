;;; package --- neotree PI emacs config
;; Copyright (c) 2021, Philippe Ivaldi <www.piprime.fr>

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
;;; Code:


(when (require 'neotree nil t)
  (setq neo-window-fixed-size nil)
  ;; When running ‘projectile-switch-project’ (C-c p p), ‘neotree’ will change root automatically.
  (setq projectile-switch-project-action 'neotree-projectile-action)

  (defun neotree-sync-to-buffer ()
    "Open or synchronize NeoTree to the current filename."
    (interactive)
    (if (neo-global--window-exists-p)
        (save-excursion
          (neo-global--open-and-find (buffer-file-name))
          (with-selected-window (neo-global--get-window)
            (recenter-top-bottom)))
      (neotree-toggle)))

  (defun neotree-project-dir ()
    "Open NeoTree using the projectile root dir."
    (interactive)
    (when (not (neo-global--window-exists-p))
      (neotree-toggle)
      )
    (save-excursion
      (let ((project-dir (projectile-project-root))
            (file-name (buffer-file-name)))
        (if project-dir
            (progn
              (neo-global--open-and-find project-dir)
              (with-selected-window (neo-global--get-window)
                (recenter-top-bottom)))
          (message "Could not find project root directory.")
          ))))

  (global-set-key [f7] 'neotree-toggle)
  (global-set-key [C-f7] 'neotree-project-dir)
  (global-set-key [S-f7] 'neotree-sync-to-buffer)

  )

(provide 'pi-neotree)

;;; pi-neotree ends here

;;; package --- Lua config file
;; Copyright (c) 2024, Philippe Ivaldi <www.piprime.fr>

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

(when (locate-library (cuid "site-lisp/lua-mode.el"))
  (setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
  (autoload 'lua-mode "lua-mode" "Lua editing mode." t)

  (when (require 'lsp-mode nil t)
    (add-hook 'lua-mode-hook #'lsp)
    (eval-after-load 'lua-mode
      '(progn
         (define-key lua-mode-map (kbd "M-.") 'lsp-find-definition)
         (setq lsp-lua-workspace-library (ht ("/usr/share/awesome/lib" t)))
         ))
    )
  )

(provide 'pi-lua)

;;; pi-lua.el ends here

;; Local variables:
;; coding: utf-8
;; End:

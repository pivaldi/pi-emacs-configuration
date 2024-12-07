;;; Package --- description here
;; Copyright (c) 2023, Philippe Ivaldi <www.piprime.fr>

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




(when (require 'lsp-mode nil t)
  (with-eval-after-load 'lsp-mode
    ;; :global/:workspace/:file
    (setq lsp-modeline-diagnostics-scope :workspace)
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\vendor\\'"))

  (lsp-ensure-server 'ts-ls)
  (lsp-ensure-server 'eslint)
  (lsp-ensure-server 'json-ls)

  (when (require 'lsp-treemacs)
    (lsp-treemacs-sync-mode 1))

  )

(provide 'pi-lsp)
;;; pi-lsp.el ends here

;; Local variables:
;; coding: utf-8
;; End:

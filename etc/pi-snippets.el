;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; $Last Modified on 2018/03/05 16:30:02

;; This program is free software ; you can redistribute it and/or modify
;; it under the terms of the GNU Lesser General Public License as published by
;; the Free Software Foundation ; either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY ; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; Lesser General Public License for more details.

;; You should have received a copy of the GNU Lesser General Public License
;; along with this program ; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


;; http://code.google.com/p/yasnippet/
(when (require 'yasnippet nil t)
  (defalias 'yas/current-snippet-table 'yas--get-snippet-tables)
  (defalias 'yas/table-hash 'yas--table-hash)

  ;; `yas/next-field-key' can trigger stacked expansions.
  (setq yas-triggers-in-field t)

  (defun pi-basic-snippet-expand-condition ()
    (let ((char (char-to-string (char-after))))
      (not (string-match "[a-zA-Z]" char))))

  ;; Load the snippets
  (setq yas-snippet-dirs (list (cuid "site-lisp/pi-snippets") 'yas-installed-snippets-dir))
  (yas-global-mode 1)

  (when (locate-library (cuid "site-lisp/hlissner-snippets/emacs-snippets.el"))
    (add-to-list 'load-path (cuid "site-lisp/hlissner-snippets/"))
    (require 'emacs-snippets)
    )

  (define-key yas-minor-mode-map (kbd "<tab>") nil)
  (define-key yas-minor-mode-map (kbd "TAB") nil)
  (define-key yas-minor-mode-map (kbd "<f3>") 'yas-expand)

  (eval-after-load 'auto-complete
    '(progn
       (require 'auto-complete-yasnippet "auto-complete-yasnippet.elc" t)))
  )

;; Local variables:
;; coding: utf-8
;; End:

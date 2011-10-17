;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-cpp.el,v 0.0 2011/09/29 15:25:53 Exp $
;; $Last Modified on 2011/09/29 15:25:53

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

(when (require 'cc-mode nil t)

  (defun pi-c++-mode-hook ()
    ""
    (unless (or (file-exists-p "Makefile")
                (file-exists-p "makefile"))
      (set (make-local-variable 'compile-command)
           (let* ((file (file-name-nondirectory buffer-file-name))
                  (filess (file-name-sans-extension file)))
             (format "g++ -o %s %s && ./%s"
                     (file-name-sans-extension file) file filess)))))

  (define-key c++-mode-map (kbd "C-c C-c") 'compile)
  (define-key c++-mode-map (kbd "²")
    '(lambda nil
       (interactive)
       (insert "->")))
  (define-key c++-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
  (define-key c++-mode-map "\{" 'skeleton-pair-insert-maybe)
  (define-key c++-mode-map "\(" 'skeleton-pair-insert-maybe)
  (define-key c++-mode-map "[" 'skeleton-pair-insert-maybe)
  (define-key c++-mode-map "\"" 'skeleton-pair-insert-maybe)
  (define-key c++-mode-map "'" 'skeleton-pair-insert-maybe)
  (define-key c++-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key c++-mode-map [(control meta q)] 'indent-sexp)

  (add-hook 'c++-mode-hook 'pi-c++-mode-hook))


(provide 'pi-cpp)
;;; pi-cpp.el ends here

;; Local variables:
;; coding: utf-8
;; End:


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

  (add-hook 'c++-mode-hook 'pi-c++-mode-hook)

  ;; Do not check for old-style (K&R) function declarations;
  ;; this speeds up indenting a lot.
  (setq c-recognize-knr-p nil)

  ;; Switch fromm *.<impl> to *.<head> and vice versa
  ;; from http://www.emacswiki.org/emacs/QtMode
  (defun pi-switch-cc-to-h ()
    (interactive)
    (when (string-match "^\\(.*\\)\\.\\([^.]*\\)$" buffer-file-name)
      (let ((name (match-string 1 buffer-file-name))
            (suffix (match-string 2 buffer-file-name)))
        (cond ((string-match suffix "c\\|cc\\|C\\|cpp")
               (cond ((file-exists-p (concat name ".h"))
                      (find-file (concat name ".h"))
                      )
                     ((file-exists-p (concat name ".hh"))
                      (find-file (concat name ".hh"))
                      )
                     ))
              ((string-match suffix "h\\|hh")
               (cond ((file-exists-p (concat name ".cc"))
                      (find-file (concat name ".cc"))
                      )
                     ((file-exists-p (concat name ".C"))
                      (find-file (concat name ".C"))
                      )
                     ((file-exists-p (concat name ".cpp"))
                      (find-file (concat name ".cpp"))
                      )
                     ((file-exists-p (concat name ".c"))
                      (find-file (concat name ".c"))
                      )))))))

  )


(provide 'pi-cpp)
;;; pi-cpp.el ends here

;; Local variables:
;; coding: utf-8
;; End:


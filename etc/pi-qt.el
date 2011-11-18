;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-qt.el,v 0.0 2011/11/17 10:08:56 Exp $
;; $Last Modified on 2011/11/17 10:08:56

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


(when (require 'semantic/bovine/c nil t)
  ;; From http://www.emacswiki.org/emacs/QtMode
  (setq qt-source-directory "/usr/local/src/qt/src"
        qt-include-directory (expand-file-name "../include/"
                                               qt-source-directory))
  (when (file-exists-p qt-source-directory)
    ;; Editing .pro and .pri files
    (require 'qt-pro)
    (add-to-list 'auto-mode-alist '("\\.pr[io]$" . qt-pro-mode))

    (add-to-list 'auto-mode-alist (cons qt-source-directory 'c++-mode))
    (setq cc-search-directories qt-source-directory)
    (add-to-list 'auto-mode-alist (cons qt-include-directory 'c++-mode))

    (dolist (file (directory-files qt-include-directory))
      (let ((path (expand-file-name file qt-include-directory)))
        (when (and (file-directory-p path)
                   (not (or (equal file ".") (equal file ".."))))
          (progn
            (semantic-add-system-include path 'c++-mode)
            (add-to-list 'cc-search-directories path)))))

    (dolist (file (list "QtCore/qconfig.h" "QtCore/qconfig-dist.h" "QtCore/qconfig-large.h"
                        "QtCore/qconfig-medium.h" "QtCore/qconfig-minimal.h" "QtCore/qconfig-small.h"
                        "QtCore/qglobal.h"))
      (add-to-list 'semantic-lex-c-preprocessor-symbol-file (expand-file-name file qt-include-directory)))

    ;; syntax-highlighting for Qt
    ;; (based on work by Arndt Gulbrandsen, Troll Tech)
    (defun jk/c-mode-common-hook ()
      "Set up c-mode and related modes.
 Includes support for Qt code (signal, slots and alikes)."
      ;; qt keywords and stuff ...
      ;; set up indenting correctly for new qt kewords
      (setq c-protection-key (concat "\\<\\(public\\|public slot\\|protected"
                                     "\\|protected slot\\|private\\|private slot"
                                     "\\)\\>")
            c-C++-access-key (concat "\\<\\(signals\\|public\\|protected\\|private"
                                     "\\|public slots\\|protected slots\\|private slots"
                                     "\\)\\>[ \t]*:"))
      (progn
        ;; modify the colour of slots to match public, private, etc ...
        (font-lock-add-keywords 'c++-mode
                                '(("\\<\\(slots\\|signals\\)\\>" . font-lock-type-face)))
        ;; make new font for rest of qt keywords
        (make-face 'qt-keywords-face)
        (set-face-foreground 'qt-keywords-face "BlueViolet")
        ;; qt keywords
        (font-lock-add-keywords 'c++-mode
                                '(("\\<Q_OBJECT\\>" . 'qt-keywords-face)))
        (font-lock-add-keywords 'c++-mode
                                '(("\\<SIGNAL\\|SLOT\\>" . 'qt-keywords-face)))
        (font-lock-add-keywords 'c++-mode
                                '(("\\<Q[A-Z][A-Za-z]*" . 'qt-keywords-face)))
        ))
    (add-hook 'c-mode-common-hook 'jk/c-mode-common-hook)))


  (provide 'pi-qt)
;;; pi-qt.el ends here

  ;; Local variables:
  ;; coding: utf-8
  ;; End:


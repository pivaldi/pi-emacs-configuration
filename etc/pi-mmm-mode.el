;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-mmm-mode.el,v 0.0 2012/07/01 13:06:21 Exp $
;; $Last Modified on 2012/07/01 13:06:21

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

(when (locate-library (cuid "site-lisp/mmm-mode/mmm-auto.el"))
  (add-to-list 'load-path (cuid "site-lisp/mmm-mode/"))
  (require 'mmm-auto)
  (require 'mmm-vars)
  ;; (set-face-background 'mmm-default-submode-face nil)
  (setq mmm-submode-decoration-level 0)
  (setq mmm-global-mode 'maybe)

  ;; All ;;{{{ CODE }}} come from mmm-sample.el --- Sample MMM submode classes
  ;; Copyright (C) 2003, 2004 by Michael Abraham Shulman
  ;; Author: Michael Abraham Shulman <viritrilbia@users.sourceforge.net>
  ;;{{{ CSS embedded in HTML
  ;; This is the simplest example. Many applications will need no more
  ;; than a simple regexp.
  (mmm-add-classes
   '((embedded-css
      :submode css
      :face mmm-declaration-submode-face
      :delimiter-mode nil
      :front "<style[^>]*>"
      :back "</style>")))

  (add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil embedded-css))
  ;;}}}
  ;;{{{ Javascript in HTML
  ;; We use two classes here, one for code in a <script> tag and another
  ;; for code embedded as a property of an HTML tag, then another class
  ;; to group them together.
  ;; (mmm-add-group
  ;;  'html-js
  ;;  '((js-tag
  ;;     :submode js2-mode
  ;;     :face mmm-code-submode-face
  ;;     :delimiter-mode nil
  ;;     :front "<script\[^>\]*\\(language=\"javascript\\([0-9.]*\\)\"\\|type=\"text/javascript\"\\)\[^>\]*>"
  ;;     :back"</script>"
  ;;     :insert ((?j js-tag nil @ "<script language=\"JavaScript\">"
  ;;                  @ "\n" _ "\n" @ "</script>" @))
  ;;     )
  ;;    (js-inline
  ;;     :submode js2-mode
  ;;     :face mmm-code-submode-face
  ;;     :delimiter-mode nil
  ;;     :front "on\\w+=\""
  ;;     :back "\"")))

  ;; (add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil html-php))
  ;; (add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil html-js))

  ;;}}}
  ;;{{{ Here-documents
  ;; Here we match the here-document syntax used by Perl and shell
  ;; scripts.  We try to be automagic about recognizing what mode the
  ;; here-document should be in.  To make sure that it is recognized
  ;; correctly, the name of the mode, perhaps minus `-mode', in upper
  ;; case, and/or with hyphens converted to underscores, should be
  ;; separated from the rest of the here-document name by hyphens or
  ;; underscores.
  (defvar mmm-here-doc-mode-alist '()
    "Alist associating here-document name regexps to submodes.
Normally, this variable is unnecessary, as the `here-doc' submode
class tries to automagically recognize the right submode.  If you use
here-document names that it doesn't recognize, however, then you can
add elements to this alist.  Each element is \(REGEXP . MODE) where
REGEXP is a regular expression matched against the here-document name
and MODE is a major mode function symbol.")

  (defun mmm-here-doc-get-mode (string)
    (string-match "[a-zA-Z_-]+" string)
    (setq string (match-string 0 string))
    (or (mmm-ensure-modename
         ;; First try the user override variable.
         (some #'(lambda (pair)
                   (if (string-match (car pair) string) (cdr pair) nil))
               mmm-here-doc-mode-alist))
        (let ((words (split-string (downcase string) "[_-]+")))
          (or (mmm-ensure-modename
               ;; Try the whole name, stopping at "mode" if present.
               (intern
                (mapconcat #'identity
                           (nconc (ldiff words (member "mode" words))
                                  (list "mode"))
                           "-")))
              ;; Try each word by itself (preference list)
              (some #'(lambda (word)
                        (mmm-ensure-modename (intern word)))
                    words)
              ;; Try each word with -mode tacked on
              (some #'(lambda (word)
                        (mmm-ensure-modename
                         (intern (concat word "-mode"))))
                    words)
              ;; Try each pair of words with -mode tacked on
              (loop for (one two) on words
                    if (mmm-ensure-modename
                        (intern (concat one two "-mode")))
                    return it)
              ;; I'm unaware of any modes whose names, minus `-mode',
              ;; are more than two words long, and if the entire mode
              ;; name (perhaps minus `-mode') doesn't occur in the
              ;; here-document name, we can give up.
              (signal 'mmm-no-matching-submode nil)))))

  (mmm-add-classes
   '((here-doc
      :front "<<<?[\"\'\`]?\\([a-zA-Z0-9_-]+\\)"
      :front-offset (end-of-line 1)
      :back "^~1;?$"
      :save-matches 1
      :delimiter-mode nil
      :match-submode mmm-here-doc-get-mode
      :insert ((?d here-doc "Here-document Name: " @ "<<" str _ "\n"
                   @ "\n" @ str "\n" @))
      )))

  (add-to-list 'mmm-mode-ext-classes-alist '(php-mode nil here-doc))
  ;;}}}

  ;;{{{ PHP in HTML
  (mmm-add-group 'html-php
                 '((html-php-output
                    :submode php-mode
                    :face mmm-output-submode-face
                    :front "<\\?php *echo "
                    :back "\\?>"
                    :include-front t
                    :front-offset 5
                    :insert ((?e php-echo nil @ "<?php" @ " echo " _ " " @ "?>" @))
                    )
                   (html-php-code
                    :submode php-mode
                    :face mmm-code-submode-face
                    :front "<\\?\\(php\\)?"
                    :back "\\?>"
                    :insert ((?p php-section nil @ "<?php" @ " " _ " " @ "?>" @)
                             (?b php-block nil @ "<?php" @ "\n" _ "\n" @ "?>" @))
                    )
                   ))

  (add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil html-php))
  ;;}}}

  ;; What files to invoke the new html-mode for?
  (add-to-list 'auto-mode-alist '("\\.inc\\'" . html-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . html-mode))
  ;; What features should be turned on in this html-mode?
  ;; (add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil html-js))
  ;; (add-to-list 'mmm-mode-ext-classes-alist '(html-mode nil embedded-css))


  (let ((vars '(indent-line-function
                indent-region-function)))
    (mapc (lambda (x)
            (add-to-list 'mmm-save-local-variables `(,x nil ,mmm-c-derived-modes)))
          vars))

  )


(provide 'pi-mmm-mode)
;;; pi-mmm-mode.el ends here

;; Local variables:
;; coding: utf-8
;; End:


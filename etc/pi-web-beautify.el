;; Copyright (c) 2015, Philippe Ivaldi <www.piprime.fr>

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

(when (executable-find "js-beautify")
  (add-to-list 'load-path (cuid "site-lisp/web-beautify"))
  (require 'web-beautify)

  (defun pi-web-beautify-js-buffer ()
      "web-beautify-js-buffer wrapper to allow other actions. recenter-top-bottom for now."
      (interactive)
      (web-beautify-js-buffer)
      (recenter-top-bottom))

  (defun pi-web-beautify-css-buffer ()
    "web-beautify-css-buffer wrapper to allow other actions. recenter-top-bottom for now."
    (interactive)
    (web-beautify-css-buffer)
    (recenter-top-bottom))

  (defun pi-web-beautify-html-buffer ()
    "web-beautify-html-buffer wrapper to allow other actions. recenter-top-bottom for now."
    (interactive)
    (web-beautify-html-buffer)
    (recenter-top-bottom))

  (eval-after-load 'js2-mode
    '(add-hook 'js2-mode-hook
               (lambda ()
                 (add-hook 'before-save-hook 'pi-web-beautify-js-buffer t t))))

  (eval-after-load 'json-mode
    '(add-hook 'json-mode-hook
               (lambda ()
                 (add-hook 'before-save-hook 'pi-web-beautify-js-buffer t t))))

  (eval-after-load 'sgml-mode
    '(add-hook 'html-mode-hook
               (lambda ()
                 (add-hook 'before-save-hook 'pi-web-beautify-html-buffer t t))))

  (eval-after-load 'css-mode
    '(add-hook 'css-mode-hook
               (lambda ()
                 (add-hook 'before-save-hook 'pi-web-beautify-css-buffer t t))))
  )

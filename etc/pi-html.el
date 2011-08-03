;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-html.el,v 0.0 2011/07/13 23:58:56 Exp $
;; $Last Modified on 2011/07/13 23:58:56

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

(eval-after-load "sgml-mode"
  (progn
     (add-hook 'html-mode-hook
               (lambda nil
                 ;; Disable automatic viewing via `browse-url-of-buffer' upon saving buffer
                 (html-autoview-mode -1)
                 ;; DON'T add a newline automatically at the end of the file.
                 (setq require-final-newline nil)
                 (auto-fill-mode -1)))))

(provide 'pi-html)
;;; pi-html.el ends here

;; Local variables:
;; coding: utf-8
;; End:


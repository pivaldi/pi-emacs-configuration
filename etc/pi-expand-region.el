;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-expand-region.el,v 0.0 2012/09/16 22:29:12 Exp $
;; $Last Modified on 2012/09/16 22:29:12

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

;; Code:


(when (locate-library (cuid "site-lisp/expand-region/expand-region.el"))
  (add-to-list 'load-path (cuid "site-lisp/expand-region/"))
  (require 'expand-region)
  (global-set-key (kbd "C-=") 'er/expand-region)
)



(provide 'pi-expand-region)
;;; pi-expand-region.el ends here

;; Local variables:
;; coding: utf-8
;; End:


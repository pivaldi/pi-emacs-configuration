;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-ctpl.el,v 0.0 2011/10/14 12:51:44 Exp $
;; $Last Modified on 2011/10/14 12:51:44

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

(setq auto-mode-alist (cons '("\\.tpl$" . tpl-mode) auto-mode-alist))
(autoload 'tpl-mode "tpl-mode" "Major mode for editing CTemplate files." t)



(provide 'pi-ctpl)
;;; pi-ctpl.el ends here

;; Local variables:
;; coding: utf-8
;; End:


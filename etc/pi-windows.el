;;; Copyright (c) 2016, Philippe Ivaldi <www.piprime.fr>

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

;;; THANKS:

;;; BUGS:

;;; INSTALLATION:

;;; Code:


;; ----------------
;; * Windows mode *
;;; Windows.el  enables  you  to  have  multiple  favorite  window
;;; configurations at the same  time, and switch them.  Furthermore,
;;; it  can  save  all  window  configurations and  some  global  or
;;; buffer-local variables into a file and restore them correctly.
;;;       The default prefix key stroke for Windows is `C-c C-w'.  If it
;;; causes  you some  troubles, see  the  section  `Customizations'.
;;; Here are the default key bindings.
;;;
;;;  C-c C-w 1  Switch to window 1 (Q)
;;;  C-c C-w 2  Switch to window 2 (Q)
;;;
;;;  C-c C-w 9  Switch to window 9 (Q)
;;;  C-c C-w 0  Swap windows with the buffer 0 (Q)
;;;     (Select unallocated frame(Emacs 19))
;;;  C-c C-w SPC  Switch to window previously shown (Q)
;;;  C-c C-w C-n  Switch to next window
;;;  C-c C-w C-p  Switch to previous window
;;;  C-c C-w !  Delete current window (Q)
;;;  C-c C-w C-w  Window operation menu
;;;  C-c C-w C-r  Resume menu
;;;  C-c C-w C-l  Local resume menu
;;;  C-c C-w C-s  Switch task
;;;  C-c C-w =  Show window list (Q)
(require 'windows "windows.elc" t)


(provide 'pi-windows)
;;; pi-windows.el ends here

;; Local variables:
;; coding: utf-8
;; End:

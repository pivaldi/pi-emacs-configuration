;; Copyright (C) 1996, 1997, 1998, 1999, 2000, 2001
;;        David J. Biesack

;; This file is not part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;; M-x scissors

;; Author: David Biesack (David.Biesack@sas.com  or biesack@mindspring.com)
;; Last Modified By: biesack@mindspring.com
;; Last Modified: Thu Mar 15 17:50:30 2001

(defvar scissors "8<------"
  "string to insert in \\[scissors]")

;;;###autoload
(defun separe ()
  "Insert a line of SCISSORS in the buffer"
  (interactive)
  (or (bolp) (beginning-of-line 2))
  (while (<= (current-column) (- (or fill-column 70) (length scissors)))
    (insert scissors))
  (newline))

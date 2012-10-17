;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-custom-defition.el,v 0.0 2012/10/15 23:56:46 Exp $
;; $Last Modified on 2012/10/17 00:34:44

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


;; *=======================================================*
;; *................customizable variables.................*
;; *=======================================================*

(defgroup pi-features nil
  "Manage feature you want that \"pi emacs configuration\" handle and configure"
  :group 'pi
  :group 'pi-features)

;; (defcustom pi-features-alist ("file1" "file2")
;;   "The list of features that \"pi emacs configuration\" must load and configure"
;;   :type '(set (const :tag "zekljmfej iezjfioezj foi" "file1" boolean)
;;               (const :tag "csdlkfc mlkdfklzemfk flkm vcdsv" "file2" boolean))
;;   :group 'pi-features)

;; -------------
;; * Pi Coding *
(defgroup pi-coding nil
  "Coding feature handled by the \"pi emacs configuration\""
  :group 'pi
  :group 'pi-coding)

(defcustom pi-auto-fill-mode-hook-alist
  '(text-mode-hook org-mode-hook)
  "Liste des hooks pour lesquels je veux le mode auto-fill-mode --coupure automatique des ligne longues--"
  :type 'hook
  :group 'pi-coding)

(defcustom pi-js2-fix-indent nil
  "If non nil, use a fix to force standard Emacs indentation in js2-mode"
  :type 'boolean
  :group 'pi-coding)

(defcustom pi-use-skeleton-pair-insert-maybe t
  "If non nil, use a use-skeleton-pair-insert-maybe as often as possible"
  :type 'boolean
  :group 'pi-coding)

;; ------------
;; * Bin Util *
(defgroup pi-bin-util nil
  "Binary command handled by the \"pi emacs configuration\""
  :group 'pi
  :group 'pi-bin-util)

(defcustom user-pdf-view-command "/usr/bin/xpdf"
  "* Preferred pdf viewer"
  :type 'file
  :group 'pi-bin-util)

(defcustom user-ps-view-command "/usr/bin/gv"
  "* Preferred ps/eps viewer."
  :type 'file
  :group 'pi-bin-util)

(defcustom user-path '("~/bin")
  "* Extra directory where live executable files."
  :type '(repeat file)
  :group 'pi-bin-util)

(defcustom user-web-browser "/usr/bin/google-chrome"
  "* the web browser program used by `browse-url-generic'"
  :type 'file
  :group 'pi-bin-util)

;; ---------------
;; * MY IDENTITY *
(defgroup pi-identity nil
  "Identity variables handled by the \"pi emacs configuration\""
  :group 'pi
  :group 'pi-identity)

(defcustom user-full-name "MUST BE OVERWROTE"
  "* User name handle by pi emacs configuration"
  :type 'string
  :group 'pi-identity)
(defcustom user-site-url "MUST BE OVERWROTE"
  "* User sit url handle by pi emacs configuration"
  :type 'string
  :group 'pi-identity)
(defcustom user-mail-address "MUST BE OVERWROTE"
  "* User mail address handle by pi emacs configuration"
  :type 'string
  :group 'pi-identity)
(defcustom user-obfuscated-mail "MUST BE OVERWROTE"
  "User obfuscated mail address handle by pi emacs configuration"
  :type 'string
  :group 'pi-identity)
(defcustom user-address "MUST BE OVERWROTE"
  "User address"
  :type 'string
  :group 'pi-identity)
(defcustom  user-phone "MUST BE OVERWROTE"
  "User phone"
  :type 'string
  :group 'pi-identity)

;; -----------
;; * Pi font *
(defgroup pi-bin-util nil
  "Binary command handled by the \"pi emacs configuration\""
  :group 'pi
  :group 'pi-font)

(defcustom pi-default-font "-xos4-terminus-bold-r-normal--20-*-*-*-*-*-*-*"
  "Default font. Use M-x pi-toggle-font to toggle with pi-small-font"
  :type 'string
  :group 'pi-font)
(defcustom pi-small-font "-*-*-medium-r-normal-*-*-160-*-*-*-*-*-*"
  "Small font. Use M-x pi-toggle-font to toggle with pi-big-font"
  :type 'string
  :group 'pi-font)

(defvar pi-current-font-size "big")




(provide 'pi-custom-defition)
;;; pi-custom-defition.el ends here

;; Local variables:
;; coding: utf-8
;; End:


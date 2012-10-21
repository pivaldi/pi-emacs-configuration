;; Copyright (c) 2012, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: pi-custom-defition.el,v 0.0 2012/10/15 23:56:46 Exp $
;; $Last Modified on 2012/10/21 23:29:15

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

(defcustom pi-features-alist '("pi-font" "pi-configuration")
  "The list of features that \"pi emacs configuration\" must load and configure"
  :type '(set (const :tag "pi-font : Default font configuration (recommended [configuration])" "pi-font" boolean)
              (const :tag "pi-configuration : Default configuration (recommended  [configuration])" "pi-configuration" boolean)
              (const :tag "pi-undohistory : Save redo/undo history across sessions (optional  [configuration])" "pi-undohistory" boolean)
              (const :tag "pi-flymake : Minor mode to do on-the-fly syntax checking  (optional  [programming])" "pi-flymake" boolean)
              (const :tag "pi-elisp : Major mode for editing Lisp code to run in Emacs (optional [programming])" "pi-elisp" boolean)
              (const :tag "pi-unwanted : Things that are not usually necessary but that I like -- eg total absence of bars- (optional [configuration])" "pi-unwanted" boolean)
              (const :tag "pi-time : French Configuration of the Calendar (Only for french user [configuration])" "pi-time" boolean)
              (const :tag "pi-browse-url : See http://www.emacswiki.org/cgi-bin/wiki/BrowseAproposURL (Optional [Feature])" "pi-browse-url" boolean)
              (const :tag "pi-sql.el : For SQL mode (Optional [Programming Database])" "pi-sql.el" boolean)
              (const :tag "pi-keys : I want PI's keyboard shortcuts (recommended [configuration])" "pi-keys" boolean)
              (const :tag "pi-org : Outline-based notes management and organizer" "pi-org" boolean)
              (const :tag "pi-tex : Configure the (La)TeX environment AUCTEX (Only for latex user [latex])" "pi-tex" boolean)
              (const :tag "pi-meta : Configure the MetaPost editing mode (Only for latex and metapost user [latex])" "pi-meta" boolean)
              (const :tag "pi-abbrev&tempo : Abbreviations et complétion avec tempo.el. See http://www.emacswiki.org/cgi-bin/wiki/TempoMode (Recommended [Configuration&Feature])" "pi-abbrev&tempo" boolean)
              (const :tag "pi-complete : Advanced Auto completion, see http://tinyurl.com/6322eo and http://tinyurl.com/39ktaq (Recommended [Feature])" "pi-complete" boolean)
              (const :tag "pi-gtags : GNU GLOBAL Source Code Tag System (Obsolete [Programming])" "pi-gtags" boolean)
              (const :tag "pi-php : Mode to edit php source code (Optional [Programming])" "pi-php" boolean)
              (const :tag "pi-html : Mode to edit html source code (Optional [Editing])" "pi-html" boolean)
              (const :tag "pi-mmm-mode : Add support for multiple major mode in the same buffer (Buggy [Feature])" "pi-mmm-mode" boolean)
              (const :tag "pi-ctpl : Major mode for editing CTemplate files. (Optionnal [Programming])" "pi-ctpl" boolean)
              (const :tag "pi-qt : Major mode for editing C++ files with QT. (Optionnal [Programming])" "pi-qt" boolean)
              (const :tag "pi-python : For the Python programmer (Optionnal [Progamming])" "pi-python" boolean)
              (const :tag "pi-cedet : For advanced programming (Optional [Programming])" "pi-cedet" boolean)
              (const :tag "pi-ecb : For navigating in programming code (Optional [Programming])" "pi-ecb" boolean)
              (const :tag "pi-jde : For the Java programmers (Optional [Programming])" "pi-jde" boolean)
              (const :tag "pi-geben : To debug programs (Optional [Programming])" "pi-geben" boolean)
              (const :tag "pi-jabber : Chat with an XMPP Jabber server (Optional [Feature])" "pi-jabber" boolean)
              (const :tag "pi-typoscript : To edit ugly typoscript language source code (Optional [Programming])" "pi-typoscript" boolean)
              (const :tag "pi-lua : Programmation en LUA (Optional [Programming])" "pi-lua" boolean)
              (const :tag "pi-haskell : Programmation en haskell (Optional [Programming])" "pi-haskell" boolean)
              (const :tag "pi-muse : Publishing environment for Emacs. See http://tinyurl.com/yss6oa (Optional [Publishing])" "pi-muse" boolean)
              (const :tag "pi-crypt : The files with the extension .gpg will be crypted. Very useful to keep pass word and other confidential data (Optional [Feature])" "pi-crypt" boolean)
              (const :tag "pi-table : Load and configure a package that provides text based table creation and editing feature  (Old/ Maybe buggy [Feature])" "pi-table" boolean)
              (const :tag "pi-lacarte : <ESC> M-x execute menu items as commands, with completion (Optional [Feature])" "pi-lacarte" boolean)
              (const :tag "pi-ftp : Basis ftp configuration (Recommended [configuration])" "pi-ftp" boolean)
              (const :tag "pi-yaml : Editing yaml file (Optional [Programming])" "pi-yaml" boolean)
              (const :tag "pi-sass : Emacs mode for Sass : http://sass-lang.com/ (Optional [Programming])" "pi-sass" boolean)
              (const :tag "pi-dired : Edit directory, delete, rename, print, etc. some files in it (Recommended [Feature])" "pi-dired" boolean)
              (const :tag "pi-maxima : Formal calculations with Maxima (Optional [Scientist])" "pi-maxima" boolean)
              (const :tag "pi-scilab : Complex numerical calculations with Scilab (Optional [Scientist])" "pi-scilab" boolean)
              (const :tag "pi-pari-gp : Complex numerical calculations Pari/gp (Optional [Scientist])" "pi-pari-gp" boolean)
              (const :tag "pi-povray : Synthetic image with PovRay (Optional [Programming])" "pi-povray" boolean)
              (const :tag "pi-bongo : Flexible and usable media player for Emacs (Optional [Feature])" "pi-bongo" boolean)
              (const :tag "pi-emms : Emacs Multimedia System (Optional [Feature])" "pi-emms" boolean)
              (const :tag "pi-bm : Provides visible, buffer local, bookmarks and the ability to jump forward and backward to the next bookmark (Recommended [Feature])" "pi-bm" boolean)
              (const :tag "pi-markdown : For editing Markdown code. Documentation here http://jblevins.org/projects/markdown-mode/ (Optional [Editing])" "pi-markdown" boolean)
              (const :tag "pi-flyspell : Enable on-the-fly spell checker (Recommended [Editing])" "pi-flyspell" boolean)
              (const :tag "pi-scroll : Package that keeps the cursor on the same line (and in the same column) when scrolling by a page using PgUp/PgDn (Recommended [Feature])" "pi-scroll" boolean)
              (const :tag "pi-scramble : To Randomly permute non-border letters of words (Optional [Gadget])" "pi-scramble" boolean)
              (const :tag "pi-template-conf : Enable Auto-insert template in new file (Recommended [Feature])" "pi-template-conf" boolean)
              (const :tag "pi-asy : To edit Asymptote source code http://asymptote.sourceforge.net/ (Optional [Scientist])" "pi-asy" boolean)
              (const :tag "pi-bbdb : Enable Big Brother Database (BBDB) : a contact management utility (Optional [Feature])" "pi-bbdb" boolean)
              (const :tag "pi-js : To edit Javascript code source (Optional [Programming])" "pi-js" boolean)
              (const :tag "pi-expand-region : To Increase selected region by semantic units (Recommended [Feature])" "pi-expand-region" boolean)
              (const :tag "pi-snippets : To enable 'Yet another snippet extension' (Recommended [Feature])" "pi-snippets" boolean)
              (const :tag "pi-browse-kill-ring : C-c y Open a fancy buffer to show the kill-ring (Recommended [Feature])" "pi-browse-kill-ring" boolean))
  :group 'pi-features)

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

(defcustom pi-flyspell-prog-mode-alist
  '(emacs-lisp-mode-hook c-mode-hook asy-mode-hook html-mode-hook)
  "List of *programming hooks* where I want on-the-fly correction on comments and strings"
  :type '(repeat function)
  :group 'pi-flyspell)

(defcustom pi-flyspell-mode-alist
  '(text-mode-hook org-mode-hook jabber-chat-mode-hook)
  "List of hooks to which I want on-the-fly correction"
  :type '(repeat function)
  :group 'pi-flyspell)


(provide 'pi-custom-defition)
;;; pi-custom-defition.el ends here

;; Local variables:
;; coding: utf-8
;; End:


;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: params.el,v 0.0 2011/06/29 17:25:29 Exp $
;; $Last Modified on 2011/06/29 17:25:29

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

(eval-when-compile
  (require 'cl))

;; *=======================================================*
;; *.................VARIABLES À MODIFIER..................*

(defvar user-pdf-view-command "/usr/bin/xpdf"
  "* Commande utilisée pour visualiser les .pdf.")

(defvar user-ps-view-command "/usr/bin/gv"
  "* Commande utilisée pour visualiser les .ps/eps.")

(defvar user-path '("~/bin" "/usr/local/scilab-4.1/bin")
  "* Liste de répertoires où sont mes exécutables.
Les commandes qui lancent des sous-processus et la commande `compile'
parcourront aussi ces chemins pour trouver les exécutables.")

(defvar user-web-browser "/usr/bin/google-chrome"
  "* The name of the browser program used by `browse-url-generic'")

;; ---------------
;; * MY IDENTITY *
(setq
 user-full-name "Philippe Ivaldi"
 user-site-url "<http://www.piprime.fr/>"
 user-mail-address "pivaldi@sfr.fr"
 user-obfuscated-mail "<Xreplace@sfr.fr> Xreplace = pivaldi"
 user-address "Philippe Ivaldi\nLes Castaniès\n11250 Preixan"
 user-phone "04-68-26-95-81")

;; (setq jabber-account-list
;;       (quote
;;        (
;;         ("pivaldi@im.apinc.org"
;;          (:network-server . "im.apinc.org"))
;;         ("pi@dev.ircv.fr"
;;          (:network-server . "dev.ircv.fr"))
;;         ("pidlavi@gmail.com"
;;          (:network-server . "talk.google.com")
;;          (:port . 5223)
;;          (:connection-type . ssl))
;;         ;; ("jv2vbm@gmail.com"
;;         ;;  (:network-server . "talk.google.com")
;;         ;;  (:port . 5223)
;;         ;;  (:connection-type . ssl))
;;         )))

;; -------------------------
;; * Les fontes par défaut *
;; Utiliser xfontsel sous Linux pour voir celles qui sont disponibles.
;; pi-toggle-font permet de basculer entre les deux (voir pi-configuration.el)
;; (defvar pi-big-font "-xos4-terminus-bold-r-normal--20-*-*-*-*-*-*-*")
;; (defvar pi-small-font "-xos4-terminus-*-r-normal--16-*-*-*-*-*-*-*")
;; (defvar pi-current-font-size "big")


;; *.............FIN DES VARIABLES À MODIFIER..............*
;; *=======================================================*
(provide 'params)
;;; params.el ends here

;; Local variables:
;; coding: utf-8
;; End:


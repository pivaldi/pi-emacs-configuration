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

(defvar user-set-coding-system-latin nil
  "* Remplacer nil par t pour utiliser
latin-1 et latin-9 comme encodage par défaut.")

(defvar user-pdf-view-command "/usr/bin/evince"
  "* Commande utilisée pour visualiser les .pdf.")

(defvar user-ps-view-command "/usr/bin/gv"
  "* Commande utilisée pour visualiser les .ps/eps.")

(defvar user-path '("~/bin")
  "* Liste de répertoires où l'on peut trouver des exécutables.
Les commandes qui lancent des sous-processus et la commande `compile'
parcourront aussi ces chemins pour trouver les exécutables.")

(defvar user-web-browser "/usr/bin/google-chrome"
  "* The name of the browser program used by `browse-url-generic'")

;; ---------------
;; * MY IDENTITY *
(setq
 user-full-name "Jean-François Gigand"
 user-mail-address "okapi@lapatate.org"
 user-obfuscated-mail "<Xreplace@lapatate.org> Xreplace = okapi"
 user-address "Jean-François Gigand\n50 rue des Morillons\n75015 Paris"
 user-phone "06-21-98-77-72")

(setq jabber-account-list
      (quote
       (("jig@dev.ircv.fr"
         (:network-server . "dev.ircv.fr")))))

;; -------------------------
;; * Les fontes par défaut *
;; Utiliser xfontsel sous Linux pour voir celles qui sont disponibles.
;; pi-toggle-font permet de basculer entre les deux (voir pi-configuration.el)
(setq pi-big-font "-xos4-terminus-bold-r-normal--20-*-*-*-*-*-*-*")
(defvar pi-small-font "-*-*-medium-r-normal-*-*-160-*-*-*-*-*-*")
(defvar pi-current-font-size "big")

(when window-system ;; Seulement en mode graphique (apparence différente sous X ou en console)
  ;; (set-default-font "-xos4-terminus-bold-r-normal--16-*-*-*-*-*-*-*")
  (set-face-attribute 'default nil :family "Inconsolata" :height 110)
  ;; Pour utiliser M-x customize-face sur la face `default' supprimer cette commande:
  (set-face-attribute 'default nil
                      :background "Black"
                      :foreground "Wheat"
                      ;;                       :underline nil
                      ;;                       :slant 'normal
                      ;;                       :weight 'bold
                      ;;                       :height 200
                      ;;                       :width 'normal
                      ;;                       :family "xos4-terminus"
                      )
  (set-face-attribute  'menu nil
                       :background "DarkSlateGray"
                       :foreground "grey"
                       :underline nil
                       :slant 'normal
                       ;;                        :weight 'bold
                       ;;                        :height 200
                       ;;                        :width 'normal
                       ;;                        :family "xos4-terminus"
                       ))


;; *.............FIN DES VARIABLES À MODIFIER..............*
;; *=======================================================*
(provide 'params)
;;; params.el ends here

;; Local variables:
;; coding: utf-8
;; End:


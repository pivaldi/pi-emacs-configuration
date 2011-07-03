;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; Version: $Id: init.el,v 1.0 2011/06/29 Exp $
;; $Last Modified on 2011/06/29

;; This program is free software ; you can redistribute it and/or modify
;; it under the terms of the GNU Lesser General Public License as published by
;; the Free Software Foundation ; either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY ; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; Lesser General Public License for more details.

;; You should have received a copy of the GNU Lesser General Public License
;; along with this program ; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

;; COMMENTARY:

;; THANKS:

;; BUGS:

;; CODE:

;; Set the debug option to enable a backtrace when a
;; problem occurs.
;; (setq debug-on-error t)

(eval-when-compile
  (require 'cl))

(defvar user-init-dir (file-name-directory user-init-file)
  "* Le répertoire racine de tous mes fichiers concernant Emacs.")

(defun cuid (FILENAME)
  "* Tous les paquets lisp sont définis relativement
au répertoire d'installation `user-init-dir'.
Utiliser cette fonction pour définir un répertoire/fichier relatif.
Attention `user-init-dir' se termine par un /"
  (concat user-init-dir FILENAME))

(load (cuid "user-pre-init"))

(when (< emacs-major-version 22)
  (setq inhibit-startup-message t)
  (error "Configuration not supported on Emacs < 22."))

;; *=======================================================*
;; *................Gestion des répertoires................*
;; *=======================================================*
(setq load-path (append load-path (list (cuid "etc")
                                        (cuid "site-lisp")
                                        )))
;; Load personal configuration
(if (string= (user-real-login-name) "pi")
    (load (cuid "pi-parameters"))
  (load (cuid "my-parameters")))

(dolist (adp user-path)
  (setenv "PATH" (concat (getenv "PATH") path-separator
                         (expand-file-name adp)))
  (push (expand-file-name adp) exec-path))

;; (defvar missing-packages-list nil
;;   "List of packages that `try-require' can't find.")

;; ;; Attempt to load a feature/library, failing silently
;; (defun try-require (feature)
;;   "Attempt to load a library or module. Return true if the
;; library given as argument is successfully loaded. If not, instead
;; of an error, just add the package to a list of missing packages.
;; Courtesy of http://www.mygooglest.com/fni/dot-emacs.html"
;;   (condition-case err
;;       ;; protected form
;;       (progn
;;         (message "Checking for library `%s'..." feature)
;;         (if (stringp feature)
;;             (load-library feature)
;;           (require feature))
;;         (message "Checking for library `%s'... Found" feature))
;;     ;; error handler
;;     (file-error  ; condition
;;      (progn
;;        (message "Checking for library `%s'... Missing" feature)
;;        (add-to-list 'missing-packages-list feature))
;;      nil)))

;; *=======================================================*
;; *.............chargement des configurations.............*
;; *=======================================================*

;; --------------------------
;; * Configuration de bases *
(defvar pi-auto-fill-mode-hook-alist
  '(text-mode-hook org-mode-hook)
  "Liste des hooks pour lesquels je veux le mode auto-fill-mode --coupure automatique des ligne longues--")
(load "pi-configuration")

;; ----------
;; * popwin *
;; Pour avoir configurer les fenêtres spéciales
;; (*Completion*, *compilation* etc) comme je veux
;; Certains petits defauts de cette extension me gêne vraiment
; (load "pi-popwin")

;; --------------------------------------------------
;; * Sauvegarde de redo/undo à travers les sessions *
;; (load "pi-undohistory")

;; ------------------------------
;; * on-the-fly syntax checking *
(load "pi-flymake")

;; ----------------------
;; * Programmer en Elisp *
(load "pi-elisp")

;; -------------------------
;; * Spécialement pour moi *
;; Des morceaux de code qui n'interressent vraiment que moi...
(when (locate-library "pi-only")
  (load "pi-only"))

;; --------------------------
;; * Configuration spéciale *
;; Des choses qui ne sont pas habituellement voulues mais
;; que moi j'aime (par exemple l'abscence totale de barres)
;; Raccourcis définis:
;; C-f1 pour basculer la visibilité de la barre de menu
(when (string= user-real-login-name "pi") ;; commenter cette ligne pour tester cette config
  (load "pi-unwanted")
  )                                       ;; commenter cette ligne pour tester cette config

;; -----------------------
;; * Dates et calendrier *
(load "pi-time")

;; ------------------------------------
;; * Facilités pour parcourir les url *
;; Raccourcis définis:
;; * C-b pour visiter le lien sous le curseur dans firefox
;; * C-S-b pour passer en paramètre la région sélectionnée à une url définie par un mot clef
;; les mots clefs sont:
;; gw pour Google Web
;; gl pour Google Linux
;; gg pour Google Groups
;; gt pour Google Translate Text
;; dic pour le Trésor de la Langue Française informatisé
;; conj pour la Conjugaison avec le bescherelle.
;; Exemple sélectionner le mot "myriade" puis C-S-b dic <RET> et aller voir votre navigateur...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fonctions utiles définies (accessible par M-x)
;; smallurl-replace-at-point : remplace l'url sous le curseur par une plus petit (utilise le service tinyurl)
;; smallurl                  : imprime et met dans le kill-ring une version tinyurl de l'url demandée.
(load "pi-browse-url")

;; ------------
;; * Pour SQL *
;; Pour les bases de données SQL, en particulier MySQL
(load "pi-sql.el")

;; -----------------------------------
;; * Configuration de base pour Gnus *
(when (string= (user-real-login-name) "pi")
  (load "pi-gnus")) ;; n'est chargé que chez moi :-)

;; -----------
;; * Twitter *
;; (load "pi-twit") ;; does not work

;; --------------------------
;; * Fonctions personnelles *
;; Functions définies (utilisables par M-x function <ret>) :
;; xpdf : voir le .pdf associé au buffer avec xpdf.
;; acro : voir le .pdf associé au buffer avec acrobatreader.
;; gv   : voir le .pdf associé au buffer avec gv.
;; separe : insère une une ligne de séparation 8<------8<---etc...
;; moy-insert-set-key : insère le code pour définir un raccourci global.
;; pi-last-modified: ajoute la date courante (bindé sur f11)
;; pi-increment-number-line : copie n lignes et incrémente les nombres trouvés
;;                            usage C-u n M-x pi-increment-number-line
;; pi-increment-number-decimal : incrémente le nombre sous le curseur de n (1 par défaut, sans C-u)
;;  C-c + ou C-c - ou C-u n C-c + etc…
(require 'pi-functions)

;; ----------------------------------------
;; * Je veux les raccourcis clavier de PI *
;; Raccourcis (re)définis:
;; Redéfini C-k pour que le résultat soit parfait en fin de ligne (voir C-h k C-k)
;; C-z        : bascule plein écran
;; F8         : affiche le nom du fichier courant
;; C-u F8     : insère le nom du fichier courant dans le buffer
;; S-f8       : affiche le nom du fichier courant et le place dans le kill ring
;; C-next et C-prior : pour remplacer C-x o et C-u C-x o trop long pour moi ;-)
;;;pour ceux qui ne connaisent pas ça permet de parcourir les frames dans le sens désiré:
;;;essayer C-x 3 C-x 2 puis c-next 3 fois c-prior 3 fois. Terminer par C-x 1
;; S-TAB      : complète un nom de fichier directement depuis le buffer courant, très utile !
;;;essayer ~/ema et S-TAB juste après le 'a'
;; C-x b      : visite le lien sous le curseur avec votre navigateur préféré.
;; F12        : ferme le fichier courant ET la fenêtre (10 fois plus pratique rapide que C-x k C-x 0)
;; C-S-TAB    : indente proprement TOUT le buffer sans changer la place du curseur et en respectant
;;;les balises <pre></pre> du html !
;; M-up ou M-down : transpose la ligne avec la précédente/suivante.
;; C-x c-r    : permet d'ouvrir un fichier en tant que root.
;; redéfini la touche 'home' pour qu'elle fonctionne comme tout le monde voudrait qu'elle le fasse ;-)
;; M-q        : reformate le paragraphe ou la région
;; C-%        : commente ou décommente la ligne courante ou la région et indente le code
;; C-;        : idem mais n'indente pas, utile en mode fondamental
;; C-* et C-µ : pour insérer les commentaires spéciaux section (en jaune) et sous-section (en blanc)
;;;dans du code Elisp
;; F9         : cherche récursivement un makefile dans les répertoires supérieurs
;;;en partant du répertoire courant
;; Scroll_Lock ou Num-Défil : bascule en défilement de la page et mode normal.
;; C-$ |  C-" | C-{  | C-( : dans certain mode $, {, (, [ exécutent `skeleton-pair-insert-maybe'
;;;précédé de 'Control', cette fonctionnalité est ignorée.
;; C-:        : redo (undo c'est C-/ par défaut)
;; Redéfini les guillemets « et » pour ajouter les espaces insécables.
;; f10        : bascule inverse-video la colonne courante
;; C-<        : pour revenir à la position précédente
;; C->        : pour revenir à la position suivante
;; C-x up | C-x down | C-x right | C-x left pour redimensionner les fenêtres
;;;essayer C-x 3 C-x 2 puis C-x une_flèche. S'amuser alors avec les flèches seules ; space pour finir
;; C-' insère l'apostrophe en utf8 : ’
;; F11        : met à jour l'information de dernière modification si elle existe
;;;précédé de C-u, insère la date de dernière modification au tout début du fichier
;; S-F4       : démarre l'enregistrement d'une macro
;; F4         : termine l'enregistrement d'une macro s'il y en a une en cours d'enregistrement,
;;;sinon exécute la dernier macro enregistrée
;;;Exemple : ouvrir un fichier contenant du texte, se placer au début, presser S-F4,
;;;descendre de 3 lignes, presser la touche « entrée », presser F4. La macro est enregistrée,
;;;represser F4 pour exécuter cette macro.
(load "pi-keys")

;; --------------
;; * Organiseur *
(load "pi-org")

(when (locate-library "auctex")
  ;; ---------
  ;; * LaTeX *
  ;; Raccourcis (re)définis:
  (load "pi-tex")

  ;; ------------
  ;; * Metapost *
  (load "pi-meta")
  )

;; ---------------------------------------------
;; * Abbreviations et complétion avec tempo.el *
;; La complétion avec tempo est utile mais sera, à plus ou moins
;; long terme, remplacée par yasnippet (voir ci-après)
;; Raccourcis définis:
;; S-f4   : Démarre la définition d'une macro
;; f4     : Termine la définition de marco en cours sinon execute la dernière macro.
;; C-f4   : Édite la dernière macro
;; f7     : Bascule du mode abbrev-mode

;; f3      : complète le symbole tempo avant le curseur
;; M-left  : revient à la marque précédente
;; M-right : va à la marque suivante
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Voir dans le fichier pi-abbrev&tempo.el comment enregistrer une macro.
;; Voir dans le fichier pi-abbrev&tempo.el comment définir et enregistrer des abréviations.
(load "pi-abbrev&tempo")

;; ----------------------
;; * Complétion avancée *
;; Deux modes de completion automatique : auto-complete et company
;; Raccourcis définis:
;; F1   : bascule auto-complete : http://www.emacswiki.org/emacs/AutoComplete
;; S-F1 : bascule company-mode  : http://nschum.de/src/emacs/company-mode/
(load "pi-complete")

;; ---------
;; * gtags *
;; Pour les programmeurs qui connaissent etag (sinon désactiver)
;; Voir la documentation ici: http://www.gnu.org/software/global/globaldoc.html
;; Raccourcis définis:
;; M-.   : finds tag
;; C-M-. : find all references of tag
;; C-M-, : find all usages of symbol.
;; M-;   : cycles to next result, after doing M-. C-M-. or C-M-,
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dans une fenêtre de sélection de tag:
;; RET      : sélectionne le tag et ferme la fenêtre de sélection
;; C-return : sélectionne le tag et garde la fenêtre de sélection
(load "pi-gtags")

;; -----------------
;; * php et nxhtml *
;; Pour les programmeurs PHP ou éditeurs de html
(load "pi-php")

;; ----------
;; * python *
;; Pour programmer en Python
(load "pi-python")

;; ---------
;; * CEDET *
;; Pour de la programmation avancée
;; Doit être chargé AVANT ECB !
(load "pi-cedet")

;; -------
;; * ECB *
;; Pour naviguer dans le code
(load "pi-ecb")

;; -------
;; * jde *
;; Pour programmer en Java
;; (load "pi-jde")

;; --------------------------------
;; * Pour déboguer des programmes *
(load "pi-geben") ;; Voir la doc dans le fichier pi-geben.el

;; ----------
;; * Jabber *
(load "pi-jabber")

;; --------------
;; * TypoScript *
;; (load "pi-typoscript.el")

;; ------------------------
;; * Programmation en LUA *
;; (load "pi-lua")

;; ----------------------------
;; * Programmation en haskell *
;; (load "pi-haskell") ; pas de haskell en ce moment...

;; --------------------------------
;; * Muse pour du texte vers html *
(load "pi-muse")

;; ---------------------------
;; * Chiffrement des buffers *
;; Utilise crypt++ pour emacs <=22 et epa pour Emacs >22
;; Pour epa il faut une clef http://emacs.wordpress.com/2008/07/18/keeping-your-secrets-secret/
;; Les fichiers aynt pour extension .gpg seront CHIFFRÉS !!
;; TRÈS utile pour conserver les mots de passe et autre...
(load "pi-crypt")

;; -----------------------
;; * Editeur de tableaux *
;; M-x table-insert pour créer un tableau
;; M-x table-generate-source pour l'exporter en LaTeX, html...
;; M-x ltxtab-format pour formater un tableau en LaTeX
;; (load "pi-table")

;; -----------------------------------------------------
;; * Completion and cycling of completion candidates.  *
;; Plus d'info: http://www.emacswiki.org/cgi-bin/wiki/Icicles
;; Icicle est utile mais un peu trop envahissant pour l'activer par défaut
;; icicles doit être appelé le plus tard possible
;; comme j'utilise "desktop-save" j'ai choisi la méthode suivante:
;; (load "pi-icicle") ;; un peu trop envahissent à mon goût...

;; ---------------------------------
;; * Le Menu depuis le clavier svp *
;; <ESC> M-x. On vous demande le nom du menu à executer; commencer à taper son nom...
(load "pi-lacarte")

;; ---------------------
;; * Configuration FTP *
;; À configurer suivant vos serveur
;; ¡l y a en particulier les serveurs qui demandent un mode passif !!
(load "pi-ftp")

;; --------
;; * yaml *
;; Pour éditer des fichier yml (sinon à virer sans crainte)
(load "pi-yaml")

;; --------
;; * sass *
;; Pour éditer des fichier sass (sinon à virer sans crainte)
;; http://sass-lang.com/ et le css devient merveilleux
;; (load "pi-sass")

;; ----------------------------------
;; * dired: explorateur de fichiers *
;; un peu difficile à prendre en mains mais aucun explorateur de
;; fichier ne lui arrive à la cheville.
;; Voir dans le fichier pour plus d'information
(load "pi-dired")

;; -------------------------------
;; * Calculs formels avec Maxima *
;; (load "pi-maxima")

;; --------------------------------------------
;; * Calculs numériques complexes avec Scilab *
;; (load "pi-scilab")

;; ---------------------------------------------
;; * Calculs numériques complexes avec Pari/gp *
;; (load "pi-pari-gp")

;; ---------------------------------
;; * Image de synthèse avec PovRay *
;; (load "pi-povray")

;; -------------------------
;; * Bongo : lecteur audio *
;; Pour écouter la musique depuis Emacs
;; sinon, virer sans crainte
(load "pi-bongo")

;; ------------------------
;; * Emms : lecteur audio *
;; Pas réussi à m'y faire…
;; (load "pi-emms")

;; ------------------------------------
;; * Visible, buffer local, bookmarks *
;; Description:
;;   bm.el provides visible, buffer local, bookmarks and the ability
;;   to jump forward and backward to the next bookmark.
;;   More informations in bm.el.
;; Raccourcis définis:
;;; f2   : Va à la marque suivante
;;; C-f2 : Pose/supprime une marque
;;; S-f2 : Bascule rend/annule les marques persistance d'une session à l'autre
(load "pi-bm.el")

;; ----------------------------------------
;; * Correction orthographique à la volée *
;; Flyspell http://kaolin.unice.fr/~serrano
;; Raccourcis définis:
;;; f6 bascule français/américain
;;; M-$ pour vérifier le mot sous le curseur
(defvar pi-flyspell-prog-mode-alist
  '(emacs-lisp-mode-hook c-mode-hook asy-mode-hook html-mode-hook)
  "Liste des hooks *de programmation* pour lesquels je veux la correction auto
des commentaires")
(defvar pi-flyspell-mode-alist
  '(text-mode-hook org-mode-hook jabber-chat-mode-hook)
  "Liste des hooks pour lesquels je veux la correction auto")
(load "pi-flyspell")

;; -------------------
;; * scroll-in-place *
;; scroll-in-place is a package that keeps the cursor on the same line
;; (and in the same column) when scrolling by a page using PgUp/PgDn.
;; Raccourcis définis:
;; C-up et C-down pour défiler le texte sans changer la position du curseur.
;; C-M-up et C-M-down pour défiler la page.
(load "pi-scroll")

;; ------------------------------------------------
;; * Permutation aléatoire de lettres ds un texte *
;; Auteur: http://christophe.deleuze.free.fr/emacs.html
;; Sélectionner un texte et M-x scramble-region <RET>
;; C'est rigolo :-)
;; (load "pi-scramble")

;; -----------------------------------------
;; * Conversion d'expressions parenthésées *
;; Par exemple, sélectionner la ligne:
;; (a + b * (c + d* (e + f))) - a * (c + d (e + f))
;; M-x pi-exp-paren-region <RET> produit:
;; \Big(a + b * \big(c + d* (e + f)\big)\Big) - a * \big(c + d (e + f)\big)
;; Pour redéfinir des tags:
;; (setq pi-mm-paren-list '("" "\\big" "\\Big" "\\bigg" "\\Bigg"))
;; (load "pi-exp-paren")

;; ------------------------------------
;; * Insertion automatique de modèles *
;; Les modèles sont dans le répertoire ~/emacs.d/site-lisp/template/
;; tout ce qui se trouve entre les paires !§! est interprété par Emacs comme du
;; du code Elisp.
;; Le tag spécial !§!-!§! est la place du curseur une fois le modèle inséré.
;; Il est possible d'avoir plusieurs modèles pour un mode donné ; les modèles sont définis
;; par leurs extensions (les .el pour du lisp, les .html pour du html etc) sauf le makefile
;; qui est le modèle pour les makefile
(load "pi-template-conf")

;; --------------------------------------------------
;; * Asymptote pour créer des figures scientifiques *
;; Pour Asymptote : http://asymptote.sourceforge.net/
;; Raccourcis définis:
;; f1 : si etags est disponible permet de créer les fichier TAGS pour Asymptote
;; C-c C-p : pour forcer la visualisation en pdf
;; C-c C-a : pour faire une animation en beamer des figure présente dans le code
;;;(me contacter pour avoir le script...) pas très utile ceci dit !
(load "pi-asy")

;; ----------------------------
;; * BBDB le carnet d'adresse *
(load "pi-bbdb")

;; ----------------------------
;; * Pour coder en Javascript *
(load "pi-js")

;; -------------------------------
;; * Les indispensables snippets *
;; http://code.google.com/p/yasnippet/
(load "pi-snippets")

;; ------------------------------------------------
;; * Je ne veux pas que Emacs modifie mon .emacs! *
(setq custom-file (cuid "etc/pi-customize.el"))
(load custom-file)

;; (setq minibuffer-max-depth nil)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)


(load (cuid "user-post-init"))
;; Local variables:
;; coding: utf-8
;; End:

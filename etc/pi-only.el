;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; $Last Modified on 2014/05/28 11:37:14

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

;; Generer une string aléatoire (random string generator)
(when (require 'randgen "randgen.el" t)
  (defun pi-randgen nil
    "Génère une chaîne aléatoire de longueur 15 en minuscule"
    (interactive)
    (insert (make-password 15 nil)))
  (defun pi-code nil
    (interactive)
    (let ((R (make-password 15 nil)))
      (insert (concat
               "<div>
<form class=\"inline\" action=\"<?=bloginfo('url');?>/files/\">
<input type=\"button\" class=\"hsa\" name=\"hsa" R "\" value=\"Hide All Codes\" />
<input type=\"button\" class=\"hst\" id=\"btn" R "\" name=\"" R "\" value=\"Hide Code\" />
<input type=\"submit\" class=\"abtn\" value=\"Download\" />
</form>
</div>
<div class=\"code unknown\">
  <pre id=\"pre" R "\">
[include file=]
</pre>
</div>")))))


;; ----------------------------------------
;; * Insertion de code html dans des .asy *
;;  en vue d'être mouliné par asy-verbatin-new.sh
;;;###autoload
(defun pi-asy-url()
  (interactive)
  (insert "/*html
Texte....:
<a href=\"url.tml\">TEXTE</a>
html*/
"))

(defun pi-identity()
  (interactive)
  (insert "Philippe Ivaldi http://www.piprime.fr/"))
(global-set-key (kbd "S-<f11>") 'pi-identity)

;; --------------------------
;; * Lecture des mails/news *
(global-set-key (kbd "<f5>") 'pi-gnus-demon-handler)
(global-set-key (kbd "<C-f5>") 'gnus-group-get-new-news)

;; M'évite de lever la main pour aller en début/fin de ligne:
(global-set-key [(control meta prior)] 'pi-home)
(global-set-key [(control meta next)] 'end-of-line-nomark)


(eval-after-load "asy-mode"
  '(progn
  (tempo-define-template "tempo-abbrev-asy-table-syr"
                         '("/*<asyxml>syracuse</asyxml>*/"> %)
                         "syr")
  (tempo-define-template "tempo-abbrev-asy-table-bfun"
                         '("/*<asyxml><function type=\""p"\" signature=\""p"\"><code></asyxml>*/"> %)
                         "bfun")

  (tempo-define-template "tempo-abbrev-asy-table-efun"
                         '("/*<asyxml></code><documentation>"p"</documentation></function></asyxml>*/"> %)
                         "efun")

  (tempo-define-template "tempo-abbrev-asy-table-bdef"
                         '("/*<asyxml><typedef type=\""p"\" return=\""p"\" params=\""p"\"><code></asyxml>*/"> %)
                         "bdef")

  (tempo-define-template "tempo-abbrev-asy-table-edef"
                         '("/*<asyxml></code><documentation>"p"</documentation></typedef></asyxml>*/"> %)
                         "edef")

  (tempo-define-template "tempo-abbrev-asy-table-bope"
                         '("/*<asyxml><operator type=\""p"\" signature=\""p"\"><code></asyxml>*/"> %)
                         "bope")

  (tempo-define-template "tempo-abbrev-asy-table-eope"
                         '("/*<asyxml></code><documentation>"p"</documentation></operator></asyxml>*/"> %)
                         "eope")

  (tempo-define-template "tempo-abbrev-asy-table-bstr"
                         '("/*<asyxml><struct signature=\""p"\"><code></asyxml>*/"> %)
                         "bstr")

  (tempo-define-template "tempo-abbrev-asy-table-doc"
                         '("/*<asyxml></code><documentation>"p"</documentation></asyxml>*/"> %)
                         "doc")

  (tempo-define-template "tempo-abbrev-asy-table-estr"
                         '("/*<asyxml></struct></asyxml>*/"> %)
                         "estr")

  (tempo-define-template "tempo-abbrev-asy-table-bvar"
                         '("/*<asyxml><variable type=\""p"\" signature=\""p"\"><code></asyxml>*/"> %)
                         "bvar")

  (tempo-define-template "tempo-abbrev-asy-table-evar"
                         '("/*<asyxml></code><documentation>"p"</documentation></variable></asyxml>*/"> %)
                         "evar")

  (tempo-define-template "tempo-abbrev-asy-table-bcon"
                         '("/*<asyxml><constant type=\""p"\" signature=\""p"\"><code></asyxml>*/"> %)
                         "bcon")

  (tempo-define-template "tempo-abbrev-asy-table-econ"
                         '("/*<asyxml></code><documentation>"p"</documentation></constant></asyxml>*/"> %)
                         "econ")

  (tempo-define-template "tempo-abbrev-asy-table-bpro"
                         '("/*<asyxml><property type=\""p"\" signature=\""p"\"><code></asyxml>*/"> %)
                         "bpro")

  (tempo-define-template "tempo-abbrev-asy-table-pro"
                         '("<property type=\""p"\" signature=\""p"\"><code>")
                         "pro")

  (tempo-define-template "tempo-abbrev-asy-table-epro"
                         '("/*<asyxml></code><documentation>"p"</documentation></property></asyxml>*/"> %)
                         "epro")

  (tempo-define-template "tempo-abbrev-asy-table-bmet"
                         '("/*<asyxml><method type=\""p"\" signature=\""p"\"><code></asyxml>*/"> %)
                         "bmet")

  (tempo-define-template "tempo-abbrev-asy-table-emet"
                         '("/*<asyxml></code><documentation>"p"</documentation></method></asyxml>*/"> %)
                         "emet")

  (tempo-define-template "tempo-abbrev-asy-table-url"
                         '("<url href=\""p"\"/>")
                         "url")
  (tempo-define-template "tempo-abbrev-asy-table-xml"
                         '("/*<asyxml>"p"</asyxml>*/")
                         "xml")
  (tempo-define-template "tempo-abbrev-asy-view-xml"
                         '("/*<asyxml><view file=\""p"\" type=\""p"\" signature=\""p"\"/></asyxml>*/")
                         "vi")

  (defface asy-xml-face
    `((t
       (:foreground "yellow")))
    "Face used to highlighting personal xml code.")
  (font-lock-add-keywords
   'asy-mode
   '(("/\\*\\(asy-xml.*?\\)\\*/" 1 'asy-xml-face prepend)))
  (defvar pi-htmlize-basic-character-table
    (let ((table (make-vector 128 ?\0)))
      (dotimes (i 128)
        (setf (aref table i) (if (and (>= i 32) (<= i 126))
                                 (char-to-string i)
                               (format "&#%d;" i))))
      (setf
       (aref table ?\n) "\n"
       (aref table ?\r) "\r"
       (aref table ?\t) "\t"
       (aref table ?&) "&amp;"
       (aref table ?<) "<"
       (aref table ?>) ">"
       )
      table))

  (setq pi-htmlize-restricted-regexp
        "<asyxml>\\(\\(.\\|\n\\)*?\\)</asyxml>"
        ;; "Balises entre lesquelles le texte ne doit pas être 'htmlizer'."
        )

  (setq pi-htmlize-closed-tag
        (list "documentation" "code" "function" "variable"
              "constant" "struct" "property" "method"
              "operator" "typedef"))

  (setq pi-htmlize-non-closed-tag
        (list "url" "look" "view"))

  (setq pi-htmlize-protect-html-tag-regexp
        "\\(<html>\\(.\\|\n\\)*?</html>\\)"
        ;; "Balises entre lesquelles les caractère < et > ne seront pas modifés."
        )

  (defvar pi-htmlize-temp '())
  (defvar pi-htmlize-indent-all nil)

  (defun pi-htmlize-store-data()
    (when pi-htmlize-indent-all (pi-indent-whole-buffer))
    (beginning-of-buffer)
    (setq pi-htmlize-temp '())
    (while (re-search-forward
            pi-htmlize-restricted-regexp
            (point-max) t)
      (setq pi-htmlize-temp (cons (match-string 1) pi-htmlize-temp))
      (replace-match "@pi-htmlize-restricted@")))

  (add-hook 'htmlize-before-hook 'pi-htmlize-store-data)

  (defun pi-htlmize-restore-text (text)
    (save-excursion
      (with-temp-buffer
        (insert text)
        (let ((temp '()))
          ;; Protection du texte qui ne doit pas être rendu en html
          (while (re-search-backward
                  pi-htmlize-protect-html-tag-regexp
                  0 t)
            (setq temp (cons (match-string 1) temp))
            (replace-match "@pi-htmlize-html-protect@"))

          ;; Protection des balises de type <toto ...>...</toto>
          (dolist (ct  pi-htmlize-closed-tag)
            (beginning-of-buffer)
            (while (re-search-forward
                    (concat "<" ct "\\(\\(.\\|\n\\)*?\\)>")
                    (point-max) t)
              (replace-match (concat "@begin_" ct "\\1@!begin_" ct)))
            (beginning-of-buffer)
            (while (re-search-forward (concat "</" ct ">") (point-max) t)
              (replace-match (concat "@end_" ct))))

          ;; Protection des balises de type <toto .../>
          (dolist (ct  pi-htmlize-non-closed-tag)
            (beginning-of-buffer)
            (while (re-search-forward
                    (concat "<" ct "\\(\\(.\\|\n\\)*?\\)/>")
                    (point-max) t)
              (replace-match (concat "@begin_" ct "\\1@!begin_" ct))))

          ;; Transformation des caractères spéciaux en html
          (let ((bufps (htmlize-protect-string (buffer-string))))
            (erase-buffer)
            (insert bufps))

          ;; restauration des balises du type <toto .../>
          (dolist (ct  pi-htmlize-non-closed-tag)
            (beginning-of-buffer)
            (while (re-search-forward
                    (concat "@begin_" ct "\\(\\(.\\|\n\\)*?\\)@!begin_" ct)
                    (point-max) t)
              (replace-match (concat "<" ct "\\1/>"))))

          ;; restauration des balises du type <toto ...>...</toto>
          (dolist (ct  pi-htmlize-closed-tag)
            (beginning-of-buffer)
            (while (re-search-forward
                    (concat "@begin_" ct "\\(\\(.\\|\n\\)*?\\)@!begin_" ct)
                    (point-max) t)
              (replace-match (concat "<" ct "\\1>")))
            (beginning-of-buffer)
            (while (re-search-forward (concat "@end_" ct) (point-max) t)
              (replace-match (concat "</" ct ">"))))

          ;; Restauration du texte protégé de htmlize
          (beginning-of-buffer)
          (while (re-search-forward
                  "@pi-htmlize-html-protect@"
                  (point-max) t)
            (replace-match "" nil t)
            (princ
             (let ((htmlize-basic-character-table
                    pi-htmlize-basic-character-table))
               (htmlize-protect-string (first temp)))
             (current-buffer))
            (setq temp (cdr temp))))
        (buffer-string))))

  (defun pi-htmlize-restore-data()
    (end-of-buffer)
    (while (re-search-backward
            "@pi-htmlize-restricted@"
            0 t)
      (replace-match "")
      (princ
       (pi-htlmize-restore-text
        (first pi-htmlize-temp)) (current-buffer))
      (setq pi-htmlize-temp (cdr pi-htmlize-temp)))
    (setq pi-htmlize-temp '())
    )

  (add-hook 'htmlize-after-hook 'pi-htmlize-restore-data)))
;; END OF 'Personnal code'

(defun pi-toggle-jabber-alert-muc-wave nil
  (interactive)
  (if jabber-alert-muc-wave
    (progn
      (setq jabber-alert-muc-wave nil)
      (message "jabber-alert-muc-wave OFF"))
    (progn
      (setq jabber-alert-muc-wave "/home/pi/Documents/mes_sons/chat/kde-im-user-auth.wav")
      (message "jabber-alert-muc-wave ON"))))

(global-set-key (kbd "<C-f11>") 'pi-toggle-jabber-alert-muc-wave)

(global-set-key (kbd "<menu>") 'nil)
(global-set-key (kbd "<Scroll_Lock>") 'nil)

(setq sql-sqlite-program "sqlite3")
;; Local variables:
;; coding: utf-8
;; End:

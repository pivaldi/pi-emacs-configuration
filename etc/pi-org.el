;; Copyright (c) 2011, Philippe Ivaldi <www.piprime.fr>
;; $Last Modified on 2011/06/30

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

;;Org-mode
(when (and (require 'remember nil t)
           (require 'org-install nil t))
  (org-remember-insinuate)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)

  (setq org-log-done t)
  (setq org-agenda-custom-commands
        '(("f" occur-tree "test")
          ("w" todo "WAITING")))

  (autoload 'org-remember-annotation "org")
  (autoload 'org-remember-handler "org")
  (setq org-directory (cuid "org/"))
  (setq org-default-notes-file (concat org-directory "notes.org"))
  (setq remember-annotation-functions '(org-remember-annotation))
  (setq remember-handler-functions '(org-remember-handler))
  (add-hook 'remember-mode-hook 'org-remember-apply-template)

  (setq org-agenda-include-diary t)
  (setq org-agenda-files (concat org-directory "agenda.org"))

  (define-key global-map "\C-cr" 'org-remember)

  ;; Pour la sélection avec SHIFT <http://orgmode.org/manual/Conflicts.html>
  (setq org-support-shift-select 'always)

  ;; Les extensions supplémentaires pour LaTeX
  (setq org-export-latex-packages-alist (quote (("french" "babel"))))

  ;; une ligne vide termine une liste
  (setq org-empty-line-terminates-plain-lists t)

  ;; Pour que ce qui se trouve entre :HIDDEN: et :END: ne soit pas rendu visible
  ;;;lors d'un export.
  (add-to-list 'org-drawers "HIDDEN")

  (defun yas/org-very-safe-expand ()
    (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

  (add-hook 'org-mode-hook
            (lambda ()
              ;; Corrige un bogue avec auto-fill-mode (pas trouvé mieux)
              (setq comment-start nil)

              (define-key org-mode-map (kbd "<C-tab>") 'ido-switch-buffer)
              (define-key org-mode-map "\C-n" 'org-next-link)
              (define-key org-mode-map "\C-p" 'org-previous-link)
              (when (featurep 'yasnippet)
                (define-key org-mode-map [tab] 'yas/expand))
              ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (setq org-export-htmlize-output-type 'css)
  ;; Pour que l'export en html corresponde à ma configuration
  ;; (setq org-export-html-style "
  ;;  <style type=\"text/css\">
  ;;   <!--/*--><![CDATA[/*><!--*/
  ;;      pre  { border: 1pt solid #ccc;background:#042424;color:#eedc82; }
  ;;      body { background:#2f4f4f;color:#eedc82; }
  ;;      a    { color:#ccc; }
  ;;      .title {background:#000;color:#ccc;}
  ;;   /*]]>*/-->
  ;;  </style>")

  ;; Style par défaut.
  (setq org-export-html-style "
     <style type=\"text/css\">
      <!--/*--><![CDATA[/*><!--*/
         p { font-weight: normal; color: gray; }
         pre  { border: 1pt solid #ccc;background:#2f4f4f;color:#eedc82; }
         h1 { color: black; }
        .title { text-align: center; }
        .todo, .timestamp-kwd { color: red; }
        .done { color: green; }
     /*]]>*/-->
     </style>
  ")

  (setq org-export-latex-image-default-option "")

  (setq
   org-export-latex-classes
   (quote (("article" "\\documentclass[11pt]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{hyperref}
\\hypersetup{%
  pdfpagemode=UseNone,
  colorlinks=true,
  bookmarks=true,
  bookmarksopen=true,
  filecolor=blue,
  linkcolor=blue,urlcolor=blue,
  pdfstartview=FitH,
  pdfauthor={Philippe Ivaldi http://www.piprime.fr/},
  pdfcreator={LaTeX}}
\\usepackage[a4paper]{geometry}
\\geometry{a4paper,left=2cm,right=2cm,top=1.5cm,bottom=2.5cm,headsep=0em}
\\usepackage{lmodern}"
            ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}") ("\\paragraph{%s}" . "\\paragraph*{%s}") ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

           ("report" "\\documentclass[11pt]{report}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
           ("book" "\\documentclass[11pt]{book}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{hyperref}" ("\\part{%s}" . "\\part*{%s}") ("\\chapter{%s}" . "\\chapter*{%s}") ("\\section{%s}" . "\\section*{%s}") ("\\subsection{%s}" . "\\subsection*{%s}") ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))))

  )
;; Local variables:
;; coding: utf-8
;; End:

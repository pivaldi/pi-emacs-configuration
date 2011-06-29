;; --------------------------------
;; * Muse pour du texte vers html *
(when (locate-library "muse")
  (require 'muse-html)                  ; style html
  (require 'muse-latex)                 ; style latex
  (require 'muse-texinfo)               ; style texi
  (require 'muse-docbook)               ; style xml, etc.
  (require 'muse-latex2png)
  (require 'muse-project)               ; publication par projets

  (setq muse-mode-auto-p t)
  (modify-coding-system-alist 'file "\\.muse\\'" 'utf-8) ;; j'utilise de l'utf8 pour le html.
  (setq
   ;; muse-latex2png-fg "\"rgb 0.960784313 0.870588235 0.701960784\""
   muse-latex2png-fg "\"rgb 0.19921875 0.19921875 0.19921875\""
   ;; muse-latex2png-bg "\"rgb 0.184313725 0.309803921 0.309803921\""
   ;; muse-latex2png-bg "\"rgb 0.039215686 0.039215686 0.22745098\""

   muse-latex2png-bg "Transparent"
   muse-latex2png-scale-factor 1.25)

  (setq muse-xhtml-markup-strings
        '((image-with-desc . "<table class=\"image\" width=\"100%%\">
  <tr><td align=\"center\"><img src=\"%1%.%2%\" alt=\"%3%\" /></td></tr>
  <tr><td align=\"center\" class=\"image-caption\">%3%</td></tr>
</table>")
          (image           . "<img class=\"vcenter\" src=\"%s.%s\" alt=\"\" />")
          (image-link      . "<a class=\"image-link\" href=\"%s\">
<img src=\"%s.%s\" alt=\"\" /></a>")
          (rule            . "<hr />")
          (fn-sep          . "<hr />\n")
          (line-break      . "<br />")
          (begin-underline . "<span style=\"text-decoration: underline;\">")
          (end-underline   . "</span>")
          (begin-center    . "<p style=\"text-align: center;\">\n")
          (end-center      . "\n</p>")
          (end-verse-line  . "<br />")
          (end-last-stanza-line . "<br />")
          (empty-verse-line . "<br />")))
  ;; paramétrage de l'en-tête.
  (setq muse-latex-header
        "\\documentclass[a4paper]{article}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{lmodern}

\\usepackage{ucs}
\\usepackage{geometry}
% \\geometry{
%   a4paper,%
%   left=2cm,right=2cm,%
%   marginparwidth=0.5cm,%
%   top=1.5cm,bottom=2.5cm,%
%   headsep=1em %-1em
% }
\\usepackage[eurosym,right]{eurofont}
\\usepackage{hyperref}
\\hypersetup{%
  pdfpagemode=UseNone,
  colorlinks=true,
  bookmarks=true,
  bookmarksopen=true,
  filecolor=blue,
  linkcolor=blue,urlcolor=blue,
  pdfstartview=FitH,
  pdfauthor={http://www.piprime.fr},
  pdfcreator={moteur:pdfLaTeX, éditeur:Emacs}}
\\usepackage[pdftex]{graphicx}
\\usepackage[french]{babel}

\\newcommand{\\Euro}[1]{\\text{\\euros{\\ensuremath{#1}}}}

\\def\\museincludegraphics{%
  \\begingroup
  \\catcode`\\|=0
  \\catcode`\\\\=12
  \\catcode`\\#=12
  \\includegraphics[width=0.75\\textwidth]
}

\\begin{document}

\\title{<lisp>(muse-publish-escape-specials-in-string
  (muse-publishing-directive \"title\") 'document)</lisp>}
\\author{<lisp>(muse-publishing-directive \"author\")</lisp>}

\\maketitle

<lisp>(and muse-publish-generate-contents
           (not muse-latex-permit-contents-tag)
           \"\\\\tableofcontents
\\\\newpage\")</lisp>")

  )

;; Local variables:
;; coding: utf-8
;; End:

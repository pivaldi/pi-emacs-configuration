;;: -*- emacs-lisp -*-
;;; pi-tempo-abbrev-meta.el
;;; Author: Philippe Ivaldi
;;; Last modified: Sun Jul  1 01:02:00 CEST 2007

(require 'pi-tempo-abbrev)

;; *======================================================*
;; *............Abbreviations for meta-mode...............*
;; *======================================================*

(eval-after-load "meta-mode"
  '(progn
     (tempo-abbrev-add
      '(metapost-mode-hook) ;; List of modes where the following table will use.
      'tempo-abbrev-meta-table    ;; Table name (* MUST BE UNIQUE *).
      'tempo-abbrev-meta-tagslist ;; Name of the variable where the tag list should be added.
      '(
        ("pre"  ("prologues:=2;
verbatimtex
%&latex
\\documentclass{beamer}
\\usepackage{amsmath,amssymb,amsfonts}
\\usepackage[T1]{fontenc}
\\usepackage{lmodern}
\\begin{document}
etex

beginfig(100);" n>
p > "
endfig;

end"))
        ("beginfig" (& > "beginfig(" p ");" n> p n "endfig;" > %))
        ("vardef" (& > "vardef " p "("p") =" n> p n "enddef;" > %))
        ("def" (& > "def " p "("p") =" n> p n "enddef;" > %))
        ("primarydef" ("primarydef " p "=" n> "begingroup;" n> p n "endgroup;" > n "enddef;" > &))
        ("begingroup" (& > "begingroup" n> p n "endgroup;" > %))
        ("if"  (> "if " p " :" n>
                  p n >
                  > "fi;"> %))
        ("ife"  (> "if " p " :" n> p n> "else:" > n> p n> "fi;" > %))
        ("ifeif"  (> "if " p " :" n> p n "elseif " > p " :" n> p n> "fi;" > %))
        ("for" ("for " p " :" n> p n> "endfor;" > %))
        ("forw" ("for " p " within " p " :" n> p n> "endfor;" > %))
        ("fori"  (& >"for " (p "Variable: ") "=0 upto " p " : " n>
                    p n >
                    > "endfor;"> %))
        ("forid"  (& >"for " (p "Variable: ") "=0 downto " p " : " n>
                    p n >
                    > "endfor;"> %))
        ("forever" ("forever:" n> p n> "exitif " p ";" n> "endfor;" > %))
        ("bc"  ("buildcycle(" p ")"))
        ("sca" ("scaled "))
        ("shi" ("shifted "))
        ("rot" ("rotated "))
        ("wps" ("withpen pencircle scaled "))
        ("wc" ("withcolor "))
        ("ds" ("draw " p " withpen pencircle scaled " p ";"))
        ("dc" ("draw " p " withcolor " p))
        ("dsc" ("draw " p " withpen pencircle scaled " p " withcolor " p ";"))
        ("cp"  ("currentpicture "))
        ("wha" ("whatever "))
        ("intt" ("intersectiontimes "))
        ("intp" ("intersectionpoint "))
        ("cir" ("fullcircle "))
        ("squ" ("unitsquare "))
        ("fill" ("fill " p " withcolor " p))
        ("sub" ("subpath(" p ")"))
        ("len" ("length(" p ")"))
        ("btex" ("btex " p " etex "))
        ;; `Place_here_your_abbreviations_for_meta-mode'
        ))))

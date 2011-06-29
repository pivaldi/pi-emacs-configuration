%%% !§!(file-name-nondirectory (buffer-file-name))!§! --- 

%% Author: !§!pi-template-author!§!
%% Version: $Id: !§!(file-name-nondirectory (buffer-file-name))!§!,v 0.0 !§!(format-time-string "%Y/%m/%d %H:%M:%S")!§! !§!pi-template-author!§! Exp $

%%% Commentary:

%% !§!_!§!

%% Put this file into your TEXINPUTS.  A typical document looks like:
%%   \documentclass[OPTIONS]{!§!(file-name-sans-extension (file-name-nondirectory (buffer-file-name)))!§!}
%%   \begin{document}
%%   !§!_!§!
%%   \end{document}

%% OPTIONS defaults to !§!_!§!

%%% Code:

\NeedsTeXFormat{LaTeX2e}!§!_!§![1995/12/01]
\def\@rcs@ $#1Date: #2 #3$$#4Revision: #5$ {%
   \ProvidesPackage{!§!(file-name-sans-extension (file-name-nondirectory (buffer-file-name)))!§!}[#2 v#5 !§!(read-string "Commentaires: ")!§!]}
\@rcs@ $Date: !§!(format-time-string "%Y/%m/%d %H:%M:%S")!§! $$Revision: 0.0 $

\DeclareOption{!§!_!§!}{%%%
  }

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{!§!_!§!}
\ProcessOptions
\LoadClass[a4paper]{article}


%%%%#############
%%%%  Main code #
%%%%#############

!§!_!§!


\endinput

%%% Local Variables:
%%% TeX-auto-save: nil
%%% TeX-auto-parse-length: 99999
%%% End:

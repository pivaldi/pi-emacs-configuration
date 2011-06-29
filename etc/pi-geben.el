;; --------------------------------
;; * Pour déboguer des programmes *
(when (file-exists-p (cuid "site-lisp/geben/geben.el"))
  ;; M-x geben pour activer.
  ;; Pour php, passer le paramètre ?XDEBUG_SESSION_START=1 pour lancer le débogage
;;;  ?XDEBUG_SESSION_STOP=1 pour arrêter.
  ;; Les raccourcis de geben:
  ;; spc step into/step over
  ;; i   step into
  ;; o   step over
  ;; r   step out
  ;; b   set a breakpoint at a line
  ;; u   unset a breakpoint at a line
  ;; g   run
  ;; e   eval expression (to inspect variables: best is probably print_r($this, true))
  ;; q   stop debugger

  ;; M-x geben-mode-help  pour plus d'info
  ;; et bien sûr http://xdebug.org/docs/ pour la doc de xdebug
  (add-to-list 'load-path (cuid "site-lisp/geben/"))
  (autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t))

;; Local variables:
;; coding: utf-8
;; End:

;; --------------------------------
;; * Pour déboguer des programmes *
;; See https://github.com/pokehanai/geben-on-emacs :

;;   DEBUGGING
;;   ---------

;;   Here is an illustration on PHP debugging.

;;   1. Run Emacs.

;;   2. Start geben, type: M-x geben

;;   3. Access to the target PHP script page with any browser.
;;   You may need to add a query parameter `XDEBUG_SESSION_START' if you
;;   configured Xdebug to require manual trigger to start a remote
;;   debugging session.
;;   e.g.) http://www.example.com/test.php?XDEBUG_SESSION_START=1

;; 4. Soon the server and GEBEN establish a debugging session
;; connection. Then Emacs loads the script source code of the entry
;; page in a buffer.

;; 5. Now the buffer is under the minor-mode 'geben-mode'.
;; You can control the debugger with several keys.

;; spc     step into/step over
;; i       step into
;; o       step over
;; r       step out
;; g       run
;; c       run to cursor
;; b       set a breakpoint at a line
;; B       set a breakpoint interactively
;; u       unset a breakpoint at a line
;; U       clear all breakpoints
;; \C-c b  display breakpoint list
;; >       set redirection mode
;; \C-u t  change redirection mode
;; d       display backtrace
;; t       display backtrace
;; v       display context variables
;; \C-c f  visit script file
;; w       where
;; q       stop

;; When you hit any unbound key of `geben-mode', GEBEN will ask you to
;; edit the original script file. Say yes and GEBEN will attempts to
;; load the script file via `TRAMP'.

;; 6. If you felt you'd debugged enough, it's time to quit GEBEN.
;; To quit GEBEN, type: M-x geben-end

(when (locate-library "geben")
  (autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t))

;; Local variables:
;; coding: utf-8
;; End:

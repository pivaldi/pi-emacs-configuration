(autoload 'twit-show-recent-tweets	"twit" "" t) ; most recent direct tweets (!)
(autoload 'twit-show-at-tweets		"twit" "" t) ; directed to you
(autoload 'twit-show-friends 		"twit" "" t) ; your friends
(autoload 'twit-show-followers 		"twit" "" t) ; your followers

(autoload 'twit-follow-recent-tweets	"twit" "" t) ; at idle, check at background

(autoload 'twit-post			"twit" "" t)
(autoload 'twit-post-region		"twit" "" t)
(autoload 'twit-post-buffer		"twit" "" t)
(autoload 'twit-direct			"twit" "" t) ; tweet to person

(autoload 'twit-add-favorite		"twit" "" t) ; Add to favourite: (*) star
(autoload 'twit-remove-favorite 	"twit" "" t)

(autoload 'twit-add-friend  		"twit" "" t) ; follow a friend
(autoload 'twit-remove-friend 		"twit" "" t) ; emove a frienda

;; Customize twit-multi-accounts in order to use these: ((user . pass) ...)
(autoload 'twit-switch-account 		"twit" "" t)
(autoload 'twit-direct-with-account  	"twit" "" t)
(autoload 'twit-post-with-account 	"twit" "" t)

(autoload 'twit-show-direct-tweets-with-account "twit" "" t)
(autoload 'twit-show-at-tweets-with-account 	"twit" "" t)

;; Key bindings examples
;; Requires that autoloads above have been added to ~/.emacs
(global-set-key "\C-cTT"  'twit-follow-recent-tweets) ; (s)how (T)weets
(global-set-key "\C-cTst" 'twit-follow-recent-tweets) ; (s)how (t)weets
(global-set-key "\C-cTsa" 'twit-show-at-tweets)       ; (s)how (a)t
(global-set-key "\C-cTsf" 'twit-show-at-tweets)       ; (s)how (f)riends
(global-set-key "\C-cTsl" 'twit-show-at-tweets)       ; (s)how fo(l)lowers

(global-set-key "\C-cTpp" 'twit-post)		      ; (p)ost
(global-set-key "\C-cTpr" 'twit-post-region)	      ; (p)post (r)egion
(global-set-key "\C-cTpb" 'twit-post-buffer)	      ; (p)post (b)uffer
(global-set-key "\C-cTpr" 'twit-direct)		      ; (p)post (d)irect
(global-set-key "\C-cTfa" 'twit-add-favorite)	      ; (f)avorite (a)dd
(global-set-key "\C-cTfr" 'twit-remove-favorite)      ; (f)avorite (r)emove

;; --------------------
;; * MA CONFIGURATION *

;; User and Password
;; Avoid this:
;; (setq twit-user "nick")
;; (setq twit-pass "pass")
(when (require 'netrc nil t)
  (let ((twitter (netrc-machine (netrc-parse "~/.netrc") "identi.ca" t)))
    (setq twit-user (netrc-get twitter "login")
	  twit-pass (netrc-get twitter "password")))nil)

(setq twitter-include-replies t)


;; Je ne veux pas de suivi des twit, c'est trop lent...
(setq twit-follow-idle-interval 600000000)

;; Local variables:
;; coding: utf-8
;; End:

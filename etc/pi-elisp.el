(load "pi-tempo-lisp")
(when pi-use-skeleton-pair-insert-maybe
       (define-key emacs-lisp-mode-map "\{" 'skeleton-pair-insert-maybe)
       (define-key emacs-lisp-mode-map "\(" 'skeleton-pair-insert-maybe)
       (define-key emacs-lisp-mode-map "[" 'skeleton-pair-insert-maybe)
       (define-key emacs-lisp-mode-map "\"" 'skeleton-pair-insert-maybe))


;; Local variables:
;; coding: utf-8
;; End:

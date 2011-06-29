;; ------------------------------------
;; * Visible, buffer local, bookmarks *
;; ;; Description:
;; ;;   bm.el provides visible, buffer local, bookmarks and the ability
;; ;;   to jump forward and backward to the next bookmark.
;; ;;   More informations in bm.el.
(require 'bm)
;; Filename to store persistent bookmarks across sessions:
(setq bm-repository-file (cuid ".bm-repository"))
;; To load the repository when bm is loaded:
(setq bm-restore-repository-on-load t)
;; The buffer should be recentered around the bookmark
;; after a `bm-next' or a `bm-previous'.
(setq bm-recenter t)
;; Loading the repository from file when on start up:
(add-hook' after-init-hook 'bm-repository-load)
;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)
;; Saving bookmark data on killing a buffer:
(add-hook 'kill-buffer-hook 'bm-buffer-save)
;; Saving the repository to file when on exit.
;; kill-buffer-hook is not called when emacs is killed, so we
;; must save all bookmarks first:
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))
;; Update bookmark repository when saving the file:
(add-hook 'after-save-hook 'bm-buffer-save)
(global-set-key (kbd "<C-f2>") 'bm-toggle) ;; set/unset bookmark
(global-set-key (kbd "<f2>")   'bm-next)   ;; jump to next bookmark
;; (global-set-key (kbd "<S-f2>") 'bm-previous) ;; jump to previous bookmark
;; Toggle if a buffer has persistent bookmarks or not.
(global-set-key (kbd "<S-f2>") 'bm-toggle-buffer-persistence)

;; Local variables:
;; coding: utf-8
;; End:

;; Copyright (c) 2016, Philippe Ivaldi <www.piprime.fr>
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; THANKS:

;;; BUGS:

;;; INSTALLATION:

;;; Code:

(when (and (require 'helm nil t) (require 'helm-config nil t))
  (require 'helm-config)
  (helm-mode t)
  (helm-adaptive-mode t)

  (global-set-key (kbd "M-x") 'helm-M-x)
  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
  (global-set-key (kbd "C-c h") 'helm-command-prefix)
  (global-unset-key (kbd "C-x c"))

  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  ;; (define-key helm-find-files-map (kbd "<return>") 'helm-execute-persistent-action)

  (when (require 'helm-swoop nil t)
    (global-set-key (kbd "M-i") 'helm-swoop)
    (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
    (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
    (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

    ;; When doing isearch, hand the word over to helm-swoop
    (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
    ;; From helm-swoop to helm-multi-swoop-all
    (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

    ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
    (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

    ;; Move up and down like isearch
    (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
    (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
    (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
    (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)
    )

  (setq helm-ff-transformer-show-only-basename nil
        helm-adaptive-history-file             (user-var-file "helm-history")
        helm-yank-symbol-first                 t
        helm-move-to-line-cycle-in-source      t
        helm-buffers-fuzzy-matching            t
        helm-ff-auto-update-initial-value      t
        helm-dabbrev-related-buffer-fn         nil ;; Can not be set by cutomize because it is not a function
        )

  (autoload 'helm-descbinds      "helm-descbinds" t)
  (autoload 'helm-eshell-history "helm-eshell"    t)
  (autoload 'helm-esh-pcomplete  "helm-eshell"    t)

  (global-set-key (kbd "C-h a")    #'helm-apropos)
  (global-set-key (kbd "C-h i")    #'helm-info-emacs)
  (global-set-key (kbd "C-h b")    #'helm-descbinds)

  (add-hook 'eshell-mode-hook
            #'(lambda ()
                (define-key eshell-mode-map (kbd "TAB")     #'helm-esh-pcomplete)
                (define-key eshell-mode-map (kbd "C-c C-l") #'helm-eshell-history)))

  (global-set-key (kbd "C-x b")   #'helm-mini)
  (global-set-key (kbd "C-<tab>")   #'helm-mini)
  (global-set-key (kbd "C-x C-b") #'helm-buffers-list)
  (global-set-key (kbd "C-x C-m") #'helm-M-x)
  (global-set-key (kbd "C-x f") #'helm-find-files)
  ;; (global-set-key (kbd "C-x C-r") #'helm-recentf)
  (global-set-key (kbd "C-x r l") #'helm-filtered-bookmarks)
  (global-set-key (kbd "M-Y")     #'helm-show-kill-ring)
  (global-set-key (kbd "M-s o")   #'helm-swoop)
  (global-set-key (kbd "M-s /")   #'helm-multi-swoop)
  (define-key global-map [remap jump-to-register]      'helm-register)
  (define-key global-map [remap list-buffers]          'helm-mini)
  ;; (define-key global-map [remap dabbrev-expand]        'helm-dabbrev) ;; does not work properly for programming
  (define-key global-map [remap find-tag]              'helm-etags-select)
  (define-key global-map [remap xref-find-definitions] 'helm-etags-select)

  (global-set-key (kbd "C-x c!")   #'helm-calcul-expression)
  (global-set-key (kbd "C-x c:")   #'helm-eval-expression-with-eldoc)
  (define-key helm-map (kbd "M-o") #'helm-previous-source)

  (when (require 'helm-ag nil t)
    (global-set-key (kbd "M-s s")   #'helm-ag))

  (when (require 'projectile nil t)
    (projectile-global-mode)
    (when (require 'helm-ag nil t)
      (define-key projectile-mode-map (kbd "C-c p /")
        #'(lambda ()
            (interactive)
            (helm-ag (projectile-project-root)))))

    (when (require 'helm-projectile nil t)
      (setq helm-projectile-sources-list (cons 'helm-source-projectile-files-list
                                               (remove 'helm-source-projectile-files-list
                                                       helm-projectile-sources-list)))

      (setq projectile-completion-system 'helm)
      (setq projectile-switch-project-action 'helm-projectile)

      ;; (defalias '_hpsp 'helm-projectile-switch-project)
      ;; (defalias '_hpff 'helm-projectile-find-file)
      ;; (defalias '_hpffikp 'helm-projectile-find-file-in-known-projects)

      (helm-projectile-on)))

  (eval-after-load 'org-mode
    '(progn
       (define-key org-mode-map (kbd "C-x c o h") #'helm-org-headlines)))
  )



(provide 'pi-helm)
;;; pi-helm.el ends here

;; Local variables:
;; coding: utf-8
;; End:

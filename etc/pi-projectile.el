;;; Package --- pimacs projectile configuration
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

;; THANKS:

;; BUGS:

;; INSTALLATION:

;;; Code:


(when (require 'projectile nil t)
  (projectile-global-mode) ;; to enable in all buffers
  (setq projectile-enable-caching t)

  (when (require 'flycheck-projectile nil t) t)

  (when (require 'go-projectile nil t) t)

  (when (require 'ibuffer-projectile nil t) t)

  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

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


(provide 'pi-projectile)
;;; pi-projectile ends here

;; Local variables:
;; coding: utf-8
;; End:

;;; pi-typescript.el --- Tide mode configuration for Typescript language
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

;; Code:

(when (require 'tide nil t)

  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (eldoc-mode +1)
    (flycheck-mode +1))

  ;; ;; aligns annotation to the right hand side
  ;; (setq company-tooltip-align-annotations t)

  ;; formats the buffer before saving
  (add-hook 'before-save-hook 'tide-format-before-save)

  ;; format options
  (setq tide-format-options
        '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil :tabSize 2))
  ;; see https://github.com/Microsoft/TypeScript/blob/cc58e2d7eb144f0b2ff89e6a6685fb4deaa24fde/src/server/protocol.d.ts#L421-473 for the full list available options

  (add-hook 'typescript-mode-hook #'setup-tide-mode)

  ;; Tide uses tsserver as the backend for most of the features. It writes
  ;; out a comprehensive log file which can be captured by setting
  ;; tide-tsserver-process-environment variable.
  ;; (setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))

  (when (require 'web-mode nil t)
    (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
    (add-hook 'web-mode-hook
              (lambda ()
                (when (string-equal "tsx" (file-name-extension buffer-file-name))
                  (setup-tide-mode))))

    ;; enable typescript-tslint checker
    (flycheck-add-mode 'typescript-tslint 'web-mode))
  )


(if (require 'ts-comint nil t)
    (progn
      (if (not (executable-find "tsun"))
          (add-to-list 'pi-error-msgs "Please install tsun : npm -g install tsun"))
      (if (not (executable-find "node"))
          (add-to-list 'pi-error-msgs "Please install nodeJs : https://nodejs.org/en/download/package-manager/"))

      (add-hook 'typescript-mode-hook
                (lambda ()
                  (setq indent-tabs-mode t)
                  (local-set-key (kbd "C-c C-e") 'ts-send-last-sexp-and-go)
                  ;; (local-set-key (kbd "C-c C-c") 'ts-send-buffer-and-go)
                  (local-set-key (kbd "C-c C-l") 'ts-load-file-and-go)))
      )
  (progn
    (defvar pi-ts-compile-command "/usr/bin/ts-node")

    (if (not (executable-find pi-ts-compile-command))
        (add-to-list 'pi-error-msgs "Please install ts-node : npm install -g ts-node"))

    (defun pi-ts-compile ()
      (interactive)
      (compile (concat
                pi-ts-compile-command
                " " (buffer-file-name))))

    (add-hook 'typescript-mode-hook
              (lambda ()
                (local-set-key (kbd "C-c C-c") 'pi-ts-compile)
                ))
    ))

(require 'ng2-mode nil t)

(provide 'pi-typescript)
;;; pi-typescript.el ends here

;; Local variables:
;; coding: utf-8
;; End:

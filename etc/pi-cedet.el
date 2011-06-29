;; ---------------
;; * Load CEDET. *
(when (require 'cedet nil t)
  (setq semantic-load-turn-useful-things-on t)
  ;; See cedet/common/cedet.info for configuration details.

  (require 'semantic)
  ;; Explicitly specify additional paths for look up of include files
  ;; (when (file-readable-p "/usr/local/play/framework/src/")
  ;;   (semantic-add-system-include "/usr/local/play/framework/src/" 'JDE-mode))
  ;; (when (file-readable-p "/usr/local/src/typo3_src-4.3.2/")
  ;;   (semantic-add-system-include "/usr/local/src/typo3_src-4.3.2/" 'php-mode))

  ;; If you  use GCC  for programming  in C &  C++, then  Semantic can
  ;; automatically   find  path,  where   system  include   files  are
  ;; located. To do  this, you need to load  semantic-gcc package with
  ;; following command:

  (when (require 'gtags nil t)
    ;; Enable support for gnu global
    ;; (require 'semanticdb-global)
    (semanticdb-enable-gnu-global-databases 'c-mode)
    (semanticdb-enable-gnu-global-databases 'c++-mode)
    (semanticdb-enable-gnu-global-databases 'php-mode)
    (semanticdb-enable-gnu-global-databases 'JDE-mode))

  (global-ede-mode nil)                    ; Disable the Project management system
  (when (require 'srecode nil t)
    ;; Enable template insertion menu
    (global-srecode-minor-mode 1))
  ;; Enable EDE for a pre-existing C++ project
  ;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")

  ;; Oui mais « Berk le nom de la fonction courante dans la "header line" »
  (global-semantic-stickyfunc-mode -1)
  ;; (semantic-stickyfunc-mode 1) ;; pour activer localement cette fonctionnalité.

  ;; * This enables the use of Exuberent ctags if you have it installed.
  ;;   If you use C++ templates or boost, you should NOT enable it.
  ;; (semantic-load-enable-all-exuberent-ctags-support)

  (defun pi-cedet-hook ()
    (local-set-key (kbd "C- ") 'semantic-ia-complete-symbol)
    (local-set-key (kbd "<C-return>") 'semantic-ia-fast-jump)
    (local-set-key (kbd "<C-S-return>") 'semantic-complete-jump)
    (local-set-key "\C-c?" 'semantic-ia-show-doc)
    (local-set-key "\C-cc" 'semantic-ia-describe-class)
    (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
    (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
    )

  (add-hook 'c-mode-common-hook 'pi-cedet-hook)

  (when (require 'eassist nil t)

    ;;(concat essist-header-switches ("hh" "cc"))
    (defun alexott/c-mode-cedet-hook ()
      (local-set-key "\C-ct" 'eassist-switch-h-cpp)
      (local-set-key "\C-xt" 'eassist-switch-h-cpp)
      (local-set-key "\C-ce" 'eassist-list-methods)
      (local-set-key "\C-c\C-r" 'semantic-symref)
      )
    (add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)
    ))

;; Local variables:
;; coding: utf-8
;; End:

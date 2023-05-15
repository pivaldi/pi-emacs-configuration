;; ------------------------------------------
;; * dired: un vrai explorateur de fichiers *
;; To edit a directory, use ‘C-x d’ (`dired’) or
;; ‘C-x 4 d’ (‘dired-other-window’)
;; or ‘C-x 5 d’ `dired-other-frame')

;; You can run the associated program in dired mode by
;; Control-Return on a specific file or you can run the program
;; directly by M-x run-associated-program
(require 'run-assoc)
(setq associated-program-alist
      '(("gnochm" "\\.chm$")
        ("evince" "\\.pdf$")
        ("mplayer" "\\.mp3$")
        ("libreoffice.org" "\\.ods$")
        ("libreoffice.org" "\\.docx$")
        ("libreoffice.org" "\\.odt$")
        ("inkscape" "\\.svg$")
        ("darktable" "\\.raf\\|\\.RAF$")
        ("nomacs" "\\.png\\|\\.gif\\|\\jpeg\\|\\.JPG\\|\\jpg$")
        ((lambda (file)
           (let ((newfile (concat (file-name-sans-extension
                                   (file-name-nondirectory file)) ".txt")))
             (cond
              ((get-buffer newfile)
               (switch-to-buffer newfile)
               (message "Buffer with name %s exists, switching to it" newfile))
              ((file-exists-p newfile)
               (find-file newfile)
               (message "File %s exists, opening" newfile))
              (t (find-file newfile)
                 (= 0 (call-process "antiword" file
                                    newfile t "-")))))) "\\.doc$")
        ("gv" "\\.ps$")
        ("fontforge" "\\.\\(sfd\\(ir\\)?\\|ttf\\|otf\\)$")
        ((lambda (file)
           (browse-url (concat "file:///"
                               (expand-file-name file))))
         "\\.html?$")))


;;  This file extends functionalities provided by standard GNU Emacs
;;  files `dired.el', `dired-aux.el', and `dired-x.el'.
;;  Most of the commands (such as `C' and `M-g') that operate on
;;  marked files have the added feature here that multiple `C-u' use
;;  not the files that are marked or the next or previous N files,
;;  but *all* of the files in the Dired buffer.  Just what "all"
;;  files means changes with the number of `C-u', as follows:
;;
;;  `C-u C-u'         - Use all files present, but no directories.
;;  `C-u C-u C-u'     - Use all files and dirs except `.' and `..'.
;;  `C-u C-u C-u C-u' - use all files and dirs, `.' and `..'.
;;
;;  (More than four `C-u' act the same as two.)
(require 'dired+)
;;  Faces defined here:
;;    `diredp-compressed-file-suffix', `diredp-date-time',
;;    `diredp-deletion', `diredp-deletion-file-name',
;;    `diredp-dir-heading', `diredp-dir-priv', `diredp-display-msg',
;;    `diredp-exec-priv', `diredp-executable-tag', `diredp-file-name',
;;    `diredp-file-suffix', `diredp-flag-mark',
;;    `diredp-flag-mark-line', `diredp-get-file-or-dir-name',
;;    `diredp-ignored-file-name', `diredp-link-priv',
;;    `diredp-no-priv', `diredp-other-priv', `diredp-rare-priv',
;;    `diredp-read-priv', `diredp-symlink', `diredp-write-priv'.
;; Ne pas oublier: M-x toggle-dired-find-file-reuse-dir
;; pour naviguer dans le même buffer.

(require 'dired-sort-menu+)
;; sorting by pressing ‘s’ then ‘s’, ‘x’, ‘t’ or ‘n’
;; to sort by Size, eXtension, Time or Name.
(require 'dired-sort-map)
(require 'dired-details+)
;; Library Lisp:dired-isearch.el lets you isearch
;; in DiredMode matching only file names.
(require 'dired-isearch)

;; copy/rename/move asynchronously in dired by
;; installing the async package.
(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

;; Not dired-specific per-se, but quick-preview is great for files that
;; Emacs might not be able to open, but your regular X11 can
;; show well, like moves are things. Works great when you're in a dired
;; buffer to preview a file.
(require 'quick-preview)
(setq quick-preview-method 'sushi)
;;Setting for key bindings
(global-set-key (kbd "C-c q") 'quick-preview-at-point)
(define-key dired-mode-map (kbd "Q") 'quick-preview-at-point)

;;  The  'dired-single package  provides a  way to  reuse  the current
;;  dired buffer  to visit another  directory (rather than  creating a
;;  new buffer for the new directory).  Optionally, it allows the user
;;  to specify a  name that all such buffers  will have, regardless of
;;  the directory they point to.
;; (require 'dired-single)
;; (defun pi-dired-up-directory-single-buffer ()
;;   (interactive) (dired-single-buffer ".."))

;;;###autoload
(defun ora-dired-rsync (dest)
  "Lets you copy huge files and directories without Emacs freezing up and
with convenient progress bar updates.
src : http://oremacs.com/2016/02/24/dired-rsync/"
  (interactive
   (list
    (expand-file-name
     (read-file-name
      "Rsync to:"
      (dired-dwim-target-directory)))))
  ;; store all selected files into "files" list
  (let ((files (dired-get-marked-files
                nil current-prefix-arg))
        ;; the rsync command
        (tmtxt/rsync-command
         "rsync -arvz --progress "))
    ;; add all selected file names as arguments
    ;; to the rsync command
    (dolist (file files)
      (setq tmtxt/rsync-command
            (concat tmtxt/rsync-command
                    (shell-quote-argument file)
                    " ")))
    ;; append the destination
    (setq tmtxt/rsync-command
          (concat tmtxt/rsync-command
                  (shell-quote-argument dest)))
    ;; run the async shell command
    (async-shell-command tmtxt/rsync-command "*rsync*")
    ;; finally, switch to that window
    (other-window 1)))

(define-key dired-mode-map "Y" 'ora-dired-rsync)

;;;###autoload
(defun pi-dired-rename ()
  "Use multiple renaming if multiple files are marked.
Otherwise, use a buffer in which all the names of files are editable."
  (interactive)
  (if (nth 1 (save-excursion
               (dired-map-over-marks
                (dired-get-filename nil t)
                nil nil t)))
      (dired-do-rename) ;; au moins un fichier marqué.
    (wdired-change-to-wdired-mode)))



(defun pi-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when it's
        loaded."
  (interactive)
  ;; <add other stuff here>
  (define-key dired-mode-map (kbd "C-s") 'dired-isearch-forward)
  (define-key dired-mode-map (kbd "C-r") 'dired-isearch-backward)
  (define-key dired-mode-map (kbd "M-C-s") 'dired-isearch-forward-regexp)
  (define-key dired-mode-map (kbd "M-C-r") 'dired-isearch-backward-regexp)
  ;; (define-key dired-mode-map (kbd "RET") 'dired-single-buffer)
  (define-key dired-mode-map (kbd "C-RET") 'dired-find-file)
  (define-key dired-mode-map (kbd "M-RET") 'dired-find-file-other-window)
  ;; (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
  (define-key dired-mode-map (kbd "<M-up>") 'dired-up-directory)
  (define-key dired-mode-map (kbd "<M-left>") 'dired-up-directory)
  (define-key dired-mode-map (kbd "<M-r>") 'toggle-dired-find-file-reuse-dir)
  (define-key dired-mode-map (kbd "R") 'pi-dired-rename) ;; Pas mieux pour renommer !
  (when (featurep 'traverselisp)
    (define-key dired-mode-map (kbd "C-c C-z")
      'traverse-dired-browse-archive)
    (define-key dired-mode-map (kbd "C-c f")
      'traverse-dired-find-in-all-files))
  ;; (define-key dired-mode-map (kbd "SPC") 'dired-toggle-marks)
  ;; (define-key dired-mode-map "^" 'pi-dired-up-directory-single-buffer)
  )

(eval-after-load 'dired '(pi-dired-init))

;; Local variables:
;; coding: utf-8
;; End:

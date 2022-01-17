;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Remove security vulnerability
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path settings-dir)
(add-to-list 'load-path site-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(require 'setup-packages)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Write all autosave files in the tmp dir
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Don't write lock-files, I'm the only one here
(setq create-lockfiles nil)

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

(defun init--install-packages ()
  (packages-install
   '(cider
     clj-refactor
     clojure-mode
     clojure-mode-extra-font-locking
     exec-path-from-shell
     ido-at-point
     ido-completing-read+
     ido-vertical-mode
     magit
     paredit
     projectile
     smex
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(when is-mac
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;; setup extensions
(eval-after-load 'ido '(require 'setup-ido))
(eval-after-load 'dired '(require 'setup-dired))

(require 'setup-projectile)
(require 'setup-hippie)
(require 'setup-paredit)

;; language specific setup files
(eval-after-load 'clojure-mode '(require 'setup-clojure-mode))

;; load stuff on demand
(autoload 'auto-complete-mode "auto-complete" nil t)

;; setup smart m-x
(require 'smex)
(smex-initialize)

;; setup files to modes
(require 'mode-mappings)

;; setup key bindings
(require 'key-bindings)


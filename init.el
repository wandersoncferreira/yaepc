;; Remove security vulnerability
(eval-after-load "enriched"
  '(defun enriched-decode-display-prop (start end &optional param)
     (list start end)))

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
(require 'appearance)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

(defun init--install-packages ()
  (packages-install
   '(cider
     clj-refactor
     clojure-mode
     clojure-mode-extra-font-locking
     corfu
     diminish
     exec-path-from-shell
     magit
     orderless
     paredit
     projectile
     vertico
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Lets start with a smattering of sanity
(require 'sane-defaults)

(when is-mac
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;; setup extensions
(eval-after-load 'dired '(require 'setup-dired))

(require 'setup-vertico)
(require 'setup-corfu)
(require 'setup-consult)
(require 'setup-encryption)
(require 'setup-projectile)
(require 'setup-hippie)
(require 'setup-paredit)

;; language specific setup files
(eval-after-load 'clojure-mode '(require 'setup-clojure-mode))

;; load stuff on demand
(autoload 'auto-complete-mode "auto-complete" nil t)

;; setup files to modes
(require 'mode-mappings)

;; setup key bindings
(require 'key-bindings)

;; setup work specific files
(add-hook 'after-init-hook
          (lambda ()
            (load-file "~/.emacs.d/settings/work-cisco.el.gpg")
            (require 'work-cisco)))

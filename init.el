;;; Here be dragons!

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

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

(defun init--install-packages ()
  (packages-install
   '(browse-at-remote
     change-inner
     cider
     clj-refactor
     clojure-mode
     clojure-mode-extra-font-locking
     clojure-snippets
     diff-hl
     diminish
     elfeed
     exec-path-from-shell
     expand-region
     find-file-in-project
     fix-word
     flx-ido
     git-timemachine
     jump-char
     ido-at-point
     ido-completing-read+
     ido-vertical-mode
     magit
     paredit
     perspective
     projectile
     smex
     yasnippet
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; changing the looks!
(require 'appearance)

;; Lets start with a smattering of sanity
(require 'sane-defaults)

(when is-mac
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

;; setup extensions
(require 'setup-dired)
(require 'setup-ido)
(require 'setup-snippets)
(require 'setup-vc)
(require 'setup-smex)
(require 'setup-org)
(require 'setup-rss)

(require 'setup-encryption)
(require 'setup-projectile)
(require 'setup-perspective)
(require 'setup-paredit)
(require 'setup-search)

(require 'expand-region)
(require 'change-inner)
(require 'jump-char)

;; language specific setup files
(eval-after-load 'clojure-mode '(require 'setup-clojure-mode))

;; setup files to modes
(require 'mode-mappings)

;; setup key bindings
(require 'key-bindings)

;; setup work specific files
(add-hook 'after-init-hook
          (lambda ()
            (load-file "~/.emacs.d/settings/work-cisco.el.gpg")
            (require 'work-cisco)))

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

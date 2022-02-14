;;; Here be dragons!

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq extra-dir
      (expand-file-name "extras" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path extra-dir)
(add-to-list 'load-path site-lisp-dir)

(require 'extra-packages)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

(defun init--install-packages ()
  (packages-install
   '(browse-at-remote
     change-inner
     cider
     clj-refactor
     clojure-mode
     clojure-snippets
     diff-hl
     diminish
     elfeed
     easy-kill
     exec-path-from-shell
     expand-region
     find-file-in-project
     fix-word
     flx-ido
     git-timemachine
     ido-at-point
     ido-completing-read+
     ido-vertical-mode
     imenu-anywhere
     jump-char
     lsp-java
     lsp-mode
     magit
     markdown-mode
     org-roam
     ox-hugo
     paredit
     perspective
     projectile
     shrink-whitespace
     smex
     wgrep
     yasnippet
     yasnippet-snippets
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(dolist (file '(extra-appearance
                extra-sane-defaults
                extra-dired
                extra-completion
                extra-hippie-expand
                extra-snippets
                extra-vc
                extra-org
                extra-rss
                extra-spell
                extra-encryption
                extra-projects
                extra-paredit
                extra-buffer
                extra-mode-mappings
                extra-key-bindings
                extra-clojure-mode
                extra-java
                extra-eshell))
  (require file))

(defun bk/activate--code-review ()
  (interactive)
  (require 'code-review))

;; setup work specific files
(add-hook 'after-init-hook
          (lambda ()
            (load-file (expand-file-name "work-cisco.el.gpg" extra-dir))
            (require 'work-cisco)))

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;; activate server
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))

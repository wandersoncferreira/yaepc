(require 'clojure-mode)
(require 'clojure-mode-extra-font-locking)

(require 'clj-refactor)
(setq cljr-clojure-test-declaration "[clojure.test :refer [deftest is testing]]"
      cljr-cljs-clojure-test-declaration cljr-clojure-test-declaration
      cljr-cljc-clojure-test-declaration cljr-clojure-test-declaration)

(cljr-add-keybindings-with-prefix "C-c C-m")

(require 'cider)

;; Hide nrepl buffers when switching buffers (switch to by prefixing with space)
(setq nrepl-hide-special-buffers t)

(defun bk/clojure--reset ()
  (interactive)
  (cider-nrepl-request:eval
   "(reset)"
   (lambda (&rest res))
   "user"))

;;; enable clojure
(defun bk/enable-clojure-extensions ()
  (clj-refactor-mode 1)
  (aggressive-indent-mode 1))

(add-hook 'clojure-mode-hook 'bk/enable-clojure-extensions)

(require 'symbol-focus)

(defun cider-find-and-clear-repl-buffer ()
  (interactive)
  (cider-find-and-clear-repl-output t))

(require 'clojure-snippets)

;; keybindings
(define-key cider-repl-mode-map (kbd "C-,") 'complete-symbol)
(define-key cider-mode-map (kbd "C-,") 'complete-symbol)
(define-key cider-mode-map (kbd "C-c C-l") 'cider-find-and-clear-repl-buffer)

(define-key clojure-mode-map (kbd "M-s f") 'sf/focus-at-point)
(define-key clojure-mode-map [remap paredit-forward] 'clojure-forward-logical-sexp)
(define-key clojure-mode-map [remap paredit-backward] 'clojure-backward-logical-sexp)
(define-key clojure-mode-map (kbd "C-c C-l") 'cider-find-and-clear-repl-buffer)
(define-key clojure-mode-map (kbd "C->") 'clojure-thread)
(define-key clojure-mode-map (kbd "C-<") 'clojure-unwind)

(define-key clj-refactor-map (kbd "C-x C-r") 'cljr-rename-file)

(provide 'setup-clojure-mode)

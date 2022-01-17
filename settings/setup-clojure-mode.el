(require 'clojure-mode)
(require 'clojure-mode-extra-font-locking)

(require 'clj-refactor)
(cljr-add-keybindings-with-prefix "C-c C-m")


(require 'cider)

(defun bk/clojure--reset ()
  (interactive)
  (cider-nrepl-request:eval
   "(reset)"
   (lambda (&rest res))
   "user"))

(define-key cider-repl-mode-map (kbd "C-,") 'complete-symbol)
(define-key cider-mode-map (kbd "C-,") 'complete-symbol)

;;; enable clojure
(defun bk/enable-clojure-extensions ()
  (clj-refactor-mode 1))

(add-hook 'clojure-mode-hook 'bk/enable-clojure-extensions)

(provide 'setup-clojure-mode)

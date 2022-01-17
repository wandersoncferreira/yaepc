(require 'clojure-mode)
(require 'clojure-mode-extra-font-locking)

(require 'clj-refactor)
(cljr-add-keybindings-with-modifier "C-s-")

(require 'cider)
(define-key cider-repl-mode-map (kbd "C-,") 'complete-symbol)
(define-key cider-mode-map (kbd "C-,") 'complete-symbol)


(provide 'setup-clojure-mode)

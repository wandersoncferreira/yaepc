(require 'paredit)

(define-key paredit-mode-map (kbd "M-s") nil)

(add-hook 'clojure-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'cider-repl-mode-hook (lambda () (paredit-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode 1)))

(provide 'setup-paredit)

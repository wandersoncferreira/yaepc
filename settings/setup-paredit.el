(require 'paredit)

(defvar modes
  '(clojure-mode-hook
    cider-repl-mode-hook
    emacs-lisp-mode-hook))

(dolist (m modes)
  (add-hook m (lambda () (paredit-mode 1))))

(provide 'setup-paredit)

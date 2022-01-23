(require 'dired)
(require 'dired-x)

;; Move files between split panes
(setq dired-dwim-target t)

;; use GNU ls
(when is-mac
  (setq insert-directory-program
        (executable-find "gls")))

(provide 'setup-dired)

(require 'dired)
(require 'dired-x)

;; Move files between split panes
(setq dired-dwim-target t)

;; require GNU ls to use group flag
(setq dired-listing-switches "-al --group-directories-first")

;; use GNU ls
(when is-mac
  (setq insert-directory-program
        (executable-find "gls")))

(provide 'bartuka-dired)

(require 'dired)

(require 'dired-x)

;; Move files between split panes
(setq dired-dwim-target t)

;; use GNU ls
(when is-mac
  (setq insert-directory-program
        (executable-find "gls")))

;; make dired less verbose
(add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode +1)))

;; bind dired delete on `k`
(define-key dired-mode-map (kbd "k") 'dired-do-delete)

;; enable 'a'-keybinding in dired - which opens the file and closes dired buffer
(put 'dired-find-alternate-file 'disabled nil)

(provide 'extra-dired)

;; completion that uses many different methods to find options
(global-set-key (kbd "C-,") 'completion-at-point)

;; another way to hit M-x
(global-set-key (kbd "C-x C-m") #'execute-extended-command)

;; magit
(global-set-key (kbd "C-c g s") 'magit-status)

;; buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-c e b") 'eval-buffer)

;; dired
(global-set-key (kbd "C-x C-j") 'dired-jump)

;;; bind pop to mark to C-x p due to very hard wired muscle memory
(global-set-key (kbd "C-x p") 'pop-to-mark-command)

;;; shotcurts
(set-register ?e '(file . "~/.emacs.d/init.el"))
(set-register ?k '(file . "~/.emacs.d/settings/key-bindings.el"))

;;; consult
;; overwrite the projectile variants
(eval-after-load 'projectile
  (lambda ()
    (define-key projectile-mode-map (kbd "C-c p s") 'consult-ripgrep)))

(provide 'key-bindings)

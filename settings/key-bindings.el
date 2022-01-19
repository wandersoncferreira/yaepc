;; completion that uses many different methods to find options
(global-set-key (kbd "C-,") 'completion-at-point)

;; another way to hit M-x
(global-set-key (kbd "M-x") #'smex)
(global-set-key (kbd "M-X") #'smex-major-mode-commands)
(global-set-key (kbd "C-x C-m") #'smex)
(autoload 'smex "smex")

;; magit
(global-set-key (kbd "C-x m") 'magit-status-fullscreen)
(autoload 'magit-status-fullscreen "magit")

;; buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-c e b") 'eval-buffer)

;; window
(global-set-key (kbd "C-x 2") 'bk/vsplit-last-buffer)
(global-set-key (kbd "C-x 3") 'bk/hsplit-last-buffer)

;; project
(global-set-key (kbd "s-t") #'projectile-toggle-between-implementation-and-test)

;; dired
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; movement
; bind pop to mark to C-x p due to very hard wired muscle memory
(global-set-key (kbd "C-x p") 'pop-to-mark-command)

(global-set-key (kbd "M-p") 'jump-char-backward)
(global-set-key (kbd "M-n") 'jump-char-forward)

;; editing
(global-set-key (kbd "M-i") 'change-inner)
(global-set-key (kbd "M-o") 'change-outer)

;; selection
(global-set-key (kbd "C-=") 'er/expand-region)

;;; shotcurts
(set-register ?e '(file . "~/.emacs.d/init.el"))
(set-register ?k '(file . "~/.emacs.d/settings/key-bindings.el"))
(set-register ?n '(file . "~/org/notes.org"))

(provide 'key-bindings)

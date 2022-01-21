;; completion that uses many different methods to find options
(global-set-key (kbd "C-,") 'completion-at-point)

;; another way to hit M-x
(global-set-key (kbd "M-x") #'smex)
(global-set-key (kbd "M-X") #'smex-major-mode-commands)
(global-set-key (kbd "C-x C-m") #'smex)
(autoload 'smex "smex")

;; elfeed
(global-set-key (kbd "C-c C-w") 'elfeed)
(autoload 'elfeed "elfeed")

;; magit
(global-set-key (kbd "C-c g s") 'magit-status-fullscreen)
(autoload 'magit-status-fullscreen "magit")

(global-set-key (kbd "C-c g t") 'git-timemachine)

(global-set-key (kbd "C-c g g") 'bk/browse-at-remote)
(global-set-key (kbd "C-c g w") 'bk/copy-permalink-at-point)

(eval-after-load "magit"
  '(define-key magit-status-mode-map (kbd "C-c r") 'magit-ediff-resolve))

;; buffer
(defun bk/eval-buffer ()
  (interactive)
  (eval-buffer)
  (message "Buffer evaluated"))

(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-c e b") 'bk/eval-buffer)

;; window
(global-set-key (kbd "C-x 2") 'bk/vsplit-last-buffer)
(global-set-key (kbd "C-x 3") 'bk/hsplit-last-buffer)
(global-set-key (kbd "C-x 4 u") 'winner-undo)
(global-set-key (kbd "C-x 4 U") 'winner-redo)

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
(global-set-key (kbd "C-c k f") 'zap-up-to-char)
(global-set-key (kbd "C-c k b") 'bk/zap-to-char-backward)

;; selection
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer-other-window)

;;; shotcurts
(set-register ?e '(file . "~/.emacs.d/init.el"))
(set-register ?k '(file . "~/.emacs.d/settings/key-bindings.el"))
(set-register ?n '(file . "~/org/notes.org"))

;; projects
(eval-after-load "projectile"
  '(progn
     (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
     (define-key projectile-mode-map (kbd "C-c p s") 'projectile-grep)))

;; paredit
(eval-after-load "paredit"
  '(define-key paredit-mode-map (kbd "M-s") nil))

;; perspective
(global-set-key (kbd "C-x k") 'persp-kill-buffer*)

(provide 'key-bindings)

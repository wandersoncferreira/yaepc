;; completion that uses many different methods to find options
(global-set-key (kbd "C-,") 'completion-at-point)

(global-set-key (kbd "M-/") 'hippie-expand)

;; another way to hit M-x
(global-set-key (kbd "M-x") #'smex)
(global-set-key (kbd "M-X") #'smex-major-mode-commands)
(global-set-key (kbd "C-x C-m") #'smex)
(autoload 'smex "smex")

;; elfeed
(global-set-key (kbd "C-c C-w") 'elfeed)
(autoload 'elfeed "elfeed")

;; magit
(global-set-key (kbd "C-c g") 'magit-file-dispatch)

;; remove Trace from transient menu
(transient-insert-suffix 'magit-file-dispatch "B"
  '("m" "Time Machine" git-timemachine))

(transient-insert-suffix 'magit-file-dispatch "B"
  '("w" "Copy Permalink" bk/copy-permalink-at-point))

(transient-insert-suffix 'magit-file-dispatch "t"
  '("r" "Remote Browse" bk/browse-at-remote))

(eval-after-load "magit"
  '(progn
     (define-key magit-status-mode-map (kbd "C-c r") 'magit-ediff-resolve)
     (define-key magit-status-mode-map (kbd "C-c s l") 'bk/magit-stage-line-at-point)))

;; buffer
(defun bk/eval-buffer ()
  (interactive)
  (eval-buffer)
  (message "Buffer evaluated"))

(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-c e b") 'bk/eval-buffer)
(global-set-key (kbd "C-c C-k") 'bk/eval-buffer)

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

(global-set-key (kbd "M-v") (lambda () (interactive) (scroll-down-command 8)))
(global-set-key (kbd "C-v") (lambda () (interactive) (scroll-up-command 8)))

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

;; org mode
(global-set-key (kbd "C-c o c") 'org-capture)

;; abbreviate mode
(global-set-key (kbd "C-x a l") 'bk/add-region-local-abbrev)
(global-set-key (kbd "C-x a g") 'bk/add-region-global-abbrev)

(provide 'key-bindings)

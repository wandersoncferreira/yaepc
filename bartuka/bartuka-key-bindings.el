;; completion that uses many different methods to find options
(global-set-key (kbd "C-,") #'completion-at-point)

;; imenu anywhere
(global-set-key (kbd "C-.") #'imenu-anywhere)

(global-set-key (kbd "M-/") #'hippie-expand)

;; another way to hit M-x
(global-set-key (kbd "M-x") #'smex)
(global-set-key (kbd "M-X") #'smex-major-mode-commands)
(global-set-key (kbd "C-x C-m") #'smex)
(autoload 'smex "smex")

;; elfeed
(global-set-key (kbd "C-c C-w") #'elfeed)
(autoload 'elfeed "elfeed")

;; magit
(global-set-key (kbd "C-c g") #'magit-file-dispatch)

;; remove Trace from transient menu
(transient-insert-suffix 'magit-file-dispatch "B"
  '("m" "Time Machine" git-timemachine))

(transient-insert-suffix 'magit-file-dispatch "B"
  '("w" "Copy Permalink" bk/copy-permalink-at-point))

(transient-insert-suffix 'magit-file-dispatch "t"
  '("r" "Remote Browse" bk/browse-at-remote))

(eval-after-load "magit"
  '(progn
     (define-key magit-status-mode-map (kbd "C-c r") #'magit-ediff-resolve)
     (define-key magit-status-mode-map (kbd "C-c s l") #'bk/magit-stage-line-at-point)
     (define-key magit-status-mode-map (kbd "C-M-<up>") #'magit-section-backward-sibling)
     (define-key magit-status-mode-map (kbd "C-M-<down>") #'magit-section-forward-sibling)))

;; buffer
(defun bk/eval-buffer ()
  (interactive)
  (eval-buffer)
  (message "Buffer evaluated"))

(global-set-key (kbd "C-x k") #'kill-this-buffer)
(global-set-key (kbd "C-c e b") #'bk/eval-buffer)
(global-set-key (kbd "C-c C-k") #'bk/eval-buffer)

;; window
(global-set-key (kbd "C-x 2") #'bk/vsplit-last-buffer)
(global-set-key (kbd "C-x 3") #'bk/hsplit-last-buffer)
(global-set-key (kbd "C-x 4 u") #'winner-undo)
(global-set-key (kbd "C-x 4 U") #'winner-redo)

(global-set-key (kbd "C-c w t") #'bk/toggle-transparency)

;; project
(global-set-key (kbd "s-t") #'projectile-toggle-between-implementation-and-test)

;; dired
(global-set-key (kbd "C-x C-j") #'dired-jump)

;; movement
; bind pop to mark to C-x p due to very hard wired muscle memory
(global-set-key (kbd "C-x p") #'pop-to-mark-command)

(autoload 'jump-char-backward "jump-char")
(autoload 'jump-char-forward "jump-char")
(global-set-key (kbd "M-p") #'jump-char-backward)
(global-set-key (kbd "M-n") #'jump-char-forward)

(global-set-key (kbd "M-v") (lambda () (interactive) (scroll-down-command 8)))
(global-set-key (kbd "C-v") (lambda () (interactive) (scroll-up-command 8)))

;; editing
(global-set-key (kbd "C-c k w") #'shrink-whitespace)

(autoload 'change-inner "change-inner")
(autoload 'change-outer "change-inner")

(global-set-key (kbd "M-i") #'change-inner)
(global-set-key (kbd "M-o") #'change-outer)

(global-set-key (kbd "C-c k f") #'zap-up-to-char)
(global-set-key (kbd "C-c k b") #'bk/zap-up-to-char-backward)
(global-set-key (kbd "C-c d") #'bk/duplicate-current-line-or-region)

(global-set-key (kbd "C-c r p") #'bk/point-to-register)
(global-set-key (kbd "C-c r j") #'bk/jump-to-register)

(global-set-key (kbd "M-u") #'fix-word-upcase)
(global-set-key (kbd "M-l") #'fix-word-downcase)
(global-set-key (kbd "M-c") #'fix-word-capitalize)

(global-set-key (kbd "C-M-=") #'bk/mark-inside-sexp)
(global-set-key (kbd "C-M--") #'bk/kill-inside-sexp)

(global-set-key (kbd "C-M-]") #'bk/indent-defun-at-point)

;; selection
(autoload 'er/expand-region "expand-region")
(global-set-key (kbd "C-=") #'er/expand-region)

(global-set-key (kbd "C-x M-b") #'ibuffer)

(global-set-key (kbd "C-x C-b") #'ido-switch-buffer-other-window)

(when (fboundp 'isearch-occur)
  (define-key isearch-mode-map (kbd "C-c C-o") #'isearch-occur))

;;; shotcurts
(set-register ?e '(file . "~/.emacs.d/init.el"))
(set-register ?k '(file . "~/.emacs.d/settings/key-bindings.el"))
(set-register ?t '(file . "~/org/tasks.org"))
(set-register ?h '(file . "~/.emacs.d/docs/tips.org"))

;; projects
(eval-after-load "projectile"
  '(progn
     (define-key projectile-mode-map (kbd "C-c p") #'projectile-command-map)
     (define-key projectile-mode-map (kbd "C-c p s") #'projectile-grep)))

;; paredit
(eval-after-load "paredit"
  '(define-key paredit-mode-map (kbd "M-s") nil))

;; perspective
(global-set-key (kbd "C-x k") #'persp-kill-buffer*)

;; org mode
(global-set-key (kbd "C-c o c") #'org-capture)
(global-set-key (kbd "C-c o a") #'org-agenda)
(global-set-key (kbd "C-c n f") #'org-roam-node-find)
(global-set-key (kbd "C-c n l") #'org-roam-buffer-toggle)
(global-set-key (kbd "C-c n i") #'org-roam-node-insert)
(global-set-key (kbd "C-c n c") #'org-roam-capture)
(global-set-key (kbd "C-c n j") #'org-roam-dailies-capture-today)

;; abbreviate mode
(global-set-key (kbd "C-x a l") #'bk/add-region-local-abbrev)
(global-set-key (kbd "C-x a g") #'bk/add-region-global-abbrev)

;; use space in the minibuffer
(defalias 'ido-complete-space #'self-insert-command)

;; spell + abbrev
(global-set-key (kbd "C-x C-i") #'bk/ispell-word-then-abbrev)

;; easy kill
(global-set-key [remap kill-ring-save] #'easy-kill)
(global-set-key [remap mark-sexp] #'easy-mark)

;; eshell
(global-set-key (kbd "C-c e s") #'eshell)

(eval-after-load "eshell"
  '(add-hook 'eshell-mode-hook
             (lambda ()
               (local-set-key (kbd "C-l") 'eshell-clear-buffer))))

;; snippets
(eval-after-load "yasnippet"
  '(progn
     (define-key yas-minor-mode-map (kbd "C-c y x") 'yas-expand)
     (define-key yas-minor-mode-map (kbd "C-c y h") 'yas-describe-tables)))

(provide 'bartuka-key-bindings)

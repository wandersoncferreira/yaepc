(require 'diff-hl)

(global-diff-hl-mode +1)

(diff-hl-dired-mode +1)

(require 'magit)

;; what magit-sections should be visible in the status buffer.
(setq magit-section-initial-visibility-alist
      '((untracked . show)
        (unstaged . show)
        (unpushed . show)
        (unpulled . show)
        (stashes . show)))

;; don't prompt me
(setq magit-push-always-verify nil
      magit-revert-buffers 'silent
      magit-no-confirm '(stage-all-changes
                         unstage-all-changes))

;; move cursor into position when entering commit message
(defun my/magit-cursor-fix ()
  (beginning-of-buffer)
  (when (looking-at "#")
    (forward-line 2)))

(add-hook 'git-commit-mode-hook 'my/magit-cursor-fix)

;; if using Magit 2.4 or newer these lines are recommended to be used
(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(setq magit-completing-read-function 'magit-ido-completing-read)

(defun magit-status-fullscreen (prefix)
  (interactive "P")
  (magit-status)
  (unless prefix
    (delete-other-windows)))

(defun bk/magit-stage-line-at-point ()
  "Stage current line at point."
  (interactive)
  (let ((init (point))
        (beg (line-beginning-position))
        (end (line-end-position)))
    (save-excursion
      (set-mark beg)
      (goto-char end)
      (activate-mark)
      (magit-apply-region (magit-current-section) "--cached"))
    (goto-char init)))

(require 'git-timemachine)

(provide 'extra-vc)

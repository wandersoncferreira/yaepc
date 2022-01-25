;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; Write all autosave files in the tmp dir
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Don't write lock-files, I'm the only one here
(setq create-lockfiles nil)

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Real emacs knights don't use shift to mark things
(setq shift-select-mode nil)

;; Tab also work as completion
(setq tab-always-indent 'complete)

;; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Save a list of recent files visited. (open recent file with C-x f)
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 30)

;; Undo/redo window configuration with C-c <left>/<right>
(require 'winner)
(winner-mode 1)

;; Never insert tabs
(set-default 'indent-tabs-mode nil)

;; Show me empty lines after buffer end
(setq indicate-empty-lines t)

;; Easily navigate sillycased words
(require 'subword)
(global-subword-mode 1)

;; Don't break lines for me, please
(setq-default truncate-lines t)

;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
(setq org-replace-disputed-keys t)

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

;; Add parts of each file's directory to the buffer name if not unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets
      uniquify-separator " • "
      uniquify-after-kill-buffer-p t
      uniquify-ignore-buffers-re "^\\*")

; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (when (eq last-command 'save-region-or-current-line)
      ad-do-it
      ad-do-it
      ad-do-it)
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))

(setq set-mark-command-repeat-pop t)

;; use arrows to move between window
(windmove-default-keybindings)

;; macos specific
(when is-mac
  (setq mac-command-modifier 'meta
        mac-option-modifier '(:ordinary super :button 2)
        mac-pass-control-to-system nil))

;; save history between sections
(require 'savehist)
(savehist-mode +1)

;; split the window and move the cursor there
(defun bk/vsplit-last-buffer ()
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))

(defun bk/hsplit-last-buffer ()
  (interactive)
  (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer))

;; adjust gc after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 20 1024 1024))))

;; setup abbreviations
(require 'abbrev)
(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table
  '(
    ("reslt" "result" nil 0)
    ("requier" "require" nil 0)
    ))

(defun bk/add-region-local-abbrev (start end)
  "Go from START to END and add the selected text to a local abbrev."
  (interactive "r")
  (if (use-region-p)
      (let ((num-words (count-words-region start end)))
        (inverse-add-mode-abbrev num-words)
        (deactivate-mark))
    (message "No selected region!")))

(defun bk/add-region-global-abbrev (start end)
  "Go from START to END and add the selected text to global abbrev."
  (interactive "r")
  (if (use-region-p)
      (let ((num-words (count-words-region start end)))
        (inverse-add-abbrev global-abbrev-table "Global" num-words)
        (deactivate-mark))
    (message "No selected region!")))

;; minibuffer
(minibuffer-electric-default-mode)

;; display default argument as [DEFAULT-ARG] instead of (default DEFAULT-ARG)
(setq minibuffer-eldef-shorten-default t)

;; make script files executable automatically
;;
;; verifies if the buffer file has a shebang in it and then changes
;; the permissions if necessary
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; calendar week start on Monday
(setq calendar-week-start-day 1)

;; remove the annoying prompt when you try to exit Emacs and there are
;; sub-processes running
(setq confirm-kill-processes nil)

(provide 'sane-defaults)

;; lots of config here https://gitlab.com/skybert/my-little-friends/blob/master/emacs/.emacs#L780

(require 'lsp-java)
(require 'lsp)

;; support to Lombok
(setq lsp-java-vmargs
      (list
       "-noverify"
       "-Xmx3G"
       "-XX:+UseG1GC"
       "-XX:+UseStringDeduplication"
       "-javaagent:/Users/wferreir/code/dotfiles/lombok-1.18.22.jar"))

;; new keybinding to execute lsp code actions
(setq lsp-keymap-prefix "C-c a")

;; optimization recommended by LSP maintainers
(setq read-process-output-max (* 1024 1024))

(defun bk/java-mode-hook ()
  (auto-fill-mode)
  (subword-mode)
  (yas-minor-mode)
  (electric-pair-mode)
  (lsp))

(add-hook 'java-mode-hook 'bk/java-mode-hook)

(define-key lsp-mode-map (kbd "M-RET") #'lsp-execute-code-action)

(provide 'bartuka-java)

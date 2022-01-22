(require 'yasnippet)

(yas-global-mode +1)

;; jump to end of snippet definition
(define-key yas-keymap (kbd "<return>") 'yas-exit-all-snippets)

;; no dropdowns
(setq yas-prompt-functions '(yas-ido-prompt yas-completing-read))

(provide 'setup-snippets)

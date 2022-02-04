(require 'yasnippet)

(yas-global-mode +1)

;; no dropdowns
(setq yas-prompt-functions '(yas-ido-prompt yas-completing-read))

(provide 'bartuka-snippets)

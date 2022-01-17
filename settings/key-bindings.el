
;; completion that uses many different methods to find options
(global-set-key (kbd "C-,") 'completion-at-point)

;; smart m-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x C-m") 'smex)

;; magit
(global-set-key (kbd "C-c g s") 'magit-status)

;; buffer
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; dired
(global-set-key (kbd "C-x C-j") 'dired-jump)

(provide 'key-bindings)

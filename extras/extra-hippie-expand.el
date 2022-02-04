(require 'hippie-exp)

(autoload '--filter "dash" nil t)

;; only consider buffers in the same mode with `try-expand-dabbrev-all-buffers'.
(defun try-expand-dabbrev-matching-buffers (old)
  (let ((matching-buffers (--filter
                           (eq major-mode (with-current-buffer it major-mode))
                           (buffer-list))))
    (cl-flet ((buffer-list () matching-buffers))
      (try-expand-dabbrev-all-buffers old))))

(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-matching-buffers
        try-complete-file-name-partially
        try-complete-file-name))

(provide 'extra-hippie-expand)

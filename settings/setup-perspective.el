(require 'perspective)

(persp-mode t)

;; include cider buffer into current workspace
(add-hook 'cider-repl-mode-hook
          (lambda ()
            (persp-set-buffer (current-buffer))))

;; include test report buffer to current perspective too
(add-hook 'cider-test-report-mode-hook
          (lambda ()
            (persp-set-buffer (current-buffer))))

(provide 'setup-perspective)

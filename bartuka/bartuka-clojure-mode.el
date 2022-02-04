(require 'clojure-mode)

(require 'clj-refactor)
(setq cljr-clojure-test-declaration "[clojure.test :refer [deftest is testing]]"
      cljr-cljs-clojure-test-declaration cljr-clojure-test-declaration
      cljr-cljc-clojure-test-declaration cljr-clojure-test-declaration)

(cljr-add-keybindings-with-prefix "C-c C-m")

(require 'cider)

;; Hide nrepl buffers when switching buffers (switch to by prefixing with space)
(setq nrepl-hide-special-buffers t)

(defun bk/cider--reset ()
  (interactive)
  (cider-interactive-eval "(reset)"))

;;; enable clojure
(defun bk/enable-clojure-extensions ()
  (clj-refactor-mode 1))

(add-hook 'clojure-mode-hook 'bk/enable-clojure-extensions)

(require 'symbol-focus)

(defun cider-find-and-clear-repl-buffer ()
  (interactive)
  (cider-find-and-clear-repl-output t))

(require 'clojure-snippets)

(defun bk/cider--reset-alias-after-error ()
  (interactive)
  (let ((alias))
    (with-current-buffer (get-buffer "*cider-error*")
      (save-excursion
        (goto-char (point-min))
        (while (not (eobp))
          (let ((line-at-point (buffer-substring-no-properties
                                (line-beginning-position)
                                (line-end-position))))
            (when (string-match
                   "Alias \\(\\w+\\) already exists in namespace"
                   line-at-point)
              (setq alias (match-string 1 line-at-point))))
          (forward-line))))
    (cider-repl-set-ns (cider-current-ns))
    (cider-interactive-eval
     (format "(ns-unalias *ns* '%s)" alias))
    (cider-repl-set-ns "user")))

;; keybindings
(define-key cider-repl-mode-map (kbd "C-,") 'complete-symbol)
(define-key cider-repl-mode-map (kbd "C-l") 'cider-find-and-clear-repl-buffer)

(define-key cider-mode-map (kbd "C-,") 'complete-symbol)
(define-key cider-mode-map (kbd "C-c C-l") 'cider-find-and-clear-repl-buffer)

(define-key cider-mode-map (kbd "C-c r s") #'bk/cider--reset)
(define-key cider-mode-map (kbd "C-c r a") #'bk/cider--reset-alias-after-error)

(define-key clojure-mode-map (kbd "M-s f") 'sf/focus-at-point)
(define-key clojure-mode-map [remap paredit-forward] 'clojure-forward-logical-sexp)
(define-key clojure-mode-map [remap paredit-backward] 'clojure-backward-logical-sexp)
(define-key clojure-mode-map (kbd "C-c C-l") 'cider-find-and-clear-repl-buffer)
(define-key clojure-mode-map (kbd "C->") 'clojure-thread)
(define-key clojure-mode-map (kbd "C-<") 'clojure-unwind)

(define-key clj-refactor-map (kbd "C-x C-r") 'cljr-rename-file)

;; include cider buffer into current workspace
(require 'perspective)

(add-hook 'cider-repl-mode-hook
          (lambda ()
            (persp-add-buffer (current-buffer))))

;; include test report buffer to current perspective too
(add-hook 'cider-test-report-mode-hook
          (lambda ()
            (persp-add-buffer (current-buffer))))

;; temp buffers created by cider e.g. *cider-ns-refresh-log*
(add-hook 'cider-popup-buffer-mode-hook
          (lambda ()
            (persp-add-buffer (current-buffer))))

(provide 'bartuka-clojure-mode)

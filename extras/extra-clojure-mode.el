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
  (clj-refactor-mode 1)
  (lsp))

(require 'flycheck)
(setq flycheck-check-syntax-automatically '(mode-enabled save))

(setq lsp-signature-auto-activate nil
      lsp-enable-indentation nil
      lsp-enable-completion-at-point nil
      lsp-lens-enable nil
      lsp-headerline-breadcrumb-enable nil
      lsp-modeline-code-actions-enable nil
      lsp-diagnostics-provider :flycheck
      lsp-use-plists t
      lsp-modeline-diagnostics-enable nil)

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

;; paredit adjustments
(define-key clojure-mode-map [remap paredit-forward] 'clojure-forward-logical-sexp)
(define-key clojure-mode-map [remap paredit-backward] 'clojure-backward-logical-sexp)

;; completion
(define-key cider-repl-mode-map (kbd "C-,") 'complete-symbol)
(define-key cider-mode-map (kbd "C-,") 'complete-symbol)

;; focus to refactor
(define-key clojure-mode-map (kbd "M-s f") 'sf/focus-at-point)

;; threading is great!
(define-key clojure-mode-map (kbd "C->") 'clojure-thread)
(define-key clojure-mode-map (kbd "C-<") 'clojure-unwind)

;; clear repl
(define-key clojure-mode-map (kbd "C-c C-l") 'cider-find-and-clear-repl-buffer)
(define-key cider-repl-mode-map (kbd "C-l") 'cider-find-and-clear-repl-buffer)
(define-key cider-mode-map (kbd "C-c C-l") 'cider-find-and-clear-repl-buffer)

;; reset
(define-key cider-mode-map (kbd "C-c C-m") nil)
(define-key cider-repl-mode-map (kbd "C-c C-m") nil)
(define-key cider-mode-map (kbd "C-c C-m r s") #'bk/cider--reset)
(define-key cider-repl-mode-map (kbd "C-c C-m r s") #'bk/cider--reset)
(define-key cider-mode-map (kbd "C-c C-m r a") #'bk/cider--reset-alias-after-error)

;;; organize refactor keybindings
;; find
(define-key clojure-mode-map (kbd "C-c C-m f d") 'lsp-find-definition)
;; show
(define-key clojure-mode-map (kbd "C-c C-m s s") 'lsp-treemacs-symbols)
(define-key clj-refactor-map (kbd "C-c C-m s e") 'lsp-treemacs-errors-list)
;; rename
(define-key clj-refactor-map (kbd "C-c C-m r s") 'lsp-rename)
(define-key clojure-mode-map (kbd "C-c C-m r f") 'cljr-rename-file)
;; extract
(define-key clj-refactor-map (kbd "C-c C-m e f") 'lsp-clojure-extract-function)
;; inline
(define-key clj-refactor-map (kbd "C-c C-m i s") 'lsp-clojure-inline-symbol)


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

;;; fix the modeline indicator for cider.
;;; I'd like to see only " cider[connected:<port>]" or " cider[not conencted]"
(defun bk/cider--modeline-info ()
  (if-let* ((current-connection (ignore-errors (cider-current-repl))))
      (with-current-buffer current-connection
        (concat
         (symbol-name cider-repl-type)
         (when cider-mode-line-show-connection
           (format ":connected:%s" (plist-get nrepl-endpoint :port)))))
    "not connected"))

(setq cider-mode-line
      '(:eval (format " cider[%s]" (bk/cider--modeline-info))))

(provide 'extra-clojure-mode)

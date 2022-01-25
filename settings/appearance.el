;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Don't beep. Don't visible-bell (fails on el capitan). Just blink the modeline on errors.
(setq visible-bell nil)
(setq ring-bell-function
      (lambda ()
        (invert-face 'mode-line)
        (run-with-timer 0.05 nil 'invert-face 'mode-line)))

;; Set custom theme path
(setq custom-theme-directory (concat user-emacs-directory "themes"))

(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

(defun font-available-p (font-name)
  (find-font (font-spec :name font-name)))

(defun bk/set-monaco-font (size)
  (when (font-available-p "Monaco")
    (set-face-attribute 'default nil :font (format "Monaco %s" size))))

(defun bk/dark-background ()
  (interactive)
  (load-theme 'default-black t))

(bk/dark-background)

;; enable matching parens to be highlighted
(show-paren-mode +1)

;; increase left fringe size a bit
(fringe-mode '(12 . 0))

;;; clean the modeline
(require 'diminish)
(eval-after-load "eldoc" '(diminish 'eldoc-mode))
(eval-after-load "paredit" '(diminish 'paredit-mode))
(eval-after-load "subword" '(diminish 'subword-mode))
(eval-after-load "autorevert" '(diminish 'auto-revert-mode))
(eval-after-load "clj-refactor" '(diminish 'clj-refactor-mode))
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
(eval-after-load "abbrev" '(diminish 'abbrev-mode))
(eval-after-load "whitespace" '(diminish 'whitespace-mode))
(eval-after-load "flyspell" '(diminish 'flyspell-mode))
(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))

(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "clojure-mode" clojure-mode "Clj")

;; make the frame transparent
(defun bk/toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (or (eql (cond ((numberp alpha) alpha)
                        ((numberp (cdr alpha)) (cdr alpha))
                        ((numberp (cadr alpha)) (cadr alpha)))
                  100)
             (not alpha))
         85
       100))))

;; whitespace
(require 'whitespace)
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'before-save-hook 'whitespace-cleanup)

(setq whitespace-line-column 80
      whitespace-style
      '(face tabs empty trailing lines-tail))

(provide 'appearance)

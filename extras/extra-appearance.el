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

(defun bk/set-jetbrains-mono-font (size)
  "Requires `brew install font-jetbrains-mono`."
  (when (font-available-p "JetBrains Mono")
    (set-face-attribute 'default nil :font (format "JetBrains Mono %s" size))))

(defun bk/set-input-mono-font (size)
  (when (font-available-p "Input Mono")
    (set-face-attribute 'default nil :font (format "Input Mono %s" size))))

(defun bk/set-ibm-plex-mono-font (size)
  (when (font-available-p "IBM Plex Mono")
    (set-face-attribute 'default nil :font (format "IBM Plex Mono %s" size))))

(defun bk/dark-background ()
  (interactive)
  (load-theme 'default-black t))

(defun bk/almost-mono-white-customizations ()
  ;; (set-face-attribute 'lazy-highlight nil :background "khaki1")
  ;; (set-face-attribute 'isearch nil :background "khaki1")
  ;; (set-face-attribute 'region nil :background "khaki1")

  (eval-after-load "diff-hl"
    '(progn
       (set-face-attribute 'diff-hl-change nil :background "DeepSkyBlue1")
       (set-face-attribute 'diff-hl-delete nil :background "PaleVioletRed1")
       (set-face-attribute 'diff-hl-insert nil :background "DarkSeaGreen2"))))

;; mark custom themes as safe
(setq custom-safe-themes t)

(load-theme 'almost-mono-white t)

;; change default font
(bk/set-ibm-plex-mono-font 16)

;; remove cursor in non selected window
(setq cursor-in-non-selected-windows nil)

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
(eval-after-load "projectile" '(diminish 'projectile-mode))

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
(add-hook 'before-save-hook 'whitespace-cleanup)

;; highlight
(defun highlight-todos ()
  (font-lock-add-keywords
   nil
   '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t))))

(eval-after-load "clojure-mode"
  '(add-hook 'clojure-mode-hook #'highlight-todos))

(eval-after-load "elisp-mode"
  '(add-hook 'emacs-lisp-mode-hook #'highlight-todos))

(provide 'extra-appearance)

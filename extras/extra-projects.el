(require 'perspective)

(persp-mode t)


(require 'projectile)

(projectile-mode +1)

(setq projectile-globally-ignored-directories
      (append projectile-globally-ignored-directories
              '(".clj-kondo"
                ".local"
                ".cpcache"))
      projectile-project-search-path '("~/code")
      projectile-indexing-method 'alien
      projectile-enable-caching nil
      projectile-completion-system 'ido
      projectile-mode-line-prefix " P")

(require 'wgrep)

;; create perspective when switching between projects.
(defvar bk--projectile-target-project nil)

(defun bk/projectile-switch-project-by-name (projectile-switch-project-by-name &rest args)
  (setq bk--projectile-target-project (->> (split-string (car args) "/")
                                           (-drop-last 1)
                                           (-last-item)))
  (apply projectile-switch-project-by-name args))

(advice-add #'projectile-switch-project-by-name :around #'bk/projectile-switch-project-by-name)

(defun bk/new-persp-for-project-switch ()
  (persp-switch bk--projectile-target-project))

(add-hook 'projectile-before-switch-project-hook #'bk/new-persp-for-project-switch)

(provide 'extra-projects)

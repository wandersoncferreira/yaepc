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

(provide 'bartuka-projectile)

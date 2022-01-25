;;; early-init.el --- Emacs 27+ pre-initialization config

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6
      package-enable-at-startup nil)

(provide 'early-init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("88ca3c337196348f30336f1589f5adcd6a250f82f5551f62ae1de835df50c94e" default))
 '(package-selected-packages
   '(browse-at-remote find-file-in-project ctrlf remind-bindings smex projectile magit jump-char ido-vertical-mode ido-completing-read+ ido-at-point flx-ido exec-path-from-shell diminish diff-hl clojure-mode-extra-font-locking clj-refactor change-inner))
 '(safe-local-variable-values
   '((eval progn
           (put 's/defn 'clojure-doc-string-elt 2)
           (define-clojure-indent
             (puppetlabs\.trapperkeeper\.core/defservice
              '(:defn
                (:defn)))
             (trapperkeeper/defservice
              '(:defn
                (:defn)))
             (tk/defservice
              '(:defn
                (:defn)))
             (defservice
               '(:defn
                 (:defn)))
             (dotests 2)
             (context 2)
             (DELETE 2)
             (GET 2)
             (PATCH 2)
             (POST 2)
             (PUT 2)))
     (eval add-to-list 'auto-mode-alist
           '("\\.clj-template$" . clojure-mode))
     (magit-todos-exclude-globs "*.html" "*.org" "*.md" "*.map"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

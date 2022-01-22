(require 'org)

(setq org-directory "~/org"
      org-default-notes-file (concat org-directory "/notes.org")
      org-return-follows-link t
      org-todo-keywords
      '((sequence "TODO(t)"
                  "IN-PROGRESS(p)"
                  "|"
                  "DONE(d)"
                  "CANCELED(c)"
                  "CANT-REPRODUCE(k)"))
      org-todo-keyword-faces
      '(("IN-PROGRESS" . "purple")
        ("CANCELED" . org-warning)
        ("CANT-REPRODUCE" . "red")))

(require 'org-roam)
(setq org-roam-directory "~/roam-v2")

(org-roam-db-autosync-mode)

(require 'org-roam-dailies)
(setq org-roam-dailies-directory "~/roam-v2/dailies")

;;; Blog

;; I am using `org' to write my blog posts using `ox-hugo' to export
;; it to the right place.

(require 'ox-hugo)
(setq org-hugo-base-dir "~/code/wandersoncferreira.github.io"
      org-hugo-section "items"
      org-hugo-front-matter-format "yaml")

;; That's almost it!
;;
;; I also prefer to keep all my notes in `org-roam' therefore my blog
;; post org file is also a node inside `org-roam'. This has been great
;; to me, but when I export the file to Hugo I don't want to handle
;; all the backlinks created by `org-roam'.
;;
;; This function is an overwrite to use bold markup instead of
;; backlinks.

(defun bk/handle-org-roam-link-as-bold (orig &rest args)
  (let* ((link (car args))
         (raw-path (org-element-property :path link))
         (desc (cadr args))
         (info (caddr args))
         (type (org-element-property :type link)))
    (cond
     ((member type '("custom-id" "id"))
      (let ((destination (org-export-resolve-id-link link info)))
        (pcase (org-element-type destination)
          (`plain-text
           (if (not (string-equal (file-name-directory (org-id-find-id-file raw-path))
                                  (expand-file-name org-hugo-base-dir)))
               (format "**%s**" desc)
             (apply orig args)))
          (t
           (apply orig args)))))
     (t
      (apply orig args)))))

(advice-add 'org-hugo-link :around #'bk/handle-org-roam-link-as-bold)

(provide 'setup-org)

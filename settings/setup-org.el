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

(provide 'setup-org)

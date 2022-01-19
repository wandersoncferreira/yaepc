(setq org-directory "~/org"
      org-default-notes-file (concat org-directory "/notes.org"))

(define-key global-map (kbd "C-c o c") 'org-capture)

(provide 'setup-org)

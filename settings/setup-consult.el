(require 'consult)

(setq register-preview-delay 0
      register-preview-function #'consult-register-format
      consult-preview-key (kbd "M-p"))

;; Optionally tweak the register preview window.
;; This adds thin lines, sorting and hides the mode line of the window.
(advice-add #'register-preview :override #'consult-register-window)

;; Optionally replace `completing-read-multiple' with an enhanced version.
(advice-add #'completing-read-multiple :override #'consult-completing-read-multiple)

;; Use Consult to select xref locations with preview
(setq xref-show-xrefs-function #'consult-xref
      xref-show-definitions-function #'consult-xref)

(add-hook 'completion-list-mode-hook #'consult-preview-at-point-mode)

;;; enable completion-at-point through consult if vertico-mode is enabled
(setq completion-in-region-function
      (lambda (&rest args)
        (apply (if vertico-mode
                   #'consult-completion-in-region
                 #'completion--in-region)
               args)))

(provide 'setup-consult)

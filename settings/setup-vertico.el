(require 'vertico)

(vertico-mode +1)

(setq vertico-count 10
      vertico-resize nil
      vertico-cycle t)

;;; completion styles
(require 'orderless)
(setq completion-styles '(orderless)
      completion-category-defaults nil
      completion-category-defaults '((file (styles partial-completion))))

(setq enable-recursive-minibuffers t)

;;; multiple completion indicator
(defun crm-indicator (args)
  (cons (concat "[CRM] " (car args)) (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'crm-indicator)

(provide 'setup-vertico)

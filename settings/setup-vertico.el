(require 'vertico)
(setq vertico-count 10
      vertico-resize nil
      vertico-cycle t)

(vertico-mode +1)

;;; completion styles
(require 'orderless)
(setq completion-styles '(orderless)
      completion-category-defaults nil
      completion-category-defaults '((file (styles partial-completion)))
      enable-recursive-minibuffers t)

;;; multiple completion indicator
(defun crm-indicator (args)
  (cons (concat "[CRM] " (car args)) (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'crm-indicator)

;;; persist history over Emacs restarts
(require 'savehist)
(savehist-mode)

(provide 'setup-vertico)

(require 'ido)
(ido-mode t)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-case-fold nil
      ido-auto-merge-work-directories-length -1
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-max-prospects 10)

(require 'ido-vertical-mode)
(ido-vertical-mode)

;; C-n/p is more intuitive in vertical layout
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

;; Ido at point (C-,)
(require 'ido-at-point)
(ido-at-point-mode)

;; use ido everywhere
(ido-everywhere 1)
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)
(require 'icomplete)
(icomplete-mode 1)
(setq magit-completing-read-function 'magit-ido-completing-read)


(provide 'setup-ido)

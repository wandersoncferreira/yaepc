(require 'ido)
(ido-mode t)

;; disable merged work directories... I don't understand why this is useful if
;; no matches are found in the current directory, IDO tries to match my input in
;; another project
(setq ido-auto-merge-work-directories-length -1)

;; enable recentf integration
(setq ido-use-virtual-buffers t)

(setq ido-enable-flex-matching t)

;; change the collection size above which flx will revert to flex matching
(setq flx-ido-threshold 2000)

;; Try out flx-ido for better flex matching between words
(require 'flx-ido)
(flx-ido-mode 1)

;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; flx-ido looks better with ido-vertical-mode
(require 'ido-vertical-mode)
(ido-vertical-mode)

;; C-n/p is more intuitive in vertical layout
(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

;; Ido at point (C-,)
(require 'ido-at-point)
(ido-at-point-mode)

;; Use ido everywhere
(ido-mode 1)
(ido-everywhere 1)

(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)

(provide 'setup-ido)

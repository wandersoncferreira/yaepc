(require 'ido)

;; use dot in the IDO candidate list to goto dired
(setq ido-show-dot-for-dired t)

;; disable merged work directories... I don't understand why this is useful if
;; no matches are found in the current directory, IDO tries to match my input in
;; another project
(setq ido-auto-merge-work-directories-length -1)

;; enable flexible string matching.  Flexible matching means that if
;; the entered string does not match any item, any item containing the
;; entered characters in the given sequence will match.
(setq ido-enable-flex-matching t)

;; don't prompt me if a new buffer needs to be created if no buffer
;; matches substring
(setq ido-create-new-buffer 'always)

;; Do not confirm unique completions
(setq ido-confirm-unique-completion nil)

;; By default, Ido arranges matches in the following order:
;; full-matches > suffix-matches > prefix matches > remaining matches
;; this can get in the way for buffer switching
(setq ido-buffer-disable-smart-matches nil)

;; change the collection size above which flx will revert to flex matching
(setq flx-ido-threshold 2000)

;; Try out flx-ido for better flex matching between words
(require 'flx-ido)

;; smarter fuzzy matching for ido
(flx-ido-mode 1)

;; disable ido faces to see flx highlights
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

;; create a few shortcuts
(add-hook 'ido-extra-hook
          (lambda ()
            ;; go to home
            (define-key ido-file-completion-map (kbd "~")
              (lambda ()
                (interactive)
                (if (looking-back "~/")
                    (insert "code/")
                  (if (looking-back "/")
                      (insert "~/")
                    (call-interactively 'self-insert-command)))))))

(provide 'extra-ido)

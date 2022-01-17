(require 'epa)
(require 'epa-file)
(require 'auth-source)
(require 'org-crypt)

(setq epg-gpg-program "gpg"
      org-tags-exclude-from-inheritance (quote ("crypt"))
      password-cache-expiry nil
      auth-sources (nreverse auth-sources)
      auth-source-cache-expiry nil
      auth-source-debug t
      epa-file-encrypt-to '("wand@hey.com"))

(set 'epg-pinentry-mode nil)
(epa-file-enable)
(org-crypt-use-before-save-magic)

(defun bk/bitwarden ()
  "Get bitwarden."
  (interactive)
  (kill-new (auth-source-pick-first-password
             :host "bitwarden.app"
             :user "bartuka")))

(provide 'setup-encryption)

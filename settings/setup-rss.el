(require 'elfeed)

(setq elfeed-feeds
      '("https://karl-voit.at/feeds/lazyblorg-all.atom_1.0.links-and-content.xml"))

(set-face-attribute 'elfeed-search-title-face nil :foreground "dim gray")
(set-face-attribute 'elfeed-search-unread-title-face nil :foreground "powder blue")


(provide 'setup-rss)

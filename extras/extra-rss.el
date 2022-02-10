(require 'elfeed)

(setq elfeed-feeds
      '("https://karl-voit.at/feeds/lazyblorg-all.atom_1.0.links-and-content.xml"
        "https://emilkirkegaard.dk/en/feed"
        "https://desmondrivet.com/feeds/blog.rss"
        "https://xkcd.com/atom.xml"
        "https://emacsredux.com/atom.xml"
        "https://okmij.org/ftp/rss.xml"))

(set-face-attribute 'elfeed-search-title-face nil :foreground "dim gray")
(set-face-attribute 'elfeed-search-unread-title-face nil :foreground "powder blue")

(provide 'extra-rss)

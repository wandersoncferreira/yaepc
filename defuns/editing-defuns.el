
(defun bk/zap-to-char-backward (arg char)
  (interactive "p\ncZap up to char backward: ")
  (save-excursion
    (zap-up-to-char -1 char)))

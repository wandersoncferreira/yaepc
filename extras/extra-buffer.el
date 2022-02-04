(with-eval-after-load "ibuf-ext"
  (define-ibuffer-filter current-persp
      "Limit current view to buffers that are assigned to current perspective."
    (:description "current-persp"
                  :reader nil)
    (with-current-buffer buf
      (member buf (persp-current-buffers)))))

(with-eval-after-load "ibuffer"
  (autoload 'ibuffer-filter-by-current-persp "ibuf-ext")
  (define-key ibuffer-mode-map (kbd "/ p") 'ibuffer-filter-by-current-persp))

(provide 'extra-buffer)

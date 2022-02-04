(setq check-cmd
      "(progn (load-file \"~/.emacs.d/init.el\") (print 42))")

(setq safe-to-quit? nil)

(setq error-msgs nil)

(defun bk/verify-if-emacs-config-is-in-good-shape ()
  "Can I close Emacs now and be sure I can open it later on? :)"
  (let ((proc (start-process
               "*EmacsCheck*"
               "*EmacsCheckOutput*"
               "emacs"
               "--batch" "--eval" check-cmd)))
    (set-process-filter
     proc
     (lambda (proc line)
       (setq error-msgs (append error-msgs (list line)))
       (when (eq 2 (length (split-string line "42")))
         (setq safe-to-quit? t))))
    proc))

(setq confirm-kill-emacs
      (lambda (&rest _)
        (setq safe-to-quit? nil
              error-msgs nil)
        (message "Checking if safe to quit Emacs...")
        (let ((proc (bk/verify-if-emacs-config-is-in-good-shape)))
          (while (process-live-p proc)
            (sit-for 0.1))
          (if (not safe-to-quit?)
              (progn
                (prin1 "\n\n")
                (print "*EmacsQuitCheck* ==== START ========")
                (print (string-join error-msgs))
                (print "*EmacsQuitCheck* ==== END ==========")
                (prin1 "\n\n")
                (yes-or-no-p "Init file with problems, see *Message* buffer. Really quit Emacs? "))
            t))))

;; disable the idea above
(setq confirm-kill-emacs nil)

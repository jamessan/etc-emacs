(dolist (bind '(
                (2 32  (kbd "S-SPC"))
                (5 32  [?\C-\ ])
                (6 32  (kbd "C-S-SPC"))
                (2 27  (kbd "S-ESC"))
                (5 27  (kbd "C-ESC"))
                (6 27  (kbd "C-S-ESC"))

                (2 13  [\S-return])

                (5 91  [?\C-\[])

                (5 9   (kbd "C-TAB"))))
  (define-key input-decode-map
    (format "\e[%d;%du" (nth 1 bind) (nth 0 bind)) (nth 2 bind)))
(define-key input-decode-map "\e[Z" (kbd "S-TAB"))
(define-key input-decode-map "\e[1;6Z" (kbd "C-S-TAB"))

(provide 'CSIu)

; Settings specific for work projects
(add-hook 'dtrt-indent-mode-hook
          (lambda ()
            (when (and (buffer-file-name)
                       (string-match "safe/catmerge" (buffer-file-name)))
              (c-set-style "stroustrup")
              (setq indent-tabs-mode t)
              (setq tab-width 4)
              (setq c-basic-offset 4))))

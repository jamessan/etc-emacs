; Show column numbers in the mode line
(column-number-mode 1)
(setq backup-inhibited t)

; Enable uniquify for better buffer names
(setq uniquify-buffer-name-style 'post-forward)
(require 'uniquify)

(when (display-graphic-p)
  ; Disable user of the toolbar
  (tool-bar-mode 0)
  ; Disable use of the scrollbar
  (scroll-bar-mode 0))
; Always disable the menu bar.  It can be accessed via hotkeys, if needed
(menu-bar-mode 0)

; Default indent of 4 spaces
(setq-default c-basic-offset 4)
; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
; Show bad whitespace by default
(setq-default show-trailing-whitespace t)

; Just in case it's not already installed system-wide
(when (and (not (require 'color-theme nil t))
           (file-exists-p (expand-file-name "~/.emacs.d/color-theme")))
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/color-theme")))
(require 'color-theme)
(eval-after-load 'color-theme
  ; Newer versions of color-theme require calling this initialize function first
  '(progn
     (when (functionp 'color-theme-initialize)
       (color-theme-initialize))
     (let (f (framep (selected-frame)))
       (if (eq f 'w32)
           (color-theme-comidia)
         (color-theme-calm-forest)))))

; Prefer CPerl
(defalias 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook
          (lambda ()
            (setq cperl-indent-level 4
                  cperl-close-paren-offset -4
                  cperl-continued-statement-offset 0
                  cperl-indent-parens-as-block t)))
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)

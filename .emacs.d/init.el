; Show column numbers in the mode line
(column-number-mode 1)
(setq backup-inhibited t)

; Enable uniquify for better buffer names
(setq uniquify-buffer-name-style 'post-forward)
(require 'uniquify)

(load-file "~/.emacs.d/bindings.el")
(load-file "~/.emacs.d/enablers.el")

(when (display-graphic-p)
  ; Disable user of the toolbar
  (tool-bar-mode 0)
  ; Disable use of the scrollbar
  (scroll-bar-mode 0))
; Always disable the menu bar.  It can be accessed via hotkeys, if needed
(menu-bar-mode 0)

(setq inhibit-startup-screen t)

; Default indent of 4 spaces
(setq-default c-basic-offset 4)
; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
; Show bad whitespace by default
(setq-default show-trailing-whitespace t)
(eval-after-load "c-mode"
  '(progn
     (add-to-list c-default-style (cons c-mode "k&r"))
     (add-to-list c-default-style (cons c++-mode "stroustrup"))))

; Auto-detect indent settings
(add-to-list 'load-path (expand-file-name "~/.emacs.d/dtrt-indent"))
(require 'dtrt-indent)
; Only require 50% more lines for 2nd best guess over 1st guess
(setq-default dtrt-indent-min-indent-superiority 50.0)
(dtrt-indent-mode t)

; Just in case it's not already installed system-wide
(when (not (require 'color-theme nil t))
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/color-theme")))
(require 'color-theme)
; Newer versions of color-theme require calling this initialize function first
(when (functionp 'color-theme-initialize)
  (color-theme-initialize))
(let (f (framep (selected-frame)))
  (if (eq f 'w32)
      (color-theme-comidia)
    (color-theme-calm-forest)))

; Prefer CPerl
(defalias 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook
          (lambda ()
            (setq cperl-indent-level 4
                  cperl-close-paren-offset -4
                  cperl-continued-statement-offset 0
                  cperl-indent-parens-as-block t)))

(let ((case-fold-search t))
  (when (string-match "mccoyj1" (user-login-name))
    (load-file "~/.emacs.d/work.el")))

(defun command-line-3way-merge (switch)
  (let ((ancestor (pop command-line-args-left))
        (file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left))
        (output (pop command-line-args-left)))
    (ediff-merge-with-ancestor file1 file2 ancestor nil output)))
(add-to-list 'command-switch-alist '("-3way-merge" . command-line-3way-merge))

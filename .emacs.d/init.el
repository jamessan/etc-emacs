(setq backup-inhibited t)

; Enable uniquify for better buffer names
(setq uniquify-buffer-name-style 'post-forward)
(require 'uniquify)

(load (locate-user-emacs-file "bindings.el"))
(load (locate-user-emacs-file "enablers.el"))

;; UI
(dolist (mode '(tool-bar-mode scroll-bar-mode menu-bar-mode blink-cursor-mode))
  (when (fboundp mode) (funcall mode -1)))
(column-number-mode 1)
(load-theme 'wombat)

(setq inhibit-startup-screen t)

; Default indent of 4 spaces
(setq-default c-basic-offset 4)
; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
; Show bad whitespace by default
(setq-default show-trailing-whitespace t)

(eval-after-load "cc-mode"
  '(progn
     (add-to-list 'c-default-style (cons 'c-mode "k&r"))
     (add-to-list 'c-default-style (cons 'c++-mode "stroustrup"))))

; Auto-detect indent settings
(add-to-list 'load-path (locate-user-emacs-file "dtrt-indent"))
(require 'dtrt-indent)
; Only require 50% more lines for 2nd best guess over 1st guess
(setq-default dtrt-indent-min-indent-superiority 50.0)
(dtrt-indent-mode t)


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
    (load (locate-user-emacs-file "work.el"))))

(defun command-line-3way-merge (switch)
  (let ((ancestor (pop command-line-args-left))
        (file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left))
        (output (pop command-line-args-left)))
    (ediff-merge-with-ancestor file1 file2 ancestor nil output)))
(add-to-list 'command-switch-alist '("-3way-merge" . command-line-3way-merge))

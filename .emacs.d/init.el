;; Annoyances
(setq backup-inhibited t)
(setq inhibit-startup-screen t)

; Enable uniquify for better buffer names
(setq uniquify-buffer-name-style 'post-forward)
(require 'uniquify)

(load (locate-user-emacs-file "bindings.el"))
(load (locate-user-emacs-file "enablers.el"))
(add-to-list 'load-path (locate-user-emacs-file "lisp"))
(add-to-list 'load-path (locate-user-emacs-file "dtrt-indent"))
(add-to-list 'load-path (locate-user-emacs-file "diff-hl"))

(let ((case-fold-search t))
  (when (string-match "mccoyj1" (user-login-name))
    (load (locate-user-emacs-file "work.el"))))

;; UI
(dolist (mode '(tool-bar-mode scroll-bar-mode menu-bar-mode blink-cursor-mode))
  (when (fboundp mode) (funcall mode -1)))
(add-to-list 'default-frame-alist
             '(font . "monospace-10"))
(column-number-mode 1)
(load-theme 'wombat)
(require 'diff-hl)
(global-diff-hl-mode)
(unless (window-system)
  (require 'CSIu)
  (require 'diff-hl-margin)
  (diff-hl-margin-mode))

;; whitespace
(setq-default c-basic-offset 4
              indent-tabs-mode nil
              indicate-unused-lines t
              whitespace-style '(face tabs trailing newline space-before-tab::tab))

;; Programming
(eval-after-load "cc-mode"
  '(progn
     (add-to-list 'c-default-style (cons 'c-mode "k&r"))
     (add-to-list 'c-default-style (cons 'c++-mode "stroustrup"))))
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-offset 'case-label '+)))
(add-hook 'prog-mode-hook 'show-paren-mode)
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'dtrt-indent-mode)

(autoload 'dtrt-indent-mode "dtrt-indent" nil 'interactive)
(setq-default dtrt-indent-min-indent-superiority 50.0)

;; Prefer CPerl
(defalias 'perl-mode 'cperl-mode)
(add-hook 'cperl-mode-hook
          (lambda ()
            (setq cperl-close-paren-offset -4
                  cperl-continued-statement-offset 0
                  cperl-indent-parens-as-block t)))

(defun command-line-3way-merge (switch)
  (let ((ancestor (pop command-line-args-left))
        (file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left))
        (output (pop command-line-args-left)))
    (ediff-merge-with-ancestor file1 file2 ancestor nil output)))
(add-to-list 'command-switch-alist '("-3way-merge" . command-line-3way-merge))

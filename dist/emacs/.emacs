(setq
 my-packages
 '(
   fill-column-indicator
   smex
   ido-vertical-mode
   tangotango-theme
   markdown-mode
   )
 )
(setq package-archives '(("melpa" . "http://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))
(defun tidy ()
  "Ident, untabify and unwhitespacify current buffer, or region if active."
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end)       (point-max))))
    (whitespace-cleanup)
    (indent-region beg end nil)
    (untabify beg end)))
(defun remove-whitespace ()
  "Removes whitespace."
  (interactive)
  (just-one-space -1))
(require 'recentf)
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((f (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when f
      (find-file f))))
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))
(load-theme 'tangotango t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(global-linum-mode 0)
(show-paren-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(delete-selection-mode 1)
(setq column-number-mode t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq split-width-threshold 0
   split-height-threshold nil)
(setq-default fill-column 80                   ; Maximum line width.
              indent-tabs-mode nil             ; Use spaces instead of tabs.
              split-width-threshold 100        ; Split verticly by default.
              auto-fill-function 'do-auto-fill ; Auto-fill-mode everywhere.
           )
(require 'fill-column-indicator)
(add-hook 'after-change-major-mode-hook
       '(lambda ()
          (setq fci-rule-column 80)
          (fci-mode)))
(setq display-time-day-and-date t
   display-time-24hr-format t)
(setq display-time-format " [%d.%h %H:%M] ")
(display-time)
(require 'battery)
(when (and battery-status-function
           (not (string-match-p "N/A" 
                                (battery-format "%B"
                                                (funcall battery-status-function)))))
  (display-battery-mode 1))
(dolist (mode
         '(ido-mode                   ; Interactivly do.
           ido-everywhere             ; Use Ido for all buffer/file reading.
           ido-vertical-mode          ; Makes ido-mode display vertically.
           ))
  (funcall mode 1))

(setq ido-file-extensions-order
      '(".el" ".scm" ".lisp" ".java" ".c" ".h" ".org" ".tex"))

(add-to-list 'ido-ignore-buffers "*Messages*")

(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(defvar emacs-autosave-directory (concat user-emacs-directory "autosaves/"))
(setq backup-directory-alist
      `((".*" . ,emacs-autosave-directory))
      auto-save-file-name-transforms
      `((".*" ,emacs-autosave-directory t)))
(desktop-save-mode 1)
(setq desktop-dirname user-emacs-directory
      desktop-path (list desktop-dirname)
      desktop-save t
      desktop-base-file-name ".emacs.desktop")
;(require 'auto-complete-config)
;(ac-config-default)
;(global-auto-complete-mode t) 
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-x t") 'switch-to-shell)
;(key-chord-mode 1)
;(key-chord-define-global ";'" 'ace-jump-mode)
(global-set-key (kbd "C-c j") 'remove-whitespace)
(global-set-key (kbd "<M-left>")
                (lambda () (interactive)
                  (enlarge-window -1 t)))
(global-set-key (kbd "<M-right>")
                (lambda () (interactive)
                  (enlarge-window 1 t)))
(global-set-key (kbd "<M-up>")
                (lambda () (interactive)
                  (enlarge-window -1)))
(global-set-key (kbd "<M-down>")
                (lambda () (interactive)
                  (enlarge-window 1)))
(define-key global-map (kbd "C-x C-r") 'recentf-ido-find-file)
(global-set-key (kbd "<C-tab>")  'tidy)
(autoload 'markdown-mode "markdown-mode.el" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
(autoload 'gfm-mode "markdown-mode" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

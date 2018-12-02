# Emacs

## Dependencies

Packages to install
```lisp tangle:~/.emacs
(setq
 my-packages
 '(
   fill-column-indicator
   smex
   ido-vertical-mode
   tangotango-theme
   )
 )
```

Add repositories:
```lisp tangle:~/.emacs
(setq package-archives '(("melpa" . "http://melpa.org/packages/")))
```

Other available repositories are:
- `("elpa" . "http://tromey.com/elpa/")`
- `("org" . "http://orgmode.org/elpa/")`
- `("gnu" . "http://elpa.gnu.org/packages/")`
- `("marmalade" . "http://marmalade-repo.org/packages/")`

Activate all the packages
```lisp tangle:~/.emacs
(package-initialize)
```

Fetch the list of packages available 
```lisp tangle:~/.emacs
(unless package-archive-contents
  (package-refresh-contents))
```

Install the missing packages
```lisp tangle:~/.emacs
(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))
```

## Functions

### Tidy
Author: [simenheg](https://github.com/simenheg)

Defining a function that sets the right indentation to the marked text, or
the entire buffer if no text is selected.

```lisp tangle:~/.emacs
(defun tidy ()
  "Ident, untabify and unwhitespacify current buffer, or region if active."
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end)       (point-max))))
    (whitespace-cleanup)
    (indent-region beg end nil)
    (untabify beg end)))
```

### Remove whitespace 
Author: [larstvei](https://github.com/larstvei) 

Removes whitespace

```lisp tangle:~/.emacs
(defun remove-whitespace ()
  "Removes whitespace."
  (interactive)
  (just-one-space -1))
```

### Recently viewed files
From: [EmacsWiki](http://www.emacswiki.org/emacs/CalendarWeekNumbers)

```lisp tangle:~/.emacs
(require 'recentf)
(defun recentf-ido-find-file ()
  "Find a recent file using Ido."
  (interactive)
  (let ((f (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when f
      (find-file f))))
```

## Looks and feels

### Font
```lisp tangle:~/.emacs
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8-unix)

;; set a default font
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

;; specify font for all unicode characters
(when (member "Symbola" (font-family-list))
  (set-fontset-font t 'unicode "Symbola" nil 'prepend))

```

### Theme
```lisp tangle:~/.emacs
(load-theme 'tangotango t)
```

### Editor

Remove splash screen
```lisp tangle:~/.emacs
(setq inhibit-splash-screen t)
```

Remove \*scratch\* message
```lisp tangle:~/.emacs
(setq initial-scratch-message nil)
```

Hide line numbers
```lisp tangle:~/.emacs
(global-linum-mode 0)
```

Highlight parenteses-pair
```lisp tangle:~/.emacs
(show-paren-mode t)
```

Yes-or-no -> y-or-n  
```lisp tangle:~/.emacs
(fset 'yes-or-no-p 'y-or-n-p)
```

Marked text wil be overwritten
```lisp tangle:~/.emacs
(delete-selection-mode 1)
```

Column numbers -> show
```lisp tangle:~/.emacs
(setq column-number-mode t)
```

Hide tool bar
```lisp tangle:~/.emacs
(tool-bar-mode -1)
```

Hide scroll bar
```lisp tangle:~/.emacs
(scroll-bar-mode -1)
```

Hide menu bar
```lisp tangle:~/.emacs
(menu-bar-mode -1)
```

Split window vertically
```lisp tangle:~/.emacs
(setq split-width-threshold 0
   split-height-threshold nil)
```

Automatically end line when 'full'
```lisp tangle:~/.emacs
(setq-default fill-column 80                   ; Maximum line width.
              indent-tabs-mode nil             ; Use spaces instead of tabs.
              split-width-threshold 100        ; Split verticly by default.
              auto-fill-function 'do-auto-fill ; Auto-fill-mode everywhere.
           )
```

Show vertical line marking the 80 character mark.
```lisp tangle:~/.emacs
(require 'fill-column-indicator)
(add-hook 'after-change-major-mode-hook
       '(lambda ()
          (setq fci-rule-column 80)
          (fci-mode)))
```

### Status bar

#### Show date and time
```lisp tangle:~/.emacs
(setq display-time-day-and-date t
   display-time-24hr-format t)
(setq display-time-format " [%d.%h %H:%M] ")
(display-time)
```

#### Display battery status (when available)
```lisp tangle:~/.emacs
(require 'battery)
(when (and battery-status-function
           (not (string-match-p "N/A" 
                                (battery-format "%B"
                                                (funcall battery-status-function)))))
  (display-battery-mode 1))
```

#### Functional and fast file access with IDO and Smex interface

Ido mode
```lisp tangle:~/.emacs
(dolist (mode
         '(ido-mode                   ; Interactivly do.
           ido-everywhere             ; Use Ido for all buffer/file reading.
           ido-vertical-mode          ; Makes ido-mode display vertically.
           ))
  (funcall mode 1))

(setq ido-file-extensions-order
      '(".el" ".scm" ".lisp" ".java" ".c" ".h" ".org" ".tex"))

(add-to-list 'ido-ignore-buffers "*Messages*")
```

Smex
```lisp tangle:~/.emacs

(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
```

This is our old M-x.
```lisp tangle:~/.emacs
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
```

## Autosaves
Change autosave directory.

```lisp tangle:~/.emacs
(defvar emacs-autosave-directory (concat user-emacs-directory "autosaves/"))
(setq backup-directory-alist
      `((".*" . ,emacs-autosave-directory))
      auto-save-file-name-transforms
      `((".*" ,emacs-autosave-directory t)))
```

## Restore previous session
Automatically save and restore sessions

Change location for session save file (.emacs.desktop) and enables
desktop-save-mode.

```lisp tangle:~/.emacs
(desktop-save-mode 1)
```

Use only one desktop.
```lisp tangle:~/.emacs
(setq desktop-dirname user-emacs-directory
      desktop-path (list desktop-dirname)
      desktop-save t
      desktop-base-file-name ".emacs.desktop")
```

## Autocomplete
```lisp tangle:~/.emacs
;(require 'auto-complete-config)
;(ac-config-default)
;(global-auto-complete-mode t) 
```

## Keybindings

Kill current buffer
```lisp tangle:~/.emacs
(global-set-key (kbd "C-x k") 'kill-this-buffer)
```

Shell (terminal)
```lisp tangle:~/.emacs
(global-set-key (kbd "C-x t") 'switch-to-shell)
```

Jump to 'bla'
```lisp tangle:~/.emacs
;(key-chord-mode 1)
;(key-chord-define-global ";'" 'ace-jump-mode)
```

Remove whitespace 
```lisp tangle:~/.emacs
(global-set-key (kbd "C-c j") 'remove-whitespace)
```

Resize buffers
```lisp tangle:~/.emacs
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
```

Recently viewed files
```lisp tangle:~/.emacs
(define-key global-map (kbd "C-x C-r") 'recentf-ido-find-file)
```

Tidy
```lisp tangle:~/.emacs
(global-set-key (kbd "<C-tab>")  'tidy)
```

## Programming-language-modes specifics

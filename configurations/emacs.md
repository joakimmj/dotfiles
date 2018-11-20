# Emacs

## Looks and feels

### Sane defaults
Remove splash screen
```lisp tangle:~/.emacs
(setq inhibit-splash-screen t)
```

Remove \*scratch\* message
```lisp tangle:~/.emacs
(setq initial-scratch-message nil)
```

Line numbers -> hide
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

Tool bar -> hide
```lisp tangle:~/.emacs
(tool-bar-mode -1)
```

Scroll bar -> hide
```lisp tangle:~/.emacs
(scroll-bar-mode -1)
```

Menu bar -> hide
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

Show date and time
```lisp tangle:~/.emacs
(setq display-time-day-and-date t
   display-time-24hr-format t)
(setq display-time-format " [%d.%h %H:%M] ")
(display-time)
```

Display battery status (when available)
```lisp tangle:~/.emacs
(require 'battery)
(when (and battery-status-function
           (not (string-match-p "N/A" 
                                (battery-format "%B"
                                                (funcall battery-status-function)))))
  (display-battery-mode 1))
```

Mark column number 80
```lisp tangle:~/.emacs
;(require 'fill-column-indicator)
;(add-hook 'after-change-major-mode-hook
;       '(lambda ()
;          (setq fci-rule-column 80)
;          (fci-mode)))
```

Functional and fast file access with IDO and Smex interface
```lisp tangle:~/.emacs
(dolist (mode
         '(ido-mode                   ; Interactivly do.
           ido-everywhere             ; Use Ido for all buffer/file reading.
          ;ido-vertical-mode          ; Makes ido-mode display vertically.
          ;flx-ido-mode               ; Toggle flx ido mode.
           ))
  (funcall mode 1))

(setq ido-file-extensions-order
      '(".el" ".scm" ".lisp" ".java" ".c" ".h" ".org" ".tex"))

(add-to-list 'ido-ignore-buffers "*Messages*")

;(smex-initialize)
;(global-set-key (kbd "M-x") 'smex)
```

### Autosaves
Change autosave directory.

```lisp tangle:~/.emacs
(defvar emacs-autosave-directory (concat user-emacs-directory "autosaves/"))
(setq backup-directory-alist
      `((".*" . ,emacs-autosave-directory))
      auto-save-file-name-transforms
      `((".*" ,emacs-autosave-directory t)))
```

### Restore previous session
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

### Autocomplete
```lisp tangle:~/.emacs
;(require 'auto-complete-config)
;(ac-config-default)
;(global-auto-complete-mode t) 
```

### Font
```lisp tangle:~/.emacs
(when (member "Inconsolata" (font-family-list))
  (set-face-attribute 'default nil :font "Inconsolata-11"))
```

### Theme
```lisp tangle:~/.emacs
(load-theme 'tango-dark t)
```

### Keybindings

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
;(define-key global-map (kbd "C-x C-r") 'recentf-ido-find-file)
```

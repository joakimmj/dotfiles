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
   markdown-mode
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
```

Set a default font
```lisp tangle:~/.emacs
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))
```

Specify font for all unicode characters
```lisp tangle:~/.emacs
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

### Markdown

Major mode for editing Markdown files
```lisp tangle:~/.emacs
(autoload 'markdown-mode "markdown-mode.el" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . markdown-mode))
```

Major mode for editing GitHub Flavored Markdown files
```lisp tangle:~/.emacs
(autoload 'gfm-mode "markdown-mode" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
```

### Java

*not included in config*
```lisp
;; adding shortcuts to java-mode, writing the shortcut folowed by a
;; non-word character will cause an expansion.
(defun java-shortcuts ()
  (define-abbrev-table 'java-mode-abbrev-table
    '(("psv" "public static void main(String[] args) {" nil 0)
      ("sop" "System.out.printf" nil 0)
      ("sopl" "System.out.println" nil 0)))
  (abbrev-mode t))

;; the shortcuts are only useful in java-mode so we'll load them to
;; java-mode-hook.
(add-hook 'java-mode-hook 'java-shortcuts)

;; we want to set a default compile-command for java-mode, we make
;; this variable buffer-local so that changing it for java-mode does
;; not effect other modes
(make-variable-buffer-local 'compile-command)

;; defining a function that guesses a compile command and bindes the
;; compile-function to C-c C-c
(defun compile-java ()
  (setq compile-command (concat "javac " (buffer-name)))
  (local-set-key (kbd "C-c C-c") 'compile))

;; this is a java-spesific function, so we only load it when entering
;; java-mode
(add-hook 'java-mode-hook 'compile-java)

;;(autoload 'java-extras "java-extras" "Fold brackets")
;;(add-hook 'java-mode-hook 'java-extras)
```

### C

*not included in config*
```lisp
;;(load-library "hideshow-on")

;; defining a function that sets more accessible keyboard-bindings to
;; hiding/showing code-blocs
(defun hideshow-on ()
  (local-set-key (kbd "C-c <right>") 'hs-show-block)
  (local-set-key (kbd "C-c C-<right>") 'hs-show-block)
  (local-set-key (kbd "C-c <left>")  'hs-hide-block)
  (local-set-key (kbd "C-c C-<left>")  'hs-hide-block)
  (local-set-key (kbd "C-c <up>")    'hs-hide-all)
  (local-set-key (kbd "C-c C-<up>")    'hs-hide-all)
  (local-set-key (kbd "C-c <down>")  'hs-show-all)
  (local-set-key (kbd "C-c C-<down>")  'hs-show-all)
  (hs-minor-mode t))

;; now we have to tell emacs where to load these functions. Showing
;; and hiding codeblocks could be useful for all c-like programming
;; (java is c-like) languages, so we add it to the c-mode-common-hook.
(add-hook 'c-mode-common-hook 'hideshow-on)
```

### Lisp

*not included in config*
```lisp
;; Show λ in Lisp code.
(defun sm-lambda-mode-hook ()
  (font-lock-add-keywords
   nil `(("\\<lambda\\>"
          (0 (progn (compose-region (match-beginning 0) (match-end 0)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))
(dolist (h '(lisp-mode-hook
             scheme-mode-hook
             emacs-lisp-mode-hook
             slime-repl-mode-hook
             inferior-lisp-mode-hook
             inferior-scheme-mode-hook
             lisp-interaction-mode-hook))
  (progn
    (add-hook h (lambda () (paredit-mode 1)))
    (add-hook h 'sm-lambda-mode-hook)))

(when (file-exists-p "~/.quicklisp/slime-helper.el")
  (load (expand-file-name "~/.quicklisp/slime-helper.el")))

(setq inferior-lisp-program "sbcl")

(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(add-hook 'lisp-mode-hook
          (lambda ()
            (let ((buf (current-buffer)))
              (when (or (string-match-p ".*.lisp$" (buffer-name buf))
                        (string-match-p ".*.lsp$" (buffer-name buf)))
                (if (member "*inferior-lisp*"
                            (mapcar 'buffer-name (buffer-list)))
                    (switch-to-buffer-other-window "*slime-repl sbcl*")
                  (slime)))
              (switch-to-buffer-other-window buf))))

(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))
```

###  Scheme

*not included in config*
```lisp
(require 'quack)

(autoload 'scheme-smart-complete "scheme-complete" nil t)
(eval-after-load 'scheme
  '(define-key scheme-mode-map "\t" 'scheme-complete-or-indent))
(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(add-hook 'scheme-mode-hook
          (lambda ()
            (make-local-variable 'eldoc-documentation-function)
            (setq eldoc-documentation-function
                  'scheme-get-current-symbol-info)
            (eldoc-mode)))

(setq scheme-program-name "csi -:c")
(setq quack-default-program "csi")
;;(setq scheme-program-name "racket -:c")
;;(setq quack-default-program "racket")
```

### Python

*not included in config*
```lisp
(require 'jedi)
(setq jedi:server-command
      (cons "python3" (cdr jedi:server-command))
      python-shell-interpreter "python3")
(add-hook 'python-mode-hook 'jedi:ac-setup)
```

### HTML

*not included in config*
```lisp
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags
      '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
        (js-mode  "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
        (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)
```

### LaTeX and org-mode LaTeX export

*not included in config*
```lisp

```



### 

*not included in config*
```lisp

```



### 

*not included in config*
```lisp

```


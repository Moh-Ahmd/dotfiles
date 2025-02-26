;; initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
            ("melpa-stable" . "https://stable.melpa.org/packages/")
            ("org" . "https://orgmode.org/elpa/")
            ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
(package-refresh-contents))

;; initialize use-package on non-linux platforms
(unless (package-installed-p 'use-package)
(package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Ensure Emacs inherits shell environment
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(setq-default
 cursor-in-non-selected-windows nil               ; Hide the cursor in inactive windows
 fill-column 80                                   ; Set width for automatic line breaks
 help-window-select t                             ; Focus new help windows when opened
 initial-scratch-message " "                      ; Empty the initial *scratch* buffer
 read-process-output-max (* 1024 1024)            ; Increase the amount of data reads from the process
 scroll-conservatively most-positive-fixnum       ; Always scroll by one line
 select-enable-clipboard t                        ; Merge system's and Emacs' clipboard
 tab-width 4                                      ; Set width for tabs
 use-package-always-ensure t                      ; Avoid the :ensure keyword for each package
 vc-follow-symlinks t                             ; Always follow the symlinks
 view-read-only t)                                ; Always open read-only buffers in view-mode
(column-number-mode 1)                            ; Show the column number
(fset 'yes-or-no-p 'y-or-n-p)                     ; Replace yes/no prompts with y/n
(global-hl-line-mode)                             ; Hightlight current line
(set-default-coding-systems 'utf-8)               ; Default to utf-8 encoding
(setq inhibit-startup-message t)
(scroll-bar-mode -1)      ; Disable visible scrollbar
(tool-bar-mode -1)        ; Disable the tool bar
(tooltip-mode -1)         ; Disable tooltips
(set-fringe-mode 10)      ; Give some breathing room
(menu-bar-mode -1)        ; Disable the menu bar
(setq visible-bell t)     ; Set up the visible bell



(column-number-mode)
(global-display-line-numbers-mode)

;; Enable relative line numbers
(setq display-line-numbers-type 'relative)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                treemacs-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Frame Transparency (Active & Inactive)
(setq mohmak/frame-transparency 50)  ; Active: 90%, Inactive: 90%
(set-frame-parameter (selected-frame) 'alpha-background mohmak/frame-transparency)
(add-to-list 'default-frame-alist `(alpha-background . ,mohmak/frame-transparency))

;; Start Maximized (or use 'fullscreen for true fullscreen)
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Ensure settings apply to new frames
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (select-frame frame)
            (set-frame-parameter frame 'alpha-background mohmak/frame-transparency)
            (set-frame-parameter frame 'fullscreen 'maximized)))

;; Fonts

;; You will most likely need to adjust this font size for your system!
(defvar mohmak/default-font-size 130)
(defvar mohmak/default-variable-font-size 130)



(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height mohmak/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font" :height mohmak/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height mohmak/default-variable-font-size :weight 'regular)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :init (load-theme 'kanagawa-wave t))

;; Install and load Gruvbox theme
;(use-package gruvbox-theme
;  :ensure t
;  :config
;  (load-theme 'gruvbox-dark-hard t))  ;; Or any other variant

;; Install required packages
(unless (package-installed-p 'dashboard)
  (package-install 'dashboard))
(require 'all-the-icons)
;; Configure dashboard
(require 'dashboard)
(dashboard-setup-startup-hook)

(setq dashboard-items '((recents  . 10)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))

;; Set dashboard theme (choose one)
(setq dashboard-startup-banner 'official)  ; Emacs logo
;; (setq dashboard-startup-banner 3)       ; Text banner
;; (setq dashboard-set-heading-icons t)
;; (setq dashboard-set-file-icons t)

;; Customize dashboard appearance
(setq dashboard-center-content t
      dashboard-show-shortcuts t
      dashboard-set-navigator t)

;; Projectile integration
(require 'projectile)
(projectile-mode +1)
(setq dashboard-projectile-backend 'projectile)
;; Show dashboard on startup
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

(unless (package-installed-p 'treemacs)
  (package-install 'treemacs))
;; Treemacs configuration
(require 'treemacs)

(setq treemacs-width 35
      treemacs-position 'left
      treemacs-filewatch-mode t
      treemacs-follow-mode t)

;; Key bindings
(global-set-key (kbd "C-c t") #'treemacs)

;; Keybindings

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)



;; evil-mode for vim key-bindings

(defun mohmak/evil-hook ()
  (dolist (mode '(custom-mode
		  eshell-mode
		  git-rebase-mode
		  erc-mode
		  circe-server-mode
		  circe-chat-mode
		  circe-query-mode
		  sauron-mode
		  term-mode))
    (add-to-list 'evil-emacs-state-modes mode)))


(use-package evil 
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :hook (evil-mode . mohmak/evil-hook)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init '(magit)))

;; The general package in Emacs provides a unified and flexible way to define keybindings
;; to manage and organize keybindings across different modes and contexts.
(use-package general
  :config
  (general-create-definer mohmak/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  ;; All keybindings go here
  (mohmak/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "ts" '(hydra-text-scale/body :which-key "scale-text")))

(with-eval-after-load 'dap-mode
  ;; Custom Keybindings
  (define-key dap-mode-map (kbd "C-c d") 'dap-debug)          ; Start debugger
  (define-key dap-mode-map (kbd "C-c t") 'dap-breakpoint-toggle) ; Toggle breakpoint
  (define-key dap-mode-map (kbd "C-c i") 'dap-step-in)           ; Step into
  (define-key dap-mode-map (kbd "C-c o") 'dap-step-out)          ; Step out
  (define-key dap-mode-map (kbd "C-c sn") 'dap-next)              ; Next line
  (define-key dap-mode-map (kbd "C-q s") 'dap-disconnect)      ; End session
  ;; Improved cleanup function
  (defun mohmak/dap-close-debug-buffers (&rest _)
    "Kill all DAP-related buffers starting with *dap-*."
    (interactive)
    (dolist (buffer (buffer-list))
      (when (string-match-p "\\`\\*dap-.*\\*\\'" (buffer-name buffer))
        (kill-buffer buffer))))
  ;; Hook to clean up buffers when debug session ends
  (add-hook 'dap-terminated-hook #'mohmak/dap-close-debug-buffers)
  (add-hook 'dap-disconnected-hook #'mohmak/dap-close-debug-buffers))

(use-package command-log-mode)

(use-package all-the-icons)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-x b" . counsel-ibuffer)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package hydra)
;; Define hydras/functions BEFORE they are referenced
(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(defun mohmak/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . mohmak/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

;(use-package flycheck
;  :delight
;  :hook (lsp-mode . flycheck-mode)
;  :bind (:map flycheck-mode-map
;              ("M-'" . flycheck-previous-error)
;              ("M-\\" . flycheck-next-error))
;  :custom (flycheck-display-errors-delay .3))

(use-package flycheck
  :delight
  :hook (lsp-mode . flycheck-mode)
  :bind (:map flycheck-mode-map
              ("M-'" . flycheck-previous-error)
              ("M-\\" . flycheck-next-error))
  :custom
  (flycheck-display-errors-delay .3)
  ;; Add these new customizations
  (flycheck-python-pycompile-executable "python3")  ; Will be overridden by pyvenv hook
  (flycheck-python-pylint-executable "pylint"))     ; Will be overridden by pyvenv hook

;; Org-mode font setup
(defun mohmak/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.4)
                  (org-level-2 . 1.3)
                  (org-level-3 . 1.2)
                  (org-level-4 . 1.1)
                  (org-level-5 . 1.0)
                  (org-level-6 . 1.0)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))
  ;; Ensure fixed-pitch for certain elements
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))
;; Visual fill column setup
(defun mohmak/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))
;; Org-mode setup
(defun mohmak/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil)
  (mohmak/org-font-setup)
  (mohmak/org-mode-visual-fill))
(add-hook 'org-mode-hook 'mohmak/org-mode-setup)
(add-hook 'org-mode-hook 'org-display-inline-images)
;; Org-mode and org-bullets configuration
(use-package org
  :hook (org-mode . mohmak/org-font-setup)
  :config
  (setq org-ellipsis " ▾")


  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/OrgFiles/Tasks.org"
		  "~/OrgFiles/Habits.org"
          "~/OrgFiles/Birthdays.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
          (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  
  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
        '((:startgroup)
                                        ; Put mutually exclusive tags here
          (:endgroup)
          ("@errand" . ?E)
          ("@home" . ?H)
          ("@work" . ?W)
          ("agenda" . ?a)
          ("planning" . ?p)
          ("publish" . ?P)
          ("batch" . ?b)
          ("note" . ?n)
          ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
        '(("d" "Dashboard"
           ((agenda "" ((org-deadline-warning-days 7)))
            (todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))
            (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

          ("n" "Next Tasks"
           ((todo "NEXT"
                  ((org-agenda-overriding-header "Next Tasks")))))

          ("W" "Work Tasks" tags-todo "+work-email")

          ;; Low-effort next actions
          ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
           ((org-agenda-overriding-header "Low Effort Tasks")
            (org-agenda-max-todos 20)
            (org-agenda-files org-agenda-files)))

          ("w" "Workflow Status"
           ((todo "WAIT"
                  ((org-agenda-overriding-header "Waiting on External")
                   (org-agenda-files org-agenda-files)))
            (todo "REVIEW"
                  ((org-agenda-overriding-header "In Review")
                   (org-agenda-files org-agenda-files)))
            (todo "PLAN"
                  ((org-agenda-overriding-header "In Planning")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "BACKLOG"
                  ((org-agenda-overriding-header "Project Backlog")
                   (org-agenda-todo-list-sublevels nil)
                   (org-agenda-files org-agenda-files)))
            (todo "READY"
                  ((org-agenda-overriding-header "Ready for Work")
                   (org-agenda-files org-agenda-files)))
            (todo "ACTIVE"
                  ((org-agenda-overriding-header "Active Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "COMPLETED"
                  ((org-agenda-overriding-header "Completed Projects")
                   (org-agenda-files org-agenda-files)))
            (todo "CANC"
                  ((org-agenda-overriding-header "Cancelled Projects")
                   (org-agenda-files org-agenda-files)))))))

  ;; Capture templates
  (setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/OrgFiles/Tasks.org" "Active")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/OrgFiles/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Meeting" entry
           (file+olp+datetree "~/OrgFiles/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

      ("w" "Workflows")
      ("we" "Checking Email" entry (file+olp+datetree "~/OrgFiles/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

      ("m" "Metrics Capture")
      ("mw" "Weight" table-line (file+headline "~/OrgFiles/Metrics.org" "Weight")
       "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  (mohmak/org-font-setup))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))


(use-package visual-fill-column
  :hook (org-mode . mohmak/org-mode-visual-fill))

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (C . t))))

;; Automatically tangle our Emacs.org config file when we save it
(defun mohmak/org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.emacs.d/Emacs.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'mohmak/org-babel-tangle-config)))

(defun mohmak/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . mohmak/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package consult-lsp
  :commands (consult-lsp-diagnostics consult-lsp-symbols))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-code-actions t))

(use-package lsp-treemacs
  :after lsp)

; (use-package corfu
;   :init
;   (global-corfu-mode)
;   (corfu-history-mode)
;   (corfu-popupinfo-mode)
;   :custom
;   (corfu-auto t)
;   (corfu-cycle t)
;   (corfu-quit-no-match 'separator))
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0.5)
  (company-minimum-prefix-length 1)
  (company-show-quick-access t)
  (company-tooltip-align-annotations 't))

(use-package company-box
  :if (display-graphic-p)
  :after company
  :hook (company-mode . company-box-mode))

(use-package yasnippet-snippets
  :after yasnippet
  :config (yasnippet-snippets-initialize))
(use-package yasnippet
  :delight yas-minor-mode "υ"
  :hook (yas-minor-mode . mohmak/disable-yas-if-no-snippets)
  :config (yas-global-mode)
  :preface
  (defun mohmak/disable-yas-if-no-snippets ()
    (when (and yas-minor-mode (null (yas--get-snippet-tables)))
      (yas-minor-mode -1))))

(use-package ivy-yasnippet :after yasnippet)

(use-package smartparens
  :ensure t
  :config
  (smartparens-global-mode t) ; Enable smartparens globally
  (show-smartparens-global-mode t)) ; Highlight matching pairs

(use-package lsp-mode
  :ensure nil ; Already ensured in general setup
  :hook ((c-mode c++-mode objc-mode) . lsp-deferred)
  :custom
  (lsp-clients-clangd-executable "/usr/bin/clangd")
  (lsp-clients-clangd-args '("--background-index"
                             "--clang-tidy"
                             "--completion-style=detailed"
                             "--header-insertion=never"
                             "--pch-storage=memory"))
  (lsp-enable-snippet t)
  (lsp-enable-indentation nil)) ; Clangd handles formatting better

(use-package dap-mode
 :after lsp-mode
 :config
 (dap-mode t)
 (dap-ui-mode t)
 ;; Load C++ debugging support
 (require 'dap-cpptools)
 ;; Set path to the debug adapter if not in default location
 (setq dap-cpptools-debug-program
       '("/home/mohmak07/.vscode/extensions/ms-vscode.cpptools-1.23.5-linux-x64/debugAdapters/bin/OpenDebugAD7")) ; Replace with actual path
 ;; Define debug template for C++
 (dap-register-debug-template
  "C++ SF Debug"
  (list :type "cppdbg"
        :request "launch"
        :name "C++ Debug"
        :program "${workspaceFolder}/${fileBasenameNoExtension}"
        :args '()
        :cwd "${workspaceFolder}"
        :environment '()
        :externalConsole nil
        :MIMode "gdb"
        :miDebuggerPath "/usr/bin/gdb")))

(use-package google-c-style
  :hook (((c-mode c++-mode) . google-set-c-style)
         (c-mode-common . google-make-newline-indent)))

;;; Python Core Configuration
;(use-package python
;  :ensure flycheck
;  :delight "π"
;  :preface
;  (defun python-remove-unused-imports()
;    "Remove unused imports and unused variables with autoflake."
;    (interactive)
;    (if (executable-find "autoflake")
;        (progn
;          (shell-command (format "autoflake --remove-all-unused-imports -i %s"
;                                 (shell-quote-argument (buffer-file-name))))
;          (revert-buffer t t t))
;      (warn "[✗] python-mode: Cannot find autoflake executable.")))
;  :bind (:map python-mode-map
;              ("M-[" . python-nav-backward-block)
;              ("M-]" . python-nav-forward-block)
;              ("M-|" . python-remove-unused-imports))
;  :hook (python-mode . (lambda ()
;                         (setq compile-command (format "%s %s"
;                                                       (or (executable-find "python3") "python3")
;                                                       (shell-quote-argument (buffer-file-name))))))
;  :custom
;  (flycheck-pylintrc "~/.pylintrc")
;  (flycheck-python-pylint-executable "pylint")) ; Now managed by pyvenv hooks

(use-package python
  :ensure flycheck
  :delight "π"
  :preface
  (defun python-remove-unused-imports()
    "Remove unused imports and unused variables with autoflake."
    (interactive)
    (if (executable-find "autoflake")
        (progn
          (shell-command (format "autoflake --remove-all-unused-imports -i %s"
                                 (shell-quote-argument (buffer-file-name))))
          (revert-buffer t t t))
      (warn "[✗] python-mode: Cannot find autoflake executable.")))
  :bind (:map python-mode-map
              ("M-[" . python-nav-backward-block)
              ("M-]" . python-nav-forward-block)
              ("M-|" . python-remove-unused-imports))
  :hook (python-mode . (lambda ()
                         (when (buffer-file-name)
                           (setq compile-command (format "%s %s"
                                                         (or (executable-find "python3") "python3")
                                                         (shell-quote-argument (buffer-file-name)))))))
  :custom
  (flycheck-pylintrc "~/.pylintrc")
  (flycheck-python-pylint-executable "pylint"))  ; Now managed by pyvenv hooks

;; Updated pyvenv configuration
;(use-package pyvenv
;  :after python
;  :custom
;  ;(pyvenv-default-virtual-env-name "~/.pyenv/versions/myenv/") ; Default venv
;  (pyvenv-workon "~/.pyenv/versions/") ; Where to look for venvs
;  :config (pyvenv-tracking-mode))

;(use-package pyvenv
;  :after python
;  :custom
;  (pyvenv-workon "~/.pyenv/versions/")
;  :config
;  (pyvenv-tracking-mode)
  ;; Set Python shell interpreter to venv's Python
;  (add-hook 'pyvenv-post-activate-hooks
;            (lambda ()
;              (setq python-shell-interpreter (concat pyvenv-virtual-env "/bin/python3")))))

;;; Virtual Environment Management
(use-package pyvenv
  :after python
  :custom
  (pyvenv-workon (expand-file-name "~/.pyenv/versions/"))
  :config
  (pyvenv-tracking-mode)
  ;; Update Python shell and Flycheck when environment changes
  (add-hook 'pyvenv-post-activate-hooks
            (lambda ()
              (when (and pyvenv-virtual-env (file-exists-p pyvenv-virtual-env))
                (let* ((env-path (expand-file-name pyvenv-virtual-env))  ;; Resolve ~
                       (python-bin (concat env-path "/bin/python3"))
                       (pylint-bin (concat env-path "/bin/pylint")))
                  ;; Set Python paths
                  (setq python-shell-interpreter python-bin
                        flycheck-python-pycompile-executable python-bin
                        flycheck-python-pylint-executable pylint-bin)
                  ;; Refresh Flycheck
                  (when (bound-and-true-p flycheck-mode)
                    (flycheck-mode -1)
                    (flycheck-mode 1))))))
  (add-hook 'pyvenv-post-deactivate-hooks
            (lambda ()
              ;; Reset to system defaults
              (setq python-shell-interpreter "python3"
                    flycheck-python-pycompile-executable "python3"
                    flycheck-python-pylint-executable "pylint")
              ;; Refresh Flycheck
              (when (bound-and-true-p flycheck-mode)
                (flycheck-mode -1)
                (flycheck-mode 1)))))

;; Updated lsp-pyright configuration
(use-package lsp-pyright
  :if (executable-find "pyright")
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)))
  :custom
  (lsp-pyright-python-executable-cmd "python3")
  (lsp-pyright-venv-path "~/.pyenv/versions/")) ; Tell pyright where venvs live

;; Updated pyenv-mode configuration
(use-package pyenv-mode
  :hook ((python-mode . pyenv-mode)
         (projectile-switch-project . projectile-pyenv-mode-set))
  :custom
  (pyenv-mode-installation-dir (expand-file-name "~/.pyenv/")) ; Critical path setting
  :preface
  (defun projectile-pyenv-mode-set ()
    "Set pyenv version matching project name."
    (let ((project (projectile-project-name)))
      (if (member project (mapcar 'file-name-nondirectory 
                                  (directory-files "~/.pyenv/versions")))
          (pyenv-mode-set project)
        (pyenv-mode-unset)))))

;; Magit and Evil-Magit
(use-package magit
  :commands (magit-status magit-get-current-branch)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge
  :after magit
  :config
  (setq forge-owned-accounts '(("Moh-Ahmd")))
  (setq forge-add-default-bindings t))

(setq auth-sources '("~/.authinfo.gpg"))

;; Projectile config:

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "/mnt/Storage/dev/")
    (setq projectile-project-search-path '("/mnt/Storage/dev/")))
  (setq projectile-switch-project-action #'projectile-dired))

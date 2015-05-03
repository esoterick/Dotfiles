(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; Update Cask on install
(require 'pallet)

(setq root-dir (file-name-directory
                (or (buffer-file-name) load-file-name)))
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Theme
(load-theme 'sanityinc-tomorrow-night t)
(set-cursor-color "firebrick")
(set-frame-font "Fira Mono-8" nil t)
(set-default-font "Fira Mono-8" nil t)
(setq default-frame-alist '((font . "Fira Mono-8")))

;; (require 'powerline)
;; (powerline-default-theme)

;; Git
(require 'magit)
(eval-after-load 'magit
  (progn '(global-set-key (kbd "C-x g") 'magit-status)))

(setq magit-last-seen-setup-instructions "1.4.0")

;; after macro per @jvalentini
(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY.
This allows us to define configuration for features that aren't
always installed and only eval that configuration after the feature is loaded.
ELPA packages usually provide an -autoloads feature which we can
use to determine if the package is installed/loaded."
  (declare (indent defun))
  `(eval-after-load (symbol-name ,mode)
     '(progn ,@body)))

;; Projectile
(require 'ack-and-a-half)
(require 'projectile)
(projectile-global-mode)

;; Project management
(setq projectile-enable-caching t)
(setq projectile-keymap-prefix (kbd "C-x p"))

;; Snippets
(require 'yasnippet)
;;(yas-load-directory (concat root-dir "snippets"))
(yas-global-mode 1)

;; Indentation
(setq-default tab-width 4 indent-tabs-mode nil)
(setq-default c-basic-offset 4 c-default-style "bsd")
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Line Numbers
(global-linum-mode t)

;; Smooth Scrolling
(setq scroll-margin 5 scroll-conservatively 9999 scroll-step 1)

;; Autopair
(require 'autopair)
(autopair-global-mode 1)

;; Evil
(require 'evil)
(evil-mode 1)

;; Change my cursor
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

;; Evil-leader:
(require 'evil-leader)
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

;; GUI config
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

;; GUI Emacs
(if window-system
    (x-focus-frame nil))

(fset 'yes-or-no-p 'y-or-n-p)

;; Tab = 4 spaces
(setq default-tab-width 4
      tab-width 4)
(setq-default tab-width 4
              indent-tabs-mode nil)

;; Show keystrokes
(setq echo-keystrokes 0.02)

;; Highlight trailing whitespace in a hideous red color.
(add-hook 'find-file-hook
          (lambda ()
            "Highlight trailing whitespace in a hideous red color"
            (progn
              (show-paren-mode 1)
              (setq indicate-empty-lines t
                    show-trailing-whitespace t))))

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

;; Always delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; unicode support
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Add rainbow delimiters in all programming modes
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; howdoi
(define-globalized-minor-mode global-howdoi-minor-mode
  howdoi-minor-mode howdoi-minor-mode)
(global-howdoi-minor-mode 1)

;; Powerline Fix to move the underline down a couple of pixels
(setq x-use-underline-position-properties nil)
(setq underline-minimum-offset 4)

;; JSON
(require 'json)

;; Helm
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(helm-autoresize-mode t)

(global-set-key (kbd "M-x") 'helm-M-x)

(helm-autoresize-mode t)

(setq helm-autoresize-max-height 24)
(setq helm-M-x-fuzzy-match t)

(global-set-key (kbd "C-x b") 'helm-mini)

(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

(global-set-key (kbd "C-c h o") 'helm-occur)

;; NYANNNNNNCAT
(require 'nyan-mode)
(setq-default nyan-wavy-trail t)
(nyan-mode)
(nyan-start-animation)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

(require 'eldoc)
    (eldoc-add-command
     'paredit-backward-delete
     'paredit-close-round)

(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
(define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;; Flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(require 'flymake-rust)
(add-hook 'rust-mode-hook 'flymake-rust-load)

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
(load-theme 'solarized-dark t)
(set-cursor-color "firebrick")
(set-frame-font "dina-6" nil t)
(require 'powerline)
(powerline-default-theme)

;; Git
(require 'magit)
(eval-after-load 'magit
  (progn '(global-set-key (kbd "C-x g") 'magit-status)))

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

;; IDO
(after 'ido-ubiquitous-autoloads
  (setq ido-enable-flex-matching t
        ido-auto-merge-work-directories-length -1
        ido-use-faces nil
        flx-ido-threshhold 2000
        ido-everywhere t
        ido-create-new-buffer 'always)
  (ido-mode 1)
  (ido-ubiquitous-mode 1)
  (require 'flx-ido)
  (flx-ido-mode 1))

;; smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; Old M-x
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(defadvice smex (around space-inserts-hyphen activate compile)
  (let ((ido-cannot-complete-command
         `(lambda ()
            (interactive)
            (if (string= " " (this-command-keys))
                (insert ?-)
              (funcall ,ido-cannot-complete-command)))))
    ad-do-it))

;; Projectile
(require 'ack-and-a-half)
(require 'projectile)
(projectile-global-mode)

;; Project management
(setq projectile-enable-caching t)
(setq projectile-keymap-prefix (kbd "C-x p"))

;; Snippets
(require 'yasnippet)
(yas-load-directory (concat root-dir "snippets"))
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

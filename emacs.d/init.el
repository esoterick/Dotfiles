(require 'cask "~/.cask/cask.el")
(cask-initialize)

;;; Update Cask on install
(require 'pallet)

(setq root-dir (file-name-directory
                (or (buffer-file-name) load-file-name)))
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;; Theme
(load-theme 'solarized-light t)
(set-cursor-color "firebrick")
(set-frame-font "Fira Mono-14" nil t)

;;; Git
(require 'magit)
(eval-after-load 'magit
  (progn '(global-set-key (kbd "C-x g") 'magit-status)))

;;; IDO
(require 'flx-ido)
(flx-ido-mode 1)
(setq flx-ido-threshhold 2000)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-create-new-buffer 'always)

;;; Projectile
(require 'ack-and-a-half)
(require 'projectile)
(projectile-global-mode)

;;; Snippets
(require 'yasnippet)
(yas-load-directory (concat root-dir "snippets"))
(yas-global-mode 1)

;;; Indentation
(setq-default tab-width 4 indent-tabs-mode nil)
(setq-default c-basic-offset 4 c-default-style "bsd")
;;;(require 'dtrt-indent)
;;;(dtrt-indent-mode 1)
(define-key global-map (kbd "RET") 'newline-and-indent)

;;; Line Numbers
(global-linum-mode t)

;;; Smooth Scrolling
(setq scroll-margin 5 scroll-conservatively 9999 scroll-step 1)

;;; Autopair
(require 'autopair)
(autopair-global-mode 1)

;;; Evil:
(require 'evil)
(evil-mode 1)

;;; Change my cursor
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

;;; Evil-leader:
(require 'evil-leader)
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

;;; GUI config
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)

;; Show keystrokes
(setq echo-keystrokes 0.02)

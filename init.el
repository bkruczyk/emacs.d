;; tricks

;; C-u C-c |
;; (in org-mode) convert active region into org table

;; graphical user interface
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode -1)
(fringe-mode 0)
(setq ring-bell-function 'ignore)

;; y or n instead yes or no questions
(fset 'yes-or-no-p 'y-or-n-p)

;; editing
(setq-default truncate-lines nil)
(show-paren-mode +1)

(defun kill-word-or-region ()
  "Kill region if visible or otherwise kill word at point."
  (interactive)
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
      (backward-word)
      (kill-word 1)))

(define-key global-map [remap kill-region] #'kill-word-or-region)

;; theme and font
(load-theme 'tsdh-light)
(set-face-attribute 'default nil :height 120 :family "Monaco")

;; tabs and spaces
(setq-default tab-width 4)
(setq-default tab-always-indent t)
(setq-default indent-tabs-mode nil)

;; backups
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq vc-follow-symlinks t)
(global-auto-revert-mode t)

;; disabled commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;; help windows
(setq help-window-select t)
(setq help-window-keep-selected t)

;; file browsing
(setq-default dired-dwim-target t)


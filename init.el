;;; init.el --- Emacs init file

;; Copyright (C) 2015  Bartłomiej Kruczyk

;; Author: bkruczyk <bartlomiej.kruczyk@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Emacs configuration assembled mostly from Prelude parts.

;;; Code:

;;; misc

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; focus on help window
(setq help-window-select t)

;; always load newest byte code
(setq load-prefer-newer t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 100000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name)) "%b"))))

;; supress ad-redefinition messages
(setq ad-redefinition-action 'accept)

;; follow symlinks
(setq vc-follow-symlinks t)

;; dired
(setq dired-dwim-target t)
(turn-on-gnus-dired-mode)

;;; message
(setq message-directory "~/.mail"
      message-auto-save-directory "~/tmp/mail"
      message-kill-buffer-on-exit t
      message-forward-as-mime nil
      message-forward-ignored-headers "^Return-Path\\|^Delivered-To\\|^Received\\|^X-.*\\|^References\\|^In-Reply-To\\|^Message-ID\\|^Thread-Index\\|^Content-Language")

;; specific mail server and signature configuration
(load-file (concat user-emacs-directory "mail.el"))

;;; editing

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance

;; delete the selection with a keypress
(delete-selection-mode t)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; enable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; enabled change region case commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; enable erase-buffer command
(put 'erase-buffer 'disabled nil)

;; enable find-alternate-file in dired
(put 'dired-find-alternate-file 'disabled nil)

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;; .zsh file is shell script too
(add-to-list 'auto-mode-alist '("\\.zsh\\'" . shell-script-mode))

;; display startup time
(add-hook 'after-init-hook
          (lambda ()
            (message (format "Emacs started in %s" (emacs-init-time)))))

;;; ux

;; selection info from doom-emacs
(defsubst doom-column (pos)
  (save-excursion (goto-char pos)
                  (current-column)))

(defun +doom-selection-info ()
  "Information about the current selection, such as how many characters and
lines are selected, or the NxM dimensions of a block selection."
  (when mark-active
    (let ((reg-beg (region-beginning))
          (reg-end (region-end)))
      (propertize
       (let ((lines (count-lines reg-beg (min (1+ reg-end) (point-max)))))
         (cond ((bound-and-true-p rectangle-mark-mode)
                (let ((cols (abs (- (doom-column reg-end)
                                    (doom-column reg-beg)))))
                  (format "(%dx%dB)" lines cols)))
               ((> lines 1)
                (format "(%dC %dL)" (- (1+ reg-end) reg-beg) lines))
               (t
                (format "(%dC)" (- (1+ reg-end) reg-beg)))))
       'face 'mode-line))))

(defun +macro-recording-info ()
  "Macro recording indicator."
  (if (or defining-kbd-macro executing-kbd-macro)
      (propertize " MACRO " 'face '((t (:inherit highlight :weight bold))))
      ""))

(setq-default mode-line-format
      '("%e"
        (:eval (+macro-recording-info))
        mode-line-front-space
        mode-line-mule-info
        mode-line-client
        mode-line-modified
        mode-line-remote
        mode-line-frame-identification
        mode-line-buffer-identification
        "  "
        mode-line-position
        (vc-mode vc-mode)
        "  "
        (:propertize mode-name face mode-line-emphasis help-echo "Major mode")
        "  "
        (:eval (+doom-selection-info))
        "  "
        mode-line-misc-info
        mode-line-end-spaces))

;; show matching parentheses
(show-paren-mode +1)

;; do not use .Xresources or .Xdefaults
(setq inhibit-x-resources t)

;; set custom themes directory
(setq custom-theme-directory "~/.emacs.d/themes")

(defun reload-theme ()
  "Reload current theme."
  (interactive)
  (load-theme (car custom-enabled-themes) t))

;; reload current theme
(global-set-key (kbd "C-x M-t") 'reload-theme)

;; disable startup screen
(setq inhibit-startup-screen t)

;; disable toolbar
(tool-bar-mode -1)

;; disable menubar
(menu-bar-mode -1)

;; disable scrollbar
(scroll-bar-mode -1)

;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;; history-rewind for window layouts, C-c + right/left arrow key
(winner-mode +1)

;; use shift + arrow keys to switch between visible buffers
(windmove-default-keybindings)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1
      fast-but-imprecise-scrolling t)
(setq mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(2 ((shift) . 10)))

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(setq tooltip-mode t)

(setq linum-format " %i ")

;; display key strokes faster
(setq echo-keystrokes 0.1)

;; don't display ediff navigation window in separate frame
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;;; keybindings

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-c h") 'help-command)

(defun top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))

(global-set-key (kbd "M-j") 'top-join-line)

(global-set-key (kbd "M-SPC") 'cycle-spacing)

;; Font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Align arbitrary text to columns by regexp
(global-set-key (kbd "C-x |") 'align-regexp)

;; use hippie-expand instead of dabbrev
(global-set-key (kbd "M-/") 'hippie-expand)

;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; toggle menu-bar visibility
(global-set-key (kbd "<f12>") 'menu-bar-mode)

;;; packages

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; builtins
(use-package recentf
  :commands recentf
  :init
  (defvar recentf-run #'recentf-open-files "Function to run recentf with.")
  (bind-key "C-x F"
            (lambda ()
              (interactive)
              (require 'recentf)
              (funcall recentf-run)))
  :config
  (recentf-mode +1)
  (setq recentf-max-saved-items 100
        recentf-max-menu-items 5))

(use-package viper
  :init
  ;; (defun viper-delete-forward-word ()
  ;;   "Delete next word."
  ;;   (interactive)
  ;;   (if (eolp)
  ;;       (delete-indentation 1)
  ;;     (delete-region (min
  ;;                     (save-excursion
  ;;                      (viper-forward-word)
  ;;                      (point))
  ;;                     (line-end-position))
  ;;                    (point))))
  :bind
  (("M-f" . viper-forward-word)
   ("M-b" . viper-backward-word)))
   ;; ("M-d" . evil-delete-forward-word)
   ;; ("M-h" . evil-delete-backward-word)
   ;; ("C-x M-h" . mark-paragraph)))

(use-package org
  :commands org-mode
  :init
  (bind-key "C-c a" 'org-agenda)
  (bind-key "C-c c" 'org-capture)
  :config
  (setq org-log-done t)
  (setq org-ellipsis "⤵")
  (setq org-directory "~/Dropbox/org")
  (setq org-default-notes-file
        (concat org-directory "/notes.org"))
  (set-face-attribute 'org-ellipsis nil :underline nil))

(use-package whitespace
  :commands whitespace-mode
  :config
  (setq whitespace-line-column 80)
  (setq whitespace-style '(face trailing empty tabs)))

(use-package re-builder
  :commands re-builder
  :config
  (setq reb-re-syntax 'string))

;; gnu and melpa packages

(use-package pkgbuild-mode
  :ensure t
  :commands pkgbuild-mode
  :init
  (setq auto-mode-alist
        (append '(("PKGBUILD$" . pkgbuild-mode)) auto-mode-alist)))

(use-package neotree
  :ensure t
  :bind ("<f8>" . neotree-toggle))

(use-package projectile
  :ensure t
  :ensure counsel-projectile
  :commands projectile
  :config
  (counsel-projectile-on))

(use-package notmuch
  :commands notmuch
  :init
  (bind-key "C-c m" 'notmuch)
  :config
  (setq-default notmuch-show-indent-content nil)
  (setq notmuch-search-oldest-first nil)
  (setq notmuch-fcc-dirs "Archive -unread")
  (setq notmuch-archive-tags '("-inbox" "+archive"))
  (bind-key "a"
            (lambda ()
              "archive message"
              (interactive)
              (notmuch-search-tag '("+archive" "-inbox" "-unread" "-trash")))
            notmuch-search-mode-map)
  (bind-key  "i"
             (lambda ()
               "inbox message"
               (interactive)
               (notmuch-search-tag '("+inbox" "-trash" "-unread" "-archive")))
             notmuch-search-mode-map)
  (bind-key  "d"
             (lambda ()
               "trash message"
               (interactive)
               (notmuch-search-tag '("+trash" "-inbox" "-unread" "-archive")))
             notmuch-search-mode-map))

(use-package paradox
  :ensure t
  :commands paradox-list-packages
  :config
  (setq paradox-execute-asynchronously t)
  (setq paradox-automatically-star t))

(use-package discover-my-major
  :ensure t
  :commands discover-my-major discover-my-mode
  :init
  (bind-key "C-c C-h M-m" 'discover-my-major)
  (bind-key "C-c C-h M-M" 'discover-my-mode))

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode +1))

(use-package zop-to-char :ensure t)

(use-package markdown-mode
  :ensure t
  :commands markdown-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode)))

(use-package rainbow-mode
  :ensure t
  :commands rainbow-mode)

(use-package magit
  :ensure t
  :commands magit-status
  :init
  (bind-key "C-x g" 'magit-status)
  (add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . global-git-commit-mode)))

(use-package git-timemachine :ensure t)
(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package gitattributes-mode :ensure t)

(use-package diff-hl
  :ensure t
  :config
  (diff-hl-dired-mode-unless-remote)
  (global-diff-hl-mode +1)
  (diff-hl-margin-mode))

(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode)

(use-package parinfer
  :ensure t
  :bind (("C-," . parinfer-toggle-mode))
  :init
  (progn
    (setq parinfer-extensions
          '(defaults pretty-parens smart-tab smart-yank))
    (add-hook 'lisp-mode-hook #'parinfer-mode)
    (add-hook 'clojure-mode-hook #'parinfer-mode)))

(use-package prog-mode
  :init
  (add-hook 'prog-mode-hook (lambda ()
                              (subword-mode +1)
                              (eldoc-mode +1)
                              (whitespace-mode +1)))
  (add-hook 'lisp-mode-hook (lambda ()
                              (run-hooks 'prog-mode-hook)))
  (add-hook 'emacs-lisp-mode-hook (lambda ()
                                    (run-hooks 'lisp-mode-hook))))

(use-package company
  :ensure t
  :commands company-complete
  :init
  (bind-key "C-c SPC" 'company-complete)
  :config
  (global-company-mode +1)
  (setq company-idle-delay 0.5)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-flip-when-above t))

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :init
  (add-hook 'prog-mode-hook (lambda () (flycheck-mode +1)))
  :config
  (setq flycheck-indication-mode nil))

;; (use-package inf-ruby
;;   :ensure t
;;   :commands (inf-ruby inf-ruby-mode))

;; (use-package ruby-tools
;;   :ensure t
;;   :commands ruby-tools-mode)

;; (use-package ruby-mode
;;   :ensure t
;;   :commands ruby-mode
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
;;   (add-hook 'ruby-mode-hook (lambda ()
;;                               (subword-mode +1)
;;                               (inf-ruby-minor-mode +1)
;;                               (ruby-tools-mode +1))))

(use-package clojure-mode
  :ensure t
  :commands clojure-mode)

(use-package cider
  :ensure t
  :commands cider-mode
  :init
  (setq cider-font-lock-dynamically '(macro core function var))
  :config
  (setq cider-lein-parameters "repl :headless :host localhost")
  (setq nrepl-log-messages t)
  (setq cider-cljs-lein-repl
        "(do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/start-figwheel!) (figwheel-sidecar.repl-api/cljs-repl))"))

(use-package haskell-mode
  :ensure t
  :commands haskell-mode
  :config
  (add-hook 'haskell-mode-hook
            (lambda ()
              (whitespace-mode +1)
              (subword-mode +1)
              (haskell-doc-mode +1)
              (haskell-indentation-mode +1)
              (interactive-haskell-mode +1))))

;; (use-package python
;;   :commands python-mode
;;   :ensure anaconda-mode
;;   :ensure company
;;   :ensure company-anaconda
;;   :config
;;   (add-to-list 'company-backends 'company-anaconda)
;;   (add-hook 'python-mode-hook
;;             (lambda ()
;;               (whitespace-mode +1)
;;               (anaconda-mode +1)
;;               (eldoc-mode +1))))

(use-package hl7-mode
  :load-path "site-lisp/"
  :commands hl7-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.hl7\\'" . hl7-mode)))

(use-package js2-mode
  :ensure t
  :commands js2-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'"    . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  :config
  (add-hook 'js2-mode-hook (lambda ()
                             (whitespace-mode +1)
                             (subword-mode +1)
                             (setq-local electric-layout-rules '((?\; . after))))))

(use-package json-mode
  :ensure t
  :commands json-mode)

(use-package web-mode
  :ensure t
  :commands web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.?html\\'" . web-mode)))

(use-package yaml-mode
  :ensure t
  :commands yaml-mode)

(use-package nxml-mode
  :commands nxml-mode
  :config
  (setq nxml-bind-meta-tab-to-complete-flag t)
  (setq nxml-slash-auto-complete-flag t)
  (add-to-list 'auto-mode-alist '("\\.pom$" . nxml-mode)))

(use-package ivy
  :ensure t
  :ensure swiper
  :ensure counsel
  :init
  (ivy-mode +1)
  (setq recentf-run #'ivy-recentf)
  :config
  ;; (bind-key "C-s" 'swiper)
  (bind-key "C-c C-r" 'ivy-resume)
  (bind-key "M-x" 'counsel-M-x)
  (bind-key "C-x M-m" 'counsel-M-x))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  (bind-key "M-%" 'anzu-query-replace)
  (bind-key "C-M-%" 'anzu-query-replace-regexp)
  (bind-key "C-. M-%" 'anzu-query-replace-at-cursor)
  (bind-key "C-c C-. M-%" 'anzu-query-replace-at-cursor-thing)
  (defun +anzu-update-func (here total)
    (when anzu--state
      (let ((status (cl-case anzu--state
                      (search (format " %d/%d " here total))
                      (replace-query (format " %d Replaces " total))
                      (replace (format " %d/%d " here total)))))
        (propertize status 'face 'anzu-mode-line))))
  (setq anzu-mode-line-update-function #'+anzu-update-func))

(use-package doom-themes
  :ensure t
  :init
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

(use-package theme
  :init
  (if (window-system)
      (load-theme 'doom-one-light t))
  (set-face-attribute 'anzu-mode-line nil
                      :foreground (face-attribute 'default :background)
                      :background (face-attribute 'mode-line-emphasis :foreground nil 'default)
                      :weight 'bold)
  (set-face-attribute 'anzu-mode-line-no-match nil
                      :foreground (face-attribute 'default :background)
                      :background (face-attribute 'error :foreground)
                      :weight 'bold))

(use-package adoc-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.ascii\\'" . adoc-mode))
  (add-to-list 'auto-mode-alist '("\\.asciidoc\\'" . adoc-mode))
  (add-to-list 'auto-mode-alist '("\\.adoc\\'" . adoc-mode)))

(use-package custom
  :config
  (setq custom-file (concat (file-name-as-directory user-emacs-directory) "custom.el"))
  (load custom-file 'no-error 'no-message))

;;; init.el ends here

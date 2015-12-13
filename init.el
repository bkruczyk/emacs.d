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

;; Always load newest byte code
(setq load-prefer-newer t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" (:eval (if (buffer-file-name)
                      (abbreviate-file-name (buffer-file-name)) "%b"))
        " ★ " invocation-name))

;; supress ad-redefinition messages
(setq ad-redefinition-action 'accept)

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

;; do not use .Xresources or .Xdefaults
(setq inhibit-x-resources t)

;; use custom color theme
(add-to-list 'custom-theme-load-path
             (concat (file-name-as-directory user-emacs-directory) "themes"))
(load-theme 'badwolf t)

;; set font face
(set-face-attribute 'default nil
                    :family "DejaVu Sans Mono"
                    :height 100
                    :weight 'regular)

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

;; highlight the current line
(global-hl-line-mode +1)

;; history-rewind for window layouts, C-c + right/left arrow key
(winner-mode +1)

;; use shift + arrow keys to switch between visible buffers
(windmove-default-keybindings)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)
(setq mouse-wheel-progressive-speed nil
      mouse-wheel-scroll-amount '(2 ((shift) . 10)))

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; display key strokes faster
(setq echo-keystrokes 0.1)

;;; keybindings

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

;;; other packages

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; built-ins
(use-package linum
  :commands (linum-mode global-linum-mode))

(use-package recentf
  :init
  (bind-key "C-x M-f"
            (lambda ()
              (interactive)
              (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
                (when file
                  (find-file file)))))
  :config
  (setq recentf-max-saved-items 200
        recentf-max-menu-items 15)
  (recentf-mode +1))

(use-package org
  :commands org-mode
  :config
  (setq org-log-done t)
  (setq org-directory "~/code/org")
  (setq org-default-notes-file (concat org-directory "/notes.org")))

(use-package whitespace
  :commands whitespace-mode
  :config
  (setq whitespace-line-column 80)
  (setq whitespace-style '(face trailing empty tabs)))

(use-package re-builder
  :commands re-builder
  :config
  (setq reb-re-syntax 'string))

(use-package ido
  :config
  (ido-mode +1)
  (ido-everywhere +1)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-max-prospects 10
        ido-auto-merge-work-directories-length -1
        ido-default-file-method 'selected-window))

;; archlinux
(use-package pkgbuild-mode
  :ensure t
  :init
  (setq auto-mode-alist (append '(("PKGBUILD$" . pkgbuild-mode)) auto-mode-alist)))

(use-package paradox
  :ensure t
  :commands paradox-list-packages
  :config
  (setq paradox-execute-asynchronously t)
  (setq paradox-automatically-star t))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  (bind-key "M-%" 'anzu-query-replace)
  (bind-key "C-M-%" 'anzu-query-replace-regexp)
  (bind-key "C-. M-%" 'anzu-query-replace-at-cursor)
  (bind-key "C-c C-. M-%" 'anzu-query-replace-at-cursor-thing)
  :diminish anzu-mode)

(use-package discover-my-major
  :ensure t
  :init
  (bind-key "C-h M-m" 'discover-my-major)
  (bind-key "C-h M-M" 'discover-my-mode))

(use-package beacon
  :ensure t
  :config
  (beacon-mode +1)
  :diminish beacon-mode)

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode +1)
  :diminish volatile-highlights-mode)

(use-package operate-on-number
  :ensure t
  :ensure hydra
  :config
  (defhydra hydra-op-on-number (global-map "C-.")
    "Operate on number."
    ("+" apply-operation-to-number-at-point)
    ("-" apply-operation-to-number-at-point)
    ("*" apply-operation-to-number-at-point)
    ("/" apply-operation-to-number-at-point)
    ("\\" apply-operation-to-number-at-point)
    ("^" apply-operation-to-number-at-point)
    ("<" apply-operation-to-number-at-point)
    (">" apply-operation-to-number-at-point)
    ("#" apply-operation-to-number-at-point)
    ("%" apply-operation-to-number-at-point)
    ("'" operate-on-number-at-point)))

(use-package zop-to-char
  :ensure t
  :init
  (bind-key "s-z" 'zop-to-char))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode)
  :init
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode)))

(use-package rainbow-mode :ensure t)

;; ido et al
(use-package ido-ubiquitous
  :ensure t
  :config
  (ido-ubiquitous-mode +1))

(use-package flx-ido
  :ensure t
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil)
  (flx-ido-mode +1))

(use-package smex
  :ensure t
  :init
  (bind-key "M-x" 'smex)
  (bind-key "M-X" 'smex-major-mode-commands))

(use-package ido-vertical-mode
  :ensure t
  :config
  (ido-vertical-mode +1))

;; vc
(use-package magit
  :ensure t
  :init
  (bind-key "C-x g" 'magit-status)
  (global-git-commit-mode +1))

(use-package git-timemachine :ensure t)

(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package gitattributes-mode :ensure t)

(use-package gist :ensure t)

(use-package diff-hl
  :ensure t
  :config
  (diff-hl-dired-mode-unless-remote)
  (global-diff-hl-mode +1))

(use-package smartparens
  :ensure t
  :commands (smartparens-mode smartparen-strict-mode)
  :init
  (require 'smartparens-config)
  (setq sp-base-key-bindings 'paredit
        sp-autoskip-closing-pair 'always
        sp-show-pair-delay 0)
  (sp-use-paredit-bindings))

(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode)

;; company
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.5)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode +1)
  (bind-key "C-c SPC" 'company-complete)
  :diminish company-mode)

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :config
  (setq flycheck-highlighting-mode nil))

;; proglang specific
(add-hook 'prog-mode-hook
          (lambda ()
            (show-smartparens-mode +1)
            (smartparens-mode +1)
            (flycheck-mode +1)))

(defun lisp-defaults ()
  "Turn on modes useful for Lisp programming."
  (whitespace-mode +1)
  (smartparens-strict-mode +1)
  (rainbow-delimiters-mode +1)
  (subword-mode +1)
  (eldoc-mode +1))

(defvar my-lisp-mode-hook #'lisp-defaults)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (run-hooks 'my-lisp-mode-hook)
            (setq mode-name "Elisp")))

;; clojure
(use-package clojure-mode
  :ensure t
  :commands clojure-mode
  :config
  (add-hook 'clojure-mode-hook
            #'lisp-defaults))

(use-package cider
  :ensure t
  :commands cider-mode
  :config
  (setq nrepl-log-messages t)
  (add-hook 'cider-mode-hook
            #'lisp-defaults))

;; haskell
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

;; ruby
(use-package inf-ruby
  :ensure t
  :commands (inf-ruby inf-ruby-mode))

(use-package ruby-tools
  :ensure t
  :commands ruby-tools-mode)

(use-package yari
  :ensure t
  :init
  (bind-key "R" 'yari 'help-command))

(use-package ruby-mode
  :ensure t
  :commands ruby-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook
            (lambda ()
              (whitespace-mode +1)
              (subword-mode +1)
              (inf-ruby-minor-mode +1)
              (ruby-tools-mode +1))))

;; python
(use-package python
  :commands python-mode
  :ensure anaconda-mode
  :ensure company
  :ensure company-anaconda
  :config
  (add-to-list 'company-backends 'company-anaconda)
  (add-hook 'python-mode-hook
            (lambda ()
              (whitespace-mode +1)
              (anaconda-mode +1)
              (eldoc-mode +1))))

;; web-mode
(use-package web-mode
  :ensure t
  :commands web-mode
  :ensure smartparens
  :init
  (add-to-list 'auto-mode-alist '("\\.?html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  :config
  (require 'smartparens)
  (setq web-mode-enable-auto-pairing nil)
  (sp-with-modes '(web-mode)
    (sp-local-pair "%" "%"
                   :unless '(sp-in-string-p)
                   :post-handlers '(((lambda (&rest _ignored)
                                       (just-one-space)
                                       (save-excursion (insert " ")))
                                     "SPC" "=" "#")))
    (sp-local-pair "<% "  " %>" :insert "C-c %")
    (sp-local-pair "<%= " " %>" :insert "C-c =")
    (sp-local-pair "<%# " " %>" :insert "C-c #")
    (sp-local-tag "%" "<% "  " %>")
    (sp-local-tag "=" "<%= " " %>")
    (sp-local-tag "#" "<%# " " %>")))

;; js
(use-package json-mode
  :ensure t
  :commands json-mode)
(use-package js2-mode
  :ensure t
  :commands js2-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'"    . js2-mode))
  (add-to-list 'auto-mode-alist '("\\.pac\\'"   . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  :config
  (add-hook 'js2-mode-hook
            (lambda ()
              (whitespace-mode +1)
              (setq-local electric-layout-rules '((?\; . after)))
              (setq mode-name "JS2")
              (js2-imenu-extras-mode +1))))
;; yaml
(use-package yaml-mode :ensure t
  :commands yaml-mode
  :config (add-hook 'yaml-mode-hook (lambda () (subword-mode +1))))

;; xml
(use-package nxml-mode
  :commands nxml-mode
  :config
  (setq nxml-bind-meta-tab-to-complete-flag t)
  (setq nxml-slash-auto-complete-flag t)
  (push '("<\\?xml" . nxml-mode) magic-mode-alist)
  ;; pom files should be treated as xml files
  (add-to-list 'auto-mode-alist '("\\.pom$" . nxml-mode)))

(use-package misc
  :config
  (setq custom-file
        (concat (file-name-as-directory user-emacs-directory) "custom.el"))
  (load custom-file 'no-error 'no-message)
  (load (concat (file-name-as-directory user-emacs-directory) "secret.el")
        'no-error 'no-message))

;;; init.el ends here

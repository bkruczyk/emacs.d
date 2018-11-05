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

(require 'core (concat user-emacs-directory "core/core.el"))
(require 'core-editor (concat user-emacs-directory "core/core-editor.el"))
(require 'core-ui (concat user-emacs-directory "core/core-ui.el"))
(require 'core-keybinds (concat user-emacs-directory "core/core-keybinds.el"))
(require 'core-os (concat user-emacs-directory "core/core-os.el"))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

;; builtins
(defun my/viper-delete-forward-word ()
    "Delete next word."
    (interactive)
    (if (eolp)
        (delete-indentation 1)
      (delete-region (min
                      (save-excursion
                       (viper-forward-word nil)
                       (point))
                      (line-end-position))
                     (point))))

(defun my/viper-delete-backward-word ()
  "Delete previous word."
  (interactive)
  (delete-region
   (save-excursion
     (viper-backward-word nil)
     (point))
   (point)))

(use-package viper
  :bind
  (("M-f" . viper-forward-word)
   ("M-b" . viper-backward-word)
   ("M-d" . my/viper-delete-forward-word)
   ("M-h" . my/viper-delete-backward-word)))

(use-package org
  :commands org-mode
  :init
  (bind-key "C-c a" 'org-agenda)
  (bind-key "C-c c" 'org-capture)
  :config
  (setq org-log-done t)
  (setq org-directory "~/.emacs.d/org")
  (setq org-default-notes-file (concat org-directory "/notes.org")))

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

(use-package discover-my-major
  :ensure t
  :commands discover-my-major discover-my-mode
  :init
  (bind-key "C-x M-m" 'discover-my-major))

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
                              (eldoc-mode +1)))
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

(use-package inf-ruby
  :ensure t
  :commands (inf-ruby inf-ruby-mode))

(use-package ruby-tools
  :ensure t
  :commands ruby-tools-mode)

(use-package ruby-mode
  :ensure t
  :commands ruby-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook (lambda ()
                              (subword-mode +1)
                              (inf-ruby-minor-mode +1)
                              (ruby-tools-mode +1))))

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
  :config
  ;; (bind-key "C-s" 'swiper)
  (bind-key "C-c C-r" 'ivy-resume)
  (bind-key "M-x" 'counsel-M-x))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  (bind-key "M-%" 'anzu-query-replace)
  (bind-key "C-M-%" 'anzu-query-replace-regexp)
  (bind-key "C-. M-%" 'anzu-query-replace-at-cursor)
  (bind-key "C-c C-. M-%" 'anzu-query-replace-at-cursor-thing)
  (defun my/anzu-update-func (here total)
    (when anzu--state
      (let ((status (cl-case anzu--state
                      (search (format " %d/%d " here total))
                      (replace-query (format " %d Replaces " total))
                      (replace (format " %d/%d " here total)))))
        (propertize status 'face 'anzu-mode-line))))
  (setq anzu-mode-line-update-function #'my/anzu-update-func))

(use-package doom-themes
  :ensure t
  :init
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config))

(use-package custom
  :config
  (setq custom-file (concat (file-name-as-directory user-emacs-directory) "custom.el"))
  (load custom-file 'no-error 'no-message))

;;; init.el ends here

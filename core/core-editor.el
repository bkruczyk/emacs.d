;;; core-editor.el -*- lexical-binding: t; -*-
(require 'core)

;; disable autosave
(setq auto-save-default nil
      create-lockfiles nil
      make-backup-files nil
      ;; but have a place to store them in case we do use them...
      auto-save-list-file-name (concat soup-cache-dir "autosave")
      backup-directory-alist `(("." . ,(concat soup-cache-dir "backup/"))))

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; do not ask about opening symlink source
(setq vc-follow-symlinks t)

;; revert buffers automatically when underlying files are changed externally
(setq-default auto-revert-verbose nil)
(global-auto-revert-mode t)

;; indentation
(setq-default tab-width 4
              tab-always-indent t
              indent-tabs-mode nil
              fill-column 80)

;; word wrapping
(setq-default word-wrap t
              truncate-lines t
              truncate-partial-width-windows nil)

;; do not add newline at end of file
(setq-default require-final-newline nil)

;; truncate lines instead of using continuations
(setq-default truncate-lines t)
(setq-default truncate-partial-width-windows 50)

;; delete the selection with a keypress
(delete-selection-mode)

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(setq save-interprogram-paste-before-kill t)
(setq sentence-end-double-space nil)
(setq word-wrap nil)

;; ediff configuration
(setq-default ediff-diff-options "-w"
              ediff-split-window-function #'split-window-horizontally
              ediff-window-setup-function #'ediff-setup-windows-plain) ;; don't display ediff navigation window in separate frame

;; savehist configuration
(setq-default savehist-file (concat soup-cache-dir "savehist")
              savehist-save-minibuffer-history t
              savehist-autosave-interval nil ;; save on kill only
              savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

;; saveplace configuration
(setq-default save-place-file (concat soup-cache-dir "saveplace"))

(savehist-mode t)   ;; save minibuffer history
(save-place-mode t) ;; save buffer position

;; recentf config
(setq-default recentf-save-file (concat soup-cache-dir "recentf")
              recentf-max-menu-items 0
              recentf-max-saved-items 300
              recentf-filename-handlers '(file-truename)
              recentf-exclude
              (list "^/tmp/" "^/ssh:" "\\.?ido\\.last$" "\\.revive$" "/TAGS$"
                    "^/var/folders/.+$"
                    ;; ignore private soup temp files (but not all of them)
                    (concat "^" (file-truename soup-cache-dir))))
(recentf-mode t)

;; focus on help window
(setq help-window-select t)

;; kill help window on quit
(defun soup--quit-window (orig-fn &optional kill window)
  (funcall orig-fn (not kill) window))
(advice-add #'quit-window :around #'soup--quit-window)

;; make other window a target for dired action
(setq-default dired-dwim-target t)

;; history-rewind for window layouts
(winner-mode)

;; selectively show/hide code blocks
(setq-default hs-hide-comments-when-hiding-all nil)
(add-hook 'prog-mode-hook (lambda () (hs-minor-mode)))

;; do not show highlited current line in inactive windows
(setq-default hl-line-sticky-flag nil
              global-hl-line-sticky-flag nil)

;; enable current line highlighting
(add-hook 'prog-mode-hook (lambda () (hl-line-mode)))
(add-hook 'text-mode-hook (lambda () (hl-line-mode)))
(add-hook 'conf-mode-hook (lambda () (hl-line-mode)))

;; highlight parentheses
(setq-default show-paren-delay 0.1
              show-paren-highlight-openparen t
              show-paren-when-point-inside-paren t)
(show-paren-mode)

;; regexp builder
(setq-default reb-re-syntax 'string)

;; uniquify buffer names
(setq-default uniquify-buffer-name-style 'forward)

;; use a shared clipboard
(setq select-enable-clipboard t
      select-enable-primary t)

;; use subword and eldoc in prog-mode
(add-hook 'prog-mode-hook (lambda ()
                            (subword-mode +1)
                            (eldoc-mode +1)))
(add-hook 'lisp-mode-hook (lambda () (run-hooks 'prog-mode-hook)))
(add-hook 'emacs-lisp-mode-hook (lambda () (run-hooks 'lisp-mode-hook)))

(provide 'core-editor)
;;; core-editor.el ends here

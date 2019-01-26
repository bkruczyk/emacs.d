(require 'core)

(setq-default indent-tabs-mode nil
              tab-width 4)

(setq-default require-final-newline nil)

(setq vc-follow-symlinks t)

(setq-default truncate-lines t
              truncate-partial-width-windows 50)

(setq-default
 whitespace-line-column fill-column
 whitespace-style
 '(face indentation tabs tab-mark spaces space-mark newline newline-mark
   trailing lines-tail)
 whitespace-display-mappings
 '((tab-mark ?\t [?› ?\t])
   (newline-mark ?\n [?¬ ?\n])
   (space-mark ?\  [?·] [?.])))

;; delete the selection with a keypress
(delete-selection-mode)

;; revert buffers automatically when underlying files are changed externally
(setq-default auto-revert-verbose nil)
(global-auto-revert-mode t)

(setq tab-always-indent 'complete)

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(setq save-interprogram-paste-before-kill t)
(setq sentence-end-double-space nil)
(setq word-wrap t)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 1001
      scroll-preserve-screen-position t
      fast-but-imprecise-scrolling nil
      hscroll-margin 1
      hscroll-step 1
      mouse-wheel-progressive-speed nil)

(setq echo-keystrokes 0.1)

(setq-default ediff-diff-options "-w"
              ediff-split-window-function #'split-window-horizontally
              ediff-window-setup-function #'ediff-setup-windows-plain) ;; don't display ediff navigation window in separate frame

(setq-default savehist-file (concat soup-cache-dir "savehist")
              savehist-save-minibuffer-history t
              savehist-autosave-interval nil ; save on kill only
              savehist-additional-variables '(kill-ring search-ring regexp-search-ring)
              save-place-file (concat soup-cache-dir "saveplace"))

(savehist-mode t)
(save-place-mode t)

(setq-default recentf-save-file (concat soup-cache-dir "recentf")
              recentf-max-menu-items 0
              recentf-max-saved-items 300
              recentf-filename-handlers '(file-truename)
              recentf-exclude
              (list "^/tmp/" "^/ssh:" "\\.?ido\\.last$" "\\.revive$" "/TAGS$"
                    "^/var/folders/.+$"
                    ;; ignore private DOOM temp files (but not all of them)
                    (concat "^" (file-truename soup-cache-dir))))
(recentf-mode t)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; focus on help window
(setq help-window-select t)

(defun soup--quit-window (orig-fn &optional kill window)
  (funcall orig-fn (not kill) window))
(advice-add #'quit-window :around #'soup--quit-window)

(setq-default dired-dwim-target t)

;; shift + arrow keys to move arround the windows
;; (windmove-default-keybindings)

;; history-rewind for window layouts, C-c and arrow keys
(winner-mode)

(setq-default hs-hide-comments-when-hiding-all nil)
(add-hook 'prog-mode-hook (lambda () (hs-minor-mode)))

(setq-default hl-line-sticky-flag nil
              global-hl-line-sticky-flag nil)

(add-hook 'prog-mode-hook (lambda () (hl-line-mode)))
(add-hook 'text-mode-hook (lambda () (hl-line-mode)))
(add-hook 'conf-mode-hook (lambda () (hl-line-mode)))

(setq-default show-paren-delay 0.1
              show-paren-highlight-openparen t
              show-paren-when-point-inside-paren t)
(show-paren-mode)

;; re-builder
(setq-default reb-re-syntax 'string)

(provide 'core-editor)
;;; core-editor.el ends here

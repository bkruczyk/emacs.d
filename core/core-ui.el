;;; core-ui.el -*- lexical-binding: t; -*-
(require 'core)

;; resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we halve startup times, particularly when we use
;; fonts that are larger than the system default (which would resize the frame).
(setq frame-inhibit-implied-resize t)

(setq-default inhibit-x-resources t)

(setq-default cursor-in-non-selected-windows nil
              x-stretch-cursor nil
              visible-cursor nil)

(setq-default highlight-nonselected-windows nil)

(setq-default ring-bell-function #'ignore
              visible-bell nil)

(setq-default mode-line-default-help-echo nil
              show-help-function nil)

(setq-default use-dialog-box nil)

(setq-default blink-matching-paren nil)

;; middle-click paste at point, not at click
(setq-default mouse-yank-at-point t)

(setq-default ibuffer-use-other-window t)

(setq-default window-divider-default-places t
              window-divider-default-bottom-width 0
              window-divider-default-right-width 1)
(window-divider-mode)

(tooltip-mode -1)
(menu-bar-mode -1)
(if (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; reduce rendering/line scan work for Emacs by not rendering cursors or regions
;; in non-focused windows.
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

;; more performant rapid scrolling over unfontified regions. May cause brief
;; spells of inaccurate fontification immediately after scrolling.
(setq fast-but-imprecise-scrolling t)

;; nice scrolling
(setq hscroll-margin 2
      hscroll-step 1
      scroll-conservatively 10
      scroll-margin 0
      scroll-preserve-screen-position t
      ;; mouse
      mouse-wheel-scroll-amount '(5 ((shift) . 2))
      mouse-wheel-progressive-speed nil)  ; don't accelerate scrolling

(setq mac-redisplay-dont-reset-vscroll t
      mac-mouse-wheel-smooth-scroll nil)

(setq echo-keystrokes 0.1)

;;; Fringes

;; Reduce the clutter in the fringes; we'd like to reserve that space for more
;; useful information, like git-gutter and flycheck.
(setq indicate-buffer-boundaries nil
      indicate-empty-lines nil)

;; remove truncation arrow on right fringe
(setq-default fringe-indicator-alist (delq (assoc 'truncation fringe-indicator-alist) fringe-indicator-alist))

(setq confirm-nonexistent-file-or-buffer t)
(setq frame-title-format '("%b – Emacs")
      icon-title-format frame-title-format)

;; Don't resize emacs in steps, it looks weird.
(setq window-resize-pixelwise t
      frame-resize-pixelwise t)

(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(setq use-dialog-box nil)
(setq split-width-threshold 160
      split-height-threshold nil)

;; Allow for minibuffer-ception. Sometimes we need another minibuffer command
;; _while_ we're in the minibuffer.
(setq enable-recursive-minibuffers t)

(setq resize-mini-windows 'grow-only
      ;; But don't let the minibuffer grow beyond this size
      max-mini-window-height 0.15)

;; Disable help mouse-overs for mode-line segments (i.e. :help-echo text).
;; They're generally unhelpful and only add confusing visual clutter.
(setq mode-line-default-help-echo nil
      show-help-function nil)

;; Try really hard to keep the cursor from getting stuck in the read-only prompt
;; portion of the minibuffer.
(setq minibuffer-prompt-properties '(read-only t intangible t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

(setq-default display-line-numbers-width 3)

;; line numbers in most modes
;; (add-hook '(prog-mode-hook text-mode-hook conf-mode-hook)
;;           #'display-line-numbers-mode)

;; Underline looks a bit better when drawn lower
(setq x-underline-at-descent-line t)

(setq compilation-always-kill t       ; kill compilation process before starting another
      compilation-ask-about-save nil  ; save all buffers on `compile'
      compilation-scroll-output 'first-error)
  (setq ediff-diff-options "-w" ; turn off whitespace checking
        ediff-split-window-function #'split-window-horizontally
        ediff-window-setup-function #'ediff-setup-windows-plain)
  (setq hl-line-sticky-flag nil
        global-hl-line-sticky-flag nil)

  (setq show-paren-delay 0.1
        show-paren-highlight-openparen t
        show-paren-when-point-inside-paren t)
(show-paren-mode +1)

(setq whitespace-line-column nil
      whitespace-style
      '(face indentation tabs tab-mark spaces space-mark newline newline-mark
        trailing lines-tail)
      whitespace-display-mappings
      '((tab-mark ?\t [?› ?\t])
        (newline-mark ?\n [?¬ ?\n])
        (space-mark ?\  [?·] [?.])))

(menu-bar-mode +1)

(provide 'core-ui)
;;; core-ui.el ends here

(setq-default frame-title-format '("Emacs"))

(setq-default uniquify-buffer-name-style 'forward)

(setq-default inhibit-x-resources t)

(setq-default cursor-in-non-selected-windows nil
              x-stretch-cursor nil
              visible-cursor nil)

(setq-default highlight-nonselected-windows nil)

(setq-default ring-bell-function #'ignore
              visible-bell nil)

(setq-default pos-tip-internal-border-width 6
              pos-tip-border-width 1)

(setq-default max-mini-window-height 0.3
              resize-mini-windows 'grow-only)

(setq-default mode-line-default-help-echo nil
              show-help-function nil) ; hide :help-echo text

(setq-default use-dialog-box nil) ; always avoid GUI

(setq-default indicate-buffer-boundaries nil
              indicate-empty-lines nil)

;; remove continuation arrow on right fringe
(setq-default fringe-indicator-alist (delq (assq 'continuation fringe-indicator-alist) fringe-indicator-alist))

(setq-default blink-matching-paren nil)

;; favor horizontal splits
(setq-default split-width-threshold 160)

;; inhibit resizing frame (for example on font resize)
(setq-default frame-inhibit-implied-resize nil)

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

(provide 'core-ui)
;;; core-ui.el ends here

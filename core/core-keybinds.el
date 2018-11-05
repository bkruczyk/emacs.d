(global-set-key (kbd "M-j") (lambda () (interactive) (delete-indentation 1)))

(global-set-key (kbd "M-SPC") 'cycle-spacing)

;; align arbitrary text to columns by regexp
(global-set-key (kbd "C-x |") 'align-regexp)

;; use hippie-expand instead of dabbrev
(global-set-key (kbd "M-/") 'hippie-expand)

;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; toggle menu-bar visibility
(global-set-key (kbd "<f12>") 'menu-bar-mode)

(provide 'core-keybinds)
;;; core-keybinds.el ends here

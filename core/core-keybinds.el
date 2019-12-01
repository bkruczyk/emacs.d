;;; core-keybinds.el -*- lexical-binding: t; -*-
(require 'core)

(setq mac-command-modifier 'meta
      mac-option-modifier  'super)

(global-set-key (kbd "M-j") (lambda () (interactive) (delete-indentation 1)))   ;; join lines
(global-set-key (kbd "M-SPC") 'cycle-spacing)                                   ;; cycle spacing between worbds
(global-set-key (kbd "C-x |") 'align-regexp)                                    ;; align arbitrary text to cbolumns by regexp
(global-set-key (kbd "M-/") 'hippie-expand)                                     ;; use hippie-expand instead of dabbrev
(global-set-key (kbd "C-x C-b") 'ibuffer)                                       ;; replace buffer-menu with ibuffer

(provide 'core-keybinds)
;;; core-keybinds.el ends here

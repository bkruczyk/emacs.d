(use-package evil
  :ensure t
  :ensure evil-org
  :ensure evil-paredit
  :init
  (evil-mode +1)
  ;; needed to eval after closing paren in normal mode
  (setq evil-move-beyond-eol t)
  (setq evil-disable-insert-state-bindings t)
  (add-hook 'paradox-mode-hook #'evil-paredit-mode))

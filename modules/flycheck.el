(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :init
  (add-hook 'prog-mode-hook (lambda () (flycheck-mode +1)))
  :config
  (setq flycheck-indication-mode nil))

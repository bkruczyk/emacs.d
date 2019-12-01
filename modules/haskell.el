(use-package haskell-mode
  :ensure t
  :commands haskell-mode
  :config
  (add-hook 'haskell-mode-hook
            (lambda ()
              (haskell-doc-mode +1)
              (haskell-indentation-mode +1)
              (interactive-haskell-mode +1))))

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

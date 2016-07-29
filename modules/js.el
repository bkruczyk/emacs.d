(use-package js2-mode
  :ensure t
  :commands js2-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'"    . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  :config
  (add-hook 'js2-mode-hook (lambda ()
                             (whitespace-mode +1)
                             (subword-mode +1)
                             (setq-local electric-layout-rules '((?\; . after))))))

(use-package json-mode
  :ensure t
  :commands json-mode)

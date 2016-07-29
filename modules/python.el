(require 'use-package)

;; python
(use-package python
  :commands python-mode
  :ensure anaconda-mode
  :ensure company
  :ensure company-anaconda
  :config
  (add-to-list 'company-backends 'company-anaconda)
  (add-hook 'python-mode-hook
            (lambda ()
              (whitespace-mode +1)
              (anaconda-mode +1)
              (eldoc-mode +1))))

(require 'use-package)

(use-package web-mode
  :ensure t
  :commands web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.?html\\'" . web-mode)))

(use-package yaml-mode
  :ensure t
  :commands yaml-mode)

(use-package nxml-mode
  :commands nxml-mode
  :config
  (setq nxml-bind-meta-tab-to-complete-flag t)
  (setq nxml-slash-auto-complete-flag t)
  (add-to-list 'auto-mode-alist '("\\.pom$" . nxml-mode)))

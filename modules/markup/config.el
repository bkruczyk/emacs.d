(use-package json-mode
  :ensure t
  :commands json-mode)

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

(use-package markdown-mode
  :ensure t
  :commands markdown-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode)))

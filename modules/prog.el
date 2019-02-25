(add-hook 'prog-mode-hook (lambda ()
                            (subword-mode +1)
                            (eldoc-mode +1)))
(add-hook 'lisp-mode-hook (lambda ()
                            (run-hooks 'prog-mode-hook)))
(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (run-hooks 'lisp-mode-hook)))

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :init
  (add-hook 'prog-mode-hook (lambda () (flycheck-mode +1)))
  :config
  (setq flycheck-indication-mode nil))

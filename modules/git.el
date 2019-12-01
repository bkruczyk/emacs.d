(use-package magit
  :ensure t
  :commands magit-status
  :init
  (add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . global-git-commit-mode)))
(use-package git-timemachine :ensure t)
(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package gitattributes-mode :ensure t)

(use-package magit
  :ensure t
  :commands magit-status
  :init
  (bind-key "C-x g" 'magit-status)
  (add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . global-git-commit-mode)))

(use-package git-timemachine :ensure t)
(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package gitattributes-mode :ensure t)

(use-package diff-hl
  :ensure t
  :config
  (diff-hl-dired-mode-unless-remote)
  (global-diff-hl-mode +1)
  (diff-hl-margin-mode))

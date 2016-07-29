(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  (bind-key "M-%" 'anzu-query-replace)
  (bind-key "C-M-%" 'anzu-query-replace-regexp)
  (bind-key "C-. M-%" 'anzu-query-replace-at-cursor)
  (bind-key "C-c C-. M-%" 'anzu-query-replace-at-cursor-thing)
  :diminish anzu-mode)

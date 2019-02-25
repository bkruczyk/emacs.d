(use-package org
  :commands org-mode
  :init
  (bind-key "C-c a" 'org-agenda)
  (bind-key "C-c c" 'org-capture)
  :config
  (setq org-log-done t)
  (setq org-directory (concat user-emacs-directory "/org"))
  (setq org-default-notes-file (concat org-directory "/notes.org")))

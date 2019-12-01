(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode +1))

(use-package zop-to-char :ensure t)
(use-package discover-my-major :ensure t)

(use-package ivy
  :ensure t
  :ensure counsel
  :init
  (ivy-mode +1)
  :config
  (bind-key "C-c C-r" 'ivy-resume)
  (bind-key "M-x" 'counsel-M-x))

(use-package anzu
  :ensure t
  :config
  (global-anzu-mode +1)
  (bind-key "M-%" 'anzu-query-replace)
  (bind-key "C-M-%" 'anzu-query-replace-regexp)
  (defun soup--anzu-update-func (here total)
    (when anzu--state
      (let ((status (cl-case anzu--state
                      (search (format " %d/%d " here total))
                      (replace-query (format " %d Replaces " total))
                      (replace (format " %d/%d " here total)))))
        (propertize status 'face 'anzu-mode-line))))
  (setq anzu-mode-line-update-function #'soup--anzu-update-func))

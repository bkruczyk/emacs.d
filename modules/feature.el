(use-package ivy
  :ensure t
  :ensure swiper
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
  (defun my/anzu-update-func (here total)
    (when anzu--state
      (let ((status (cl-case anzu--state
                      (search (format " %d/%d " here total))
                      (replace-query (format " %d Replaces " total))
                      (replace (format " %d/%d " here total)))))
        (propertize status 'face 'anzu-mode-line))))
  (setq anzu-mode-line-update-function #'my/anzu-update-func))

(use-package neotree
  :ensure t
  :bind ("<f8>" . neotree-toggle))

(use-package discover-my-major
  :ensure t
  :commands discover-my-major discover-my-mode
  :init
  (bind-key "C-x M-m" 'discover-my-major))

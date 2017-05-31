(use-package ivy
  :ensure t
  :ensure swiper
  :ensure counsel
  :ensure diminish
  :init
  (ivy-mode +1)
  (diminish 'ivy-mode)
  (setq recentf-run #'ivy-recentf)
  :config
  ;; (bind-key "C-s" 'swiper)
  (bind-key "C-c C-r" 'ivy-resume)
  (bind-key "M-x" 'counsel-M-x)
  (bind-key "C-x M-m" 'counsel-M-x))

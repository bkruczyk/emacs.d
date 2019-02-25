(use-package company
  :ensure t
  :commands company-complete
  :init
  (bind-key "C-c SPC" 'company-complete)
  :config
  (global-company-mode +1)
  (setq company-idle-delay 0.5)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-flip-when-above t))


(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode +1))

(use-package zop-to-char :ensure t)

(defun my/viper-delete-forward-word ()
    "Delete next word."
    (interactive)
    (if (eolp)
        (delete-indentation 1)
      (delete-region (min
                      (save-excursion
                       (viper-forward-word nil)
                       (point))
                      (line-end-position))
                     (point))))

(defun my/viper-delete-backward-word ()
  "Delete previous word."
  (interactive)
  (delete-region
   (save-excursion
     (viper-backward-word nil)
     (point))
   (point)))

(use-package viper
  :bind
  (("M-f" . viper-forward-word)
   ("M-b" . viper-backward-word)
   ("M-d" . my/viper-delete-forward-word)
   ("M-h" . my/viper-delete-backward-word)))

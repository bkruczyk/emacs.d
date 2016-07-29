(use-package ido
  :config
  (ido-mode +1)
  (ido-everywhere +1)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point 'guess
        ido-max-prospects 10
        ido-auto-merge-work-directories-length -1
        ido-default-file-method 'selected-window))

(use-package ido-ubiquitous
  :ensure t
  :config
  (ido-ubiquitous-mode +1))

(use-package flx-ido
  :ensure t
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces t)
  (flx-ido-mode +1))

(use-package smex
  :ensure t
  :commands smex smex-major-mode-commands
  :init
  (bind-key "M-x" 'smex)
  (bind-key "M-X" 'smex-major-mode-commands)
  (bind-key "C-x M-m" 'smex)
  (bind-key "C-x M-M" 'smex-major-mode-commands))

(use-package ido-vertical-mode
  :ensure t
  :config
  (ido-vertical-mode +1))

(setq recentf-run (lambda ()
   (let ((file (ido-completing-read "Pick recent file: " recentf-list nil )))
     (when file (find-file file)))))

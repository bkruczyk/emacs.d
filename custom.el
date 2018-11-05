(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("174502267725776b47bdd2d220f035cae2c00c818765b138fea376b2cdc15eb6" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default)))
 '(package-selected-packages
   (quote
    (which-key evil badwolf-theme doom-modeline highlight-numbers command-log-mode zop-to-char yaml-mode web-mode volatile-highlights use-package ruby-tools rainbow-mode rainbow-delimiters pkgbuild-mode parinfer paradox neotree markdown-mode magit json-mode inf-ruby haskell-mode gitignore-mode gitconfig-mode gitattributes-mode git-timemachine flycheck evil-goggles doom-themes discover-my-major diff-hl counsel-projectile company cider anzu adoc-mode)))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(set-face-attribute 'default nil
                    :family "Monaco"
                    :height 140
                    :weight 'normal
                    :width 'normal)

(load-theme 'doom-one-light t)

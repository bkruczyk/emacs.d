(use-package inf-ruby
  :ensure t
  :commands (inf-ruby inf-ruby-mode))

(use-package ruby-tools
  :ensure t
  :commands ruby-tools-mode)

(use-package ruby-mode
  :ensure t
  :commands ruby-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook (lambda ()
                              (subword-mode +1)
                              (inf-ruby-minor-mode +1)
                              (ruby-tools-mode +1))))


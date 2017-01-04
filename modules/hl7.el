(use-package hl7-mode
  :load-path "site-lisp/"
  :commands hl7-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.hl7\\'" . hl7-mode)))

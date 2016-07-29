(defun my-clojure-hook ()
 (whitespace-mode +1)
 (subword-mode +1)
 (eldoc-mode +1)
 (paredit-mode +1)
 (rainbow-delimiters-mode +1))

(use-package clojure-mode
  :ensure t
  :ensure paredit
  :ensure rainbow-delimiters
  :commands clojure-mode
  :config
  (add-hook 'clojure-mode-hook #'my-clojure-hook))

(use-package cider
  :ensure t
  :ensure paredit
  :ensure rainbow-delimiters
  :commands cider-mode
  :config
  (setq nrepl-log-messages t)
  (setq cider-cljs-lein-repl
        "(do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/start-figwheel!) (figwheel-sidecar.repl-api/cljs-repl))")
  (add-hook 'cider-mode-hook #'my-clojure-hook))

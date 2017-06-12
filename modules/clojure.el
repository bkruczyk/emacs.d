(defun my-clojure-hook ())

(use-package clojure-mode
  :ensure t
  :commands clojure-mode
  :config
  (add-hook 'clojure-mode-hook #'my-clojure-hook))

(use-package cider
  :ensure t
  :commands cider-mode
  :config
  (setq cider-lein-parameters "repl :headless :host localhost")
  (setq nrepl-log-messages t)
  (setq cider-cljs-lein-repl
        "(do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/start-figwheel!) (figwheel-sidecar.repl-api/cljs-repl))")
  (add-hook 'cider-mode-hook #'my-clojure-hook))

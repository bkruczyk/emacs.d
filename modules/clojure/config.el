(use-package clojure-mode
  :ensure t
  :commands clojure-mode)

(use-package cider
  :ensure t
  :commands cider-mode
  :init
  (setq cider-font-lock-dynamically '(macro core function var))
  :config
  (setq cider-lein-parameters "repl :headless :host localhost")
  (setq nrepl-log-messages t)
  (setq cider-cljs-lein-repl
        "(do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/start-figwheel!) (figwheel-sidecar.repl-api/cljs-repl))"))

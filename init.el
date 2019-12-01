;;; init.el --- Emacs init file

;; Copyright (C) 2015  Bartłomiej Kruczyk

;; Author: bkruczyk <bartlomiej.kruczyk@gmail.com>

(require 'core (concat user-emacs-directory "core/core.el"))
(require 'core-editor (concat user-emacs-directory "core/core-editor.el"))
(require 'core-ui (concat user-emacs-directory "core/core-ui.el"))
(require 'core-keybinds (concat user-emacs-directory "core/core-keybinds.el"))
(require 'core-os (concat user-emacs-directory "core/core-os.el"))
(require 'core-package (concat user-emacs-directory "core/core-package.el"))

(load-file (concat user-emacs-directory "modules/editor.el"))
(load-file (concat user-emacs-directory "modules/ui.el"))
(load-file (concat user-emacs-directory "modules/flycheck.el"))
(load-file (concat user-emacs-directory "modules/git.el"))
(load-file (concat user-emacs-directory "modules/completion.el"))
(load-file (concat user-emacs-directory "modules/markup.el"))
(load-file (concat user-emacs-directory "modules/clojure.el"))
(load-file (concat user-emacs-directory "modules/haskell.el"))
(load-file custom-file)
;;; init.el ends here

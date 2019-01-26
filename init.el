;;; init.el --- Emacs init file

;; Copyright (C) 2015  Bartłomiej Kruczyk

;; Author: bkruczyk <bartlomiej.kruczyk@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Emacs configuration assembled mostly from Prelude and DOOM parts.

;;; Code:

(require 'core (concat user-emacs-directory "core/core.el"))
(require 'core-editor (concat user-emacs-directory "core/core-editor.el"))
(require 'core-ui (concat user-emacs-directory "core/core-ui.el"))
(require 'core-keybinds (concat user-emacs-directory "core/core-keybinds.el"))
(require 'core-os (concat user-emacs-directory "core/core-os.el"))
(require 'core-package (concat user-emacs-directory "core/core-package.el"))

(load-file (concat user-emacs-directory "modules/editor/config.el"))
(load-file (concat user-emacs-directory "modules/feature/config.el"))
(load-file (concat user-emacs-directory "modules/ui/config.el"))
(load-file (concat user-emacs-directory "modules/org/config.el"))
(load-file (concat user-emacs-directory "modules/prog/config.el"))
(load-file (concat user-emacs-directory "modules/git/config.el"))
(load-file (concat user-emacs-directory "modules/completion/config.el"))

(load-file (concat user-emacs-directory "modules/markup/config.el"))
(load-file (concat user-emacs-directory "modules/clojure/config.el"))
(load-file (concat user-emacs-directory "modules/haskell/config.el"))
(load-file (concat user-emacs-directory "modules/ruby/config.el"))

(load-file custom-file)
;;; init.el ends here

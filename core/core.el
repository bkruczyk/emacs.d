(defvar doom-emacs-dir (file-truename user-emacs-directory)
  "The path to this emacs.d directory.")

(defvar doom-local-dir (concat doom-emacs-dir ".local/")
  "Root directory for local Emacs files. Use this as permanent storage for files
that are safe to share across systems (if this config is symlinked across
several computers).")

(defvar doom-etc-dir (concat doom-local-dir "etc/")
  "Directory for non-volatile storage.

Use this for files that don't change much, like servers binaries, external
dependencies or long-term shared data.")

(defvar doom-cache-dir (concat doom-local-dir "cache/")
  "Directory for volatile storage.

Use this for files that change often, like cache files.")

;; utf-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system        'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
(setq auto-save-list-file-prefix nil)

;; do not create lockfiles
(setq create-lockfiles nil)

;; supress ad-redefinition messages
(setq ad-redefinition-action 'accept)

;; always load newest byte code
(setq load-prefer-newer t)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 100000000)

(setq large-file-warning-threshold 1000000)

(setq history-length 500)

(setq-default compilation-always-kill t
              compilation-ask-about-save nil
              compilation-scroll-output t)

(setq-default apropos-do-all t)

(setq confirm-nonexistent-file-or-buffer t)
(setq enable-recursive-minibuffers nil)
(setq idle-update-delay 2)

;; keep the point out of the minibuffer
(setq minibuffer-prompt-properties '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt))

(provide 'core)
;;; core.el ends here

(defvar soup-local-dir (concat user-emacs-directory ".local/"))
(defvar soup-cache-dir (concat soup-local-dir "cache/"))
(setq custom-file (concat soup-local-dir "custom.el"))

;; 
(setq ad-redefinition-action 'accept)

;;
(setq gc-cons-threshold 100000000)

;; idle time before updating various things on the screen
(setq idle-update-delay 2)

;; disable bidirectional text rendering for a modest performance boost.
(setq-default bidi-display-reordering 'left-to-right)

;; remove command line options that aren't relevant to our current OS; that
;; means less to process at startup.
(setq command-line-ns-option-alist nil)

(provide 'core)

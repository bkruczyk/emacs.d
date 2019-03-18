(defsubst my/column-info (pos)
  "Current column position from point POS."
  (save-excursion (goto-char pos)
                  (current-column)))

(defun my/selection-info ()
  "Information about the current selection, such as how many characters and lines are selected, or the NxM dimensions of a block selection."
  (when mark-active
    (let ((reg-beg (region-beginning))
          (reg-end (region-end)))
      (format "[%s]"
              (let ((lines (count-lines reg-beg (min (1+ reg-end) (point-max)))))
                (cond ((bound-and-true-p rectangle-mark-mode)
                       (let ((cols (abs (- (my/column-info reg-end)
                                           (my/column-info reg-beg)))))
                         (format "%dx%d" lines cols)))
                      ((> lines 1)
                       (format "%dL" lines))
                      (t (format "%dC" (- reg-end reg-beg)))))))))

(defun my/macro-recording-info ()
  "Macro recording indicator."
  (when (or defining-kbd-macro executing-kbd-macro) "MACRO"))

(defun my/simple-mode-line-render (left right)
  "Return a string of `window-width' length containing LEFT, and RIGHT aligned respectively."
  (let* ((available-width (- (window-width) (length left) 2)))
    (format (format " %%s %%%ds " available-width) left right)))

(defun my/buffer-encoding ()
  "Displays the encoding and eol style of the buffer the same way Atom does."
  (propertize (pcase (coding-system-eol-type buffer-file-coding-system)
               (0 "LF")
               (1 "CRLF")
               (2 "CR"))
              'help-echo (let ((sys (coding-system-plist buffer-file-coding-system)))
                           (cond ((memq (plist-get sys :category) '(coding-category-undecided coding-category-utf-8))
                                  "UTF-8")
                                 (t (upcase (symbol-name (plist-get sys :name))))))))

(defvar my/mode-line-left nil)
(defvar my/mode-line-right nil)

(defcustom my/anzu-status nil "My anzu status." :risky t)

(setq my/mode-line-left '(my/anzu-status
                          "%e"
                          mode-line-front-space
                          ;; mode-line-client
                          ;; mode-line-modified
                          ;; mode-line-remote
                          ;; mode-line-frame-identification
                          mode-line-buffer-identification
                          ;; evil-mode-line-tag
                          "   "
                          mode-line-position))

(setq my/mode-line-right '((vc-mode vc-mode)
                           (:eval (my/selection-info))
                           mode-line-misc-info
                           (:eval (my/macro-recording-info))
                           "   "
                           (:propertize mode-name face mode-line-emphasis)
                           "   "
                           (:eval (my/buffer-encoding))
                           mode-line-end-spaces))

(defun my/build-mode-line ()
  "Build mode-line construct."
  '((:eval (my/simple-mode-line-render
            (mapconcat #'format-mode-line my/mode-line-left "")
            (mapconcat #'format-mode-line my/mode-line-right "")))))

(defun my/update-mode-line ()
  "Update mode line format."
  (setq mode-line-format (my/build-mode-line)))

(setq-default mode-line-format (my/build-mode-line))

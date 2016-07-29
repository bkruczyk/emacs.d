;;; mail

(setq message-kill-buffer-on-exit t)

(setq message-directory "~/.mail"
      message-auto-save-directory "~/tmp")

(setq user-mail-address "bartlomiej.kruczyk@invicta.pl"
      user-full-name "Bartłomiej Kruczyk")

(setq smtpmail-stream-type 'plain
      smtpmail-smtp-server "192.168.0.216"
      smtpmail-smtp-service 587)

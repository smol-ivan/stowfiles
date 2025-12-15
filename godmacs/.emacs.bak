;(add-to-list 'package-archives
;	     '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(setq custom-file "~/.emacs.custom.el")

(add-to-list 'load-path "~/.emacs.local/")

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(when (file-exists-p custom-file)
  (load custom-file))

(load "~/.emacs.rc/rc.el")

(add-to-list 'default-frame-alist
	     '(font . "Iosevka Nerd Font Mono-18:"))

(rc/require 'rust-mode)
(rc/require 'gruvbox-theme)
(rc/require 'hungry-delete)
(rc/require 'protobuf-mode)
(rc/require 'smex)
(rc/require 'kotlin-mode)

(add-hook 'rust-mode-hook
	  (lambda () (setq indent-tabs-mode nil)))

(add-hook 'rust-mode-hook 'hungry-delete-mode)

(ido-mode 1)
(ido-everywhere 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(setq inhibit-startup-screen t)

;(setq backup-directory-alist '(("." . "~/emacs_saves")))

(setq make-backup-files nil)
(setq tab-width 4)
(setq indent-tabs-mode nil)

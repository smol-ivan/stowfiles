(setq user-full-name "Ivan Gordillo")
(setq user-mail-address "gordillosolis@icloud.com")

(setq gc-cons-threshold (* 8 1024 1024 1024))
(run-with-idle-timer 10 t (lambda () (garbage-collect)))
(setq read-process-output-max (* 1024 1024))

(setq package-install-upgrade-built-in t)
(progn (unload-feature 'seq t) (require 'seq))

(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)
(setq package-archives ())
(setq package-native-compile t)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(global-set-key (kbd "C-SPC") 'set-mark-command)

(setq custom-file "~/.emacs.custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;;; MAC_ONLY
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

(setq make-backup-files nil)

(require 'use-package)
(setq use-package-always-ensure t)
(setq use-package-always-defer nil)
(setq use-package-always-demand nil)
(setq use-package-expand-minimally nil)
(setq use-package-hook-name-suffix nil)
(setq use-package-compute-statistics nil)

;; UTF-8 all the things!
(define-coding-system-alias 'UTF-8 'utf-8)
(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system        'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq inhibit-startup-buffer-menu t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq ring-bell-function 'ignore)
(fset 'yes-or-no-p 'y-or-n-p)

;(menu-bar-mode tool)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(save-place-mode 1)
(set-fill-column 100)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)


(add-to-list 'default-frame-alist
	     '(font . "Iosevka Nerd Font Mono-15:"))

(use-package smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(use-package seoul256-theme)
(use-package moe-theme)
(use-package ample-theme)
(use-package gruber-darker-theme)
(use-package kanagawa-themes)

(add-to-list 'load-path "~/.emacs.local/")
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(use-package paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
;; (add-hook 'rust-mode-hook 'enable-paredit-mode)
;; (add-hook 'python-mode-hook 'enable-paredit-mode)
;; (add-hook 'simpc-mode-hook 'enable-paredit-mode)
;; (add-hook 'json-mode-hook 'enable-paredit-mode)

(use-package smartparens
  :ensure smartparens  ;; install the package
  :hook (prog-mode text-mode markdown-mode rust-mode simpc-mode python-mode) 
  :config
  (require 'smartparens-config))

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package yaml-mode
 :mode ("\\.yml$" . yaml-mode))

(use-package json-mode)

(use-package go-mode
  :mode ("\\.go\\'" . go-mode)
  :config
  (add-hook 'go-mode-hook
            (lambda ()
              (setq-local tab-width 4)
              (setq-local indent-tabs-mode nil))))

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(ido-mode 1)
(ido-everywhere 1)

(use-package python
  :init
  (setq-default indent-tabs-mode nil)
  :mode
  ("\\.py\\'" . python-mode)
  ("\\.wsgi$" . python-mode)
  :interpreter ("python" . python-mode)
  :config
  (setq python-indent-offset 4)
  (setq python-indent-guess-indent-offset-verbose nil))

(use-package rust-mode
  :init
  :config
  (setq tab-width 4)
  (setq indent-tabs-mode nil))

;; (use-package flycheck
;;   :ensure t
;;   :config
;;   (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package company
  :config
  (add-hook 'after-init-hook #'global-company-mode))

(use-package tree-sitter
  :hook
  (after-init-hook . global-tree-sitter-mode)
  (tree-sitter-after-on-hook . tree-sitter-hl-mode))

(use-package tree-sitter-langs)

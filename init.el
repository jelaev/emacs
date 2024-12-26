(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(use-package use-package
  :ensure t)

(use-package pbcopy
  :ensure t)

(turn-on-pbcopy)

(use-package clojure-mode
  :ensure t)

(use-package lsp-mode
  :ensure t)

(use-package lsp-treemacs
  :ensure t)

(use-package flycheck
  :ensure t)

(use-package cider
  :ensure t)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map)))

(use-package company
  :ensure t)

(add-hook 'after-init-hook 'global-company-mode)

(use-package vertico
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(pbcopy all-the-icons dashboard nerd-icons page-break-lines projectile cider flycheck lsp-treemacs lsp-mode clojure-mode company vertico-mode)))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Move backup files
(setq backup-directory-alist `(("." . "~/.saves_emacs")))

;; Auto complete
(add-hook 'cider-repl-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojure-mode-hook 'lsp)

(setq company-idle-delay 0)
(setq company-dbabrev-downcase 0)

(global-set-key (kbd "C-c C-RET") #'company-complete)
						    
;;Projectile dir
(setq projectile-project-search-path '("~/Projects/"))
(global-set-key (kbd "C-c p") #'projctile-command-map)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; KBD
(global-set-key (kbd "C-x C-d") 'cider-find-var)
(global-set-key (kbd "C-x .") 'cider-pop-back)

(setq cider-use-xref t)
(global-set-key (kbd "C-x C-r") 'xref-find-reference)

(add-hook 'clojure-mode-hook #'imenu-add-menubar-index)
(global-set-key (kbd "<C-i>") 'helm-imenu)
(setq imenu-use-popup-menu nil)

;; Emacs Awesome
;; Dashboard

(use-package page-break-lines
  :ensure t)

(use-package all-the-icons
  :if (display-graphic-p))

(use-package nerd-icons)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-banner-logo-title "My dashboard")

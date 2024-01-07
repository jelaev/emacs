(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(use-package use-package
  :ensure t)

(use-package company
  :ensure t)

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

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map))
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inferior-lisp-program "clojure")
 '(package-selected-packages
   '(clojure-lsp vertico projectile cider clojure-mode company use-package)))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Move backup files
(setq backup-directory-alist `(("." . "~/.saves_emacs")))

;; Auto complete
(add-hook 'cider-repl-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojure-mode-hook 'lsp)

(setq company-idle-delay nil) ; never start completions automatically
(global-set-key (kbd "C-<return>") #'company-complete) ; use M-TAB, a.k.a. C-M-i, as manual trigger

;; Projectile dir
(setq projectile-project-search-path '("~/projects"))
(global-set-key (kbd "C-c p") #'projectile-command-map)  

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

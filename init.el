;; -> WINDOW SIZE
;; Right corner
(set-frame-position (selected-frame) 0 0)
;; Left corner
;;(set-frame-position (selected-frame) 1050 0)
(set-frame-height (selected-frame) 65)
(set-frame-width (selected-frame) 120)

;; -> CONSTS
(defconst init-emacs-package-user-dir "~/.emacs.d/elpa/")

;; -> PACKAGE
;; Встроенный пакет для управления пакетами.
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "http://elpa.nongnu.org/nongnu/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist `(("." . "~/.saves_emacs")))
 '(cider-use-xref t)
 '(company-dbabrev-downcase 0)
 '(company-idle-delay 0)
 '(compilation-scroll-output t)
 '(create-lockfiles nil)
 '(cursor-type 'bar)
 '(delete-by-moving-to-trash nil)
 '(gc-cons-threshold (* 50 1000 1000))
 '(imenu-use-popup-menu nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(menu-bar-mode nil)
 '(package-archive-priorities '(("nongnu" . 40) ("melpa-stable" . 30) ("melpa" . 20)))
 '(package-native-compile t)
 '(package-selected-packages
   '(apheleia rainbow-delimiters magit helm-projectile pbcopy all-the-icons dashboard nerd-icons page-break-lines projectile cider lsp-treemacs lsp-mode clojure-mode company vertico-mode))
 '(package-user-dir init-emacs-package-user-dir)
 '(projectile-project-search-path '("~/Projects/"))
 '(read-file-name-completion-ignore-case t)
 '(reverse-im-input-methods '("russian-computer"))
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(scroll-margin 4)
 '(show-trailing-whitespace t)
 '(standard-indent 2)
 '(tab-always-indent 'complete)
 '(tool-bar-mode nil)
 '(truncate-lines 1)
 '(use-dialog-box nil)
 '(use-short-answers t)
 '(user-full-name "Zhelaev Alexandr")
 '(user-mail-address "jelaev@yandex.ru")
 '(vc-follow-symlinks t)
 '(visible-bell t))
(add-to-list 'package-pinned-packages '("use-package" . "gnu"))

;; Проверка наличия пакета `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package t))

(require 'use-package)

(use-package use-package
  :ensure t)

;; -> TOOL-BAR
(when (fboundp 'tool-bar-mode)
  (require 'tool-bar)
  (custom-set-variables '(tool-bar-mode nil "Отключить панель иснтрументов")))

;; -> AUTOREVERT
;; Встроенный пакет
(use-package autorevert
  :ensure t
  :hook
  (dired-mode . auto-revert-mode))

;; -> DIRED
(use-package dired
  :custom
  (dired-kill-when-opening-new-dired-buffer t "Remove buffer if change directory"))

;; -> NERD-ICONS-DIRED
(use-package nerd-icons-dired
  :ensure t
  :after (dired nerd-icons)
  :hook (dired-mode . nerd-icons-dired-mode))

;; Для работы команд на русской раскладке
(use-package reverse-im
  :ensure t
  :custom
  (reverse-im-mode 1))

;; -> HELM
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  :bind (:map global-map
              ("C-x C-f" . helm-find-files)
              ("C-x b" . helm-buffers-list)
              ("M-x" . helm-M-x)
              ("M-y" . helm-show-kill-ring)))

(use-package helm-projectile
  :ensure t
  :requires (helm projectile)
  :after (helm projectile)
  :config (helm-projectile-on))

(use-package pbcopy
  :ensure t)

;; -> ON COPY FROM SYS BUF
(turn-on-pbcopy)

;; -> CLOJURE-MODE
(use-package clojure-mode
  :ensure t)

;; -> Rainbow Delimiters
(use-package rainbow-delimiters
  :ensure t
  :hook (clojure-mode . rainbow-delimiters-mode))

(use-package lsp-mode
  :ensure t)

(use-package lsp-treemacs
  :ensure t)

;; -> FLYCHECK-CLOJURE
;;(use-package flycheck-clojure
;;  :defer t
;;  :commands (flycheck-clojure-setup)
;;  :config
;;  (eval-after-load 'flycheck
;;    '(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages))
;;  (add-hook 'after-init-hook #'global-flycheck-mode))

;; -> FLYCHECK
;;(use-package flycheck
;;  :ensure t
;;  :defer t
;;  :custom
;;  (flycheck-check-syntax-automatically '(mode-enabled save new-line))
;;  (flycheck-highlighting-mode 'lines)
;;  (flycheck-indication-mode 'left-fringe)
;;  (flycheck-disabled-checkers '(emacs-lisp-checkdoc))
;;  (flycheck-locate-config-file-functions '(
;;                                          flycheck-locate-config-file-by-path
;;                                           flycheck-locate-config-file-ancestor-directories
;;                                           flycheck-locate-config-file-home))
;;  :hook ((clojure-mode emacs-lisp-mode json-mode) . flycheck-mode))

;;(use-package flycheck-pos-tip :ensure t :after flycheck)

;; -> CIDER
(use-package cider
  :ensure t
  :defer t
  :config (setq
           cider-repl-history-file ".cider-repl-history"
           nrepl-log-messages t))
;;(flycheck-clojure-setup))


;; -> PROJECTILE
(use-package projectile
  :ensure t
  :config
  (projectile-mode 1)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map)))

;; -> COMPANY
(use-package company
  :ensure t
  :hook ((clojure-mode cider-mode cider-repl-mode) . company-mode)
  :bind
  (:map company-mode
        ("C-c c" . company-indent-or-complete-common)))

(add-hook 'after-init-hook 'global-company-mode)

;; -> VERTICO
(use-package vertico
  :ensure t)

;; -> MAGIT
(use-package magit
  :pin "melpa"
  :ensure t
  :defer t
  :custom
  (magit-define-global-key-bindings t)
  :config
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))


;; -> NXML-MODE
;; Встроенный пакет.
;; Работа с XML с поддержкой RELAX NG (use-package nxml-mode
(use-package nxml-mode
  :defer t
  :custom
  (nxml-attribute-indent 4 "Выравнивание атрибутов")
  (nxml-auto-insert-xml-declaration-flag nil "Не вставлять декларацию")
  (nxml-bind-meta-tab-to-complete-flag t "Использовать TAB для завершения ввода")
  (nxml-child-indent 4 "Выравнивание дочерних элементов")
  (nxml-slash-auto-complete-flag t "Закрывать теги по вводу /")
  :commands nxml-mode
  :mode
  (
   "\\.pom\\'"
   "\\.xml\\'"))

;; APHELEIA formatter
;; please install: npm install --global @chrisoakman/standard-clojure-style
(use-package apheleia
  :ensure t
  :diminish ""
  :defines
  apheleia-formatters
  apheleia-mode-alist
  :functions
  apheleia-global-mode
  :config
  (setf (alist-get 'standard-clojure apheleia-formatters) '("standard-clj" "fix" "-"))
  (apheleia-global-mode +1))

;; Undo to Ctrl+z
(global-set-key (kbd "C-z") #'undo)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Auto complete
(add-hook 'cider-repl-mode-hook 'lsp)
(add-hook 'clojurescript-mode-hook 'lsp)
(add-hook 'clojure-mode-hook 'lsp)


(global-set-key (kbd "C-c C-RET") #'company-complete)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; KBD
(global-set-key (kbd "C-x C-d") 'cider-find-var)
(global-set-key (kbd "C-x .") 'cider-pop-back)


(global-set-key (kbd "C-x C-r") 'xref-find-reference)
(global-set-key (kbd "C-x C-.") 'xref-find-definitions)
(global-set-key (kbd "C-x C-,") 'xref-go-back)
(global-set-key (kbd "M-.") 'end-of-buffer)
(global-set-key (kbd "M-,") 'beginning-of-buffer)

(add-hook 'clojure-mode-hook #'imenu-add-menubar-index)
(global-set-key (kbd "<C-i>") 'helm-imenu)


;; Emacs Awesome
;; Dashboard

(use-package dashboard
  :ensure t
  :custom
  (dashboard-display-icons-p t "Включить отображение иконок")
  (dashboard-icon-type 'nerd-icons "Использовать иконки из пакета `nerd-icons'")
  (dashboard-items ;; Элементы дашборда
   '(
     (recents . 15) ;; Последние открытые файлы, 15 шт.
     (bookmarks . 10) ;; Последние закладки, 10 шт.
     (projects . 10) ;; Последние проекты, 10 шт.
     (agenda . 10) ;; Мероприятия, 10 шт.
     (registers . 10))) ;; Регистры, 10 шт.
  (dashboard-set-footer nil "Скрыть \"весёлые\" надписи в нижней части дашборда")
  (dashboard-set-file-icons t "Показывать иконки рядом с элементами списков")
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda ()(get-buffer "*dashboard*")))) ;; Теперь Dashboard будет буфером по умолчанию после запуска

(provide 'init.el)


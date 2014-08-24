(require 'package)
(package-initialize)
(load-file "~/.emacs.d/elpa/railscasts-theme.el")

;; melpa & marmalade repos
(load "package")
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-archive-enable-alist '(("melpa" deft magit)))

;; 2 spaces for tab
(setq default-tab-width 2)

(setq make-backup-files nil) ; Don't want any backup files
(setq auto-save-list-file-name nil) ; Don't want any .saves files
(setq auto-save-default nil) ; Don't want any auto saving

;; Vim-like Ctrl + U key behavior
(setq evil-want-C-u-scroll t)

;; Vim mode
(evil-mode)

;; toggle off menu bar
(menu-bar-mode 0)

;;(require 'bs)
;;(setq bs-configurations
;;'(("files" "^\\*scratch\\*" nil nil bs-visits-non-file bs-sort-buffer-interns-are-last)))
;;(global-set-key (kbd "<f1>") 'bs-show)

(require 'auto-complete-config)
(ac-config-default)

(global-set-key (kbd "<f1>") 'buffer-menu)
(global-set-key (kbd "<f9>") 'list-packages)
(global-set-key (kbd "<f8>") 'elfeed)
(global-set-key (kbd "<f2>") 'previous-buffer)
(global-set-key (kbd "<f3>") 'next-buffer)
(global-set-key (kbd "<f11>") 'grunt-exec)
(global-set-key (kbd "<f5>") 'ido-find-file)

(custom-set-variables
  '(elfeed-feeds (quote ("http://habrahabr.ru/rss"))))
(custom-set-faces)

(require 'linum+)
;; line numbers workaround
(setq linum-format "%d ")
(global-linum-mode 1)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)


(require 'sr-speedbar)
(global-set-key (kbd "<f12>") 'sr-speedbar-toggle)

(require 'yasnippet)
(yas-global-mode 1)

(require 'projectile)
(projectile-global-mode 1)

(setq projectile-completion-system 'grizzl)

(require 'flymake-jshint)
(add-hook 'javascript-mode-hook
     (lambda () (flymake-mode t)))
(add-hook 'js-mode-hook 'flymake-jshint-load)

(require 'flymake-cursor)
(when (load "flymake" t)
  (defun flymake-jslint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
											        'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "jslint" (list "--terse" local-file))))

  (setq flymake-err-line-patterns
				(cons '("^\\(.*\\)(\\([[:digit:]]+\\)):\\(.*\\)$"
								1 2 nil 3)
							      flymake-err-line-patterns))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.js\\'" flymake-jslint-init))

)

(add-hook 'js2-mode-hook
					  (lambda ()
      (flymake-mode 1)
      (define-key js2-mode-map "\C-c\C-n" 'flymake-goto-next-error)))


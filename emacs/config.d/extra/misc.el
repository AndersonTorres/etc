;;; -*- lexical-binding: t; no-byte-compile: t -*-

;; This file will contain some random snippets of code, intended for quick
;; customizations without the hassle of configuring layers

;; C language

(defun at1985|c-hook ()
  (setq-default indent-tabs-mode nil)
  (setq c-basic-offset 4
        c-indent-level 4
        c-default-style "bsd"))

(add-hook 'c-mode-common-hook 'at1985|c-hook)
(add-hook 'c-mode-common-hook 'smartparens-mode)

;; frame configuration

(setq initial-frame-alist (quote ((fullscreen . maximized))))
(add-to-list 'default-frame-alist '(width . 80)) ; characters
(add-to-list 'default-frame-alist '(height . 24)) ; lines

;; smerge
(setq smerge-command-prefix (kbd "C-c m"))
;; (defhydra hydra-zoom (global-map "<f2>")
;;   "zoom"
;;   ("g" text-scale-increase "in")
;;   ("l" text-scale-decrease "out"))

(defhydra hydra-smerge (global-map "<f5>")
  "SMERGE"
  ("p" smerge-previous)
  ("n" smerge-next)
  ("u" smerge-keep-upper)
  ("l" smerge-keep-lower))

;; Parenthesis
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis)
(show-paren-mode t)

(set-face-attribute 'default nil
                    :height 150)

(setq dired-listing-switches "-ahil --group-directories-first")

(global-display-fill-column-indicator-mode)
(global-unset-key (kbd "C-x g"))

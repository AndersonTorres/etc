;;; init.el --- Emacs init file -*- lexical-binding: t -*-

;;; Commentary:
;;  Emacs init file
;;  It just loads config.org.
;;;

;;; Code:

(require 'package)
(package-initialize)

(require 'org)
(org-babel-load-file (concat user-emacs-directory "config.org"))

(provide 'init)

;; Local Variables:
;; mode: emacs-lisp
;; coding: utf-8-unix
;; fill-column: 80
;; End:

;;; init.el ends here

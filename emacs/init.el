;;; --* lexical-binding: t; no-byte-compile: nil -*-

;;; Wrapper file in order to load "the true" init.el file

;; at1985|profile-basedir and at1985|profile-name are defined in early-init.el

(setq
 user-emacs-directory (concat at1985|profile-basedir at1985|profile-name "/")
 user-init-file (expand-file-name "init.el" user-emacs-directory))

(load-file user-init-file)

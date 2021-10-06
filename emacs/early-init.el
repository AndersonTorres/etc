;;; --* lexical-binding: t; no-byte-compile: nil -*-

;;; Wrapper file in order to load "the true" early-init.el file

(setq at1985|profile-name "config.d"
      at1985|profile-basedir "~/.config/emacs/")

(load (concat at1985|profile-basedir
              at1985|profile-name
              "/early-init.el")
      t t t)

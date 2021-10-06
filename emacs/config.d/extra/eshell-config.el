;;; -*- lexical-binding: t; no-byte-compile: t -*-

(defmacro with-face (str &rest properties)
  `(propertize ,str 'face (list ,@properties)))

(defun at1985|eshell-prompt ()
  (let ((header-bg "#000"))
    (concat "\n"
            (with-face (concat (eshell/pwd) " ")
                       :background header-bg)
            (with-face (format-time-string "(%Y-%m-%d %H:%M) "
                                           (current-time))
                       :background header-bg
                       :foreground "#0000FF")
            (with-face
             (or (ignore-errors
                   (format "(%s)"
                           (vc-responsible-backend default-directory)))
                 "")
             :background header-bg)
            (with-face " " :background header-bg)
            (with-face "|" :background "grey")
            (with-face user-login-name
                       :foreground "blue")
            "@"
            (with-face "localhost"
                       :foreground "green")
            (if (= (user-uid) 0)
                (with-face " #\n> "
                           :foreground "red")
              (with-face " $\n> "
                         :foreground "green")))))

(setq eshell-prompt-function 'at1985|eshell-prompt)
(setq eshell-highlight-prompt nil)

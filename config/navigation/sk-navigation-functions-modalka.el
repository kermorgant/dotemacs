;;; sk-navigation-functions-modalka.el --- Global settings -*- lexical-binding: t; -*-

;;; Commentary:

;; Modalka bindings for user-defined functions

;;; Code:

;; Matching paren
(modalka-define-kbd "%" "C-c v %")

;; Fullscreen
(modalka-define-kbd "SPC z" "C-z")

;; DocView
(modalka-define-kbd "] d" "C-S-n")
(modalka-define-kbd "[ d" "C-S-p")

;; Marks
(modalka-define-kbd ">" "C-c v C-i")

;; Open current html file in browser
(modalka-define-kbd "g B" "C-c v g B")

;; which key explanations for modalka bindings
(require 'sk-navigation-functions-modalka-which-key)

(provide 'sk-navigation-functions-modalka)
;;; sk-navigation-functions-modalka.el ends here
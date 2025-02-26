;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "evil" "20250116.1028"
  "Extensible vi layer."
  '((emacs    "24.1")
    (cl-lib   "0.5")
    (goto-chg "1.6")
    (nadvice  "0.3"))
  :url "https://github.com/emacs-evil/evil"
  :commit "9adbebddcdd495b53748559fae7750bbcf9eec6b"
  :revdesc "9adbebddcdd4"
  :keywords '("emulations")
  :maintainers '(("Tom Dalziel" . "tom.dalziel@gmail.com")))

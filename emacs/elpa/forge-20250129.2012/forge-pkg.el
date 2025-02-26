;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "forge" "20250129.2012"
  "Access Git forges from Magit."
  '((emacs         "29.1")
    (compat        "30.0.1.0")
    (closql        "2.2.0")
    (emacsql       "4.1.0")
    (ghub          "4.2.0")
    (let-alist     "1.0.6")
    (llama         "0.5.0")
    (magit         "4.2.0")
    (markdown-mode "2.6")
    (seq           "2.24")
    (transient     "0.8.2")
    (yaml          "0.5.5"))
  :url "https://github.com/magit/forge"
  :commit "0e1579b49fd65bd2bba34487c03cec1dd977313d"
  :revdesc "0e1579b49fd6"
  :keywords '("git" "tools" "vc")
  :authors '(("Jonas Bernoulli" . "emacs.forge@jonas.bernoulli.dev"))
  :maintainers '(("Jonas Bernoulli" . "emacs.forge@jonas.bernoulli.dev")))

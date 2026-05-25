;;;; goldentag.asd

(asdf:defsystem #:goldentag
  :description ""
  :author "Lovebird Connoisseur <90262313+Lovebird-Connoisseur@users.noreply.github.com>"
  :license "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:fiveam
               #:fset)
  :components ((:file "package")
               (:file "goldentag")
               (:file "tests")))

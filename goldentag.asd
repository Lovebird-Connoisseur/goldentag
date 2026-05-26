;;;; goldentag.asd

(asdf:defsystem #:goldentag
  :description ""
  :author "Lovebird Connoisseur <90262313+Lovebird-Connoisseur@users.noreply.github.com>"
  :license "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:fset)
  :in-order-to ((asdf:test-op (asdf:test-op #:goldentag/test)))
  :components ((:file "package")
               (:file "goldentag")))

(asdf:defsystem #:goldentag/test
  :description "Test suite for goldentag"
  :author "Lovebird Connoisseur <90262313+Lovebird-Connoisseur@users.noreply.github.com>"
  :license "MIT"
  :serial t
  :depends-on (#:goldentag
               #:fiveam)
  :components ((:file "tests"))
  :perform (asdf:test-op (o s) (uiop:symbol-call :fiveam '#:run! 'tests:test-suite)))

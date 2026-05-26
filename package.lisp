;;;; package.lisp

(in-package :cl-user)

(defpackage #:goldentag
  (:use #:cl)
  (:export #:tag #:untag))

(defpackage tests
  (:use #:cl
        #:fiveam)
  (:export #:test-suite))

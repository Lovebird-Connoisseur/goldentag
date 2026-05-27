;;;; goldentag.lisp

(in-package #:goldentag)

;; TODO: Support for nested maps
(defun tag (taglist field field-value &key append overwrite)
  "Returns a copy of TAGLIST with the entry (FIELD FIELD-VALUE) added.

The argument TAGLIST should be a `fset2:map'.

The argument FIELD should be a symbol.

Neither FIELD nor FIELD-VALUE should contain any illegal filename characters.

It should be noted that OVERWRITE takes precedence over APPEND."
  (cond ((or overwrite
             (not (fset2:lookup taglist field)))
         (fset2:map (fset2:$ taglist) (field field-value)))
        (append (let* ((cur-value (fset2:lookup taglist field))
                       (new-value (alexandria:flatten (list cur-value field-value))))
                  (fset2:map (fset2:$ taglist) (field new-value))))
        (t taglist)))

(defun untag (taglist field &optional target)
  "Returns a copy of TAGLIST with the specified FIELD removed.
Optionally, if TARGET was provided, only the TARGET value is removed from field.

The argument TAGLIST should be a `fset2:map'.

The argument FIELD should be a symbol.

The argument TARGET should be a value.

Neither FIELD nor TARGET should contain any illegal filename characters."
  (if (null target)
      (fset2:less taglist field)
      (fset2:map (fset2:$ taglist) (field (remove
                                           target
                                           (fset2:lookup taglist field)
                                           :test #'fset2:equal?)))))

;; TODO: Should it fail, if FIELD doesn't exist?
(defun equals-tag? (taglist field value &optional test)
  "Compare VALUE and return T if they are equal or nil if they differ.

If FIELD does not exist, return nil.

The argument TAGLIST should be a `fset2:map'.

The argument FIELD should be a symbol.

The argument VALUE should be a value.

The argument TEST should be an equality function.

Neither FIELD nor VALUE should contain any illegal filename characters.
"
  (let ((field-value (fset2:lookup taglist field)))
    (if test
        (funcall test field-value value)
        (fset2:equal? field-value value))))

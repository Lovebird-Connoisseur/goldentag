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

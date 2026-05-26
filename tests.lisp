(in-package :tests)

(defconstant +default-tag-list+ (fset2:map ('title "Title")
                                           ('existing-field "test")
                                           ('description "This is a description")
                                           ('author (list "John" "Doe"))
                                           ('hash "AHHB234234"))
  "Default tag list used for testing purposes.")

(def-suite test-suite
  :description "Root test suite.")

(def-suite* tag :in test-suite)


(test new-tag
  (let* ((new-field 'new-field)
         (field-value "New field value")
         (new-tag-list (goldentag:tag +default-tag-list+ new-field field-value))
         (new-field-value (fset2:lookup new-tag-list new-field)))
    (is (fset2:equal? new-field-value field-value))))

(test tag-already-exists
  (let* ((field-value "New value")
         (field 'existing-field)
         (new-tag-list (goldentag:tag +default-tag-list+ field field-value)))
    (is (fset2:equal? +default-tag-list+ new-tag-list))))

(test tag-append
  (let* ((existing-field 'author)
         (new-value "Hunter")
         (expected-result (append (fset2:lookup +default-tag-list+ existing-field) (list new-value)))
         (new-tag-list (goldentag:tag +default-tag-list+ existing-field new-value :append t)))
    (is (fset2:equal? expected-result (fset2:lookup new-tag-list existing-field)))))

(test tag-append-non-existant
  (let* ((non-existing-field 'non-existing-field)
         (new-value "Some Value")
         (expected-result new-value)
         (new-tag-list (goldentag:tag +default-tag-list+ non-existing-field new-value :append t)))
    (is (fset2:equal? expected-result (fset2:lookup new-tag-list non-existing-field)))))

(test tag-overwrite
  (let* ((existing-field 'existing-field)
         (new-value "New Value")
         (new-tag-list (goldentag:tag +default-tag-list+ existing-field new-value :overwrite t)))
    (is (fset2:equal? (fset2:lookup new-tag-list existing-field) new-value))))

(test tag-overwrite-non-existant
  (let* ((non-existing-field 'existing-field)
         (new-value "New Value")
         (new-tag-list (goldentag:tag +default-tag-list+ non-existing-field new-value :overwrite t)))
    (is (fset2:equal? (fset2:lookup new-tag-list non-existing-field) new-value))))

(test tag-append-overwrite
  (let* ((existing-field 'author)
         (new-value "Hunter")
         (new-tag-list (goldentag:tag +default-tag-list+ existing-field new-value :append t :overwrite t)))
    (is (fset2:equal? (fset2:lookup new-tag-list existing-field) new-value))))

(test tag-append-overwrite-non-existant
  (let* ((non-existing-field 'non-existing-field)
         (new-value "Hunter")
         (new-tag-list (goldentag:tag +default-tag-list+ non-existing-field new-value :append t :overwrite t)))
    (is (fset2:equal? (fset2:lookup new-tag-list non-existing-field) new-value))))

(test untag
  (let* ((existing-field 'author)
         (new-tag-list (goldentag:untag +default-tag-list+ existing-field)))
    (is (null (fset2:lookup new-tag-list existing-field)))))

(test untag-non-existent
  (let* ((non-existing-field 'non-existing-field)
         (new-tag-list (goldentag:untag +default-tag-list+ non-existing-field)))
    (is (null (fset2:lookup new-tag-list non-existing-field)))))

(test untag-partial
  (let* ((existing-field 'author)
         (target "John")
         (new-tag-list (goldentag:untag +default-tag-list+ existing-field target)))
    (is (fset2:equal? (fset2:lookup new-tag-list existing-field)
                      (remove target (fset2:lookup +default-tag-list+ existing-field) :test #'fset2:equal?)))))

(test untag-partial-non-existent
  (let* ((non-existing-field 'non-existing-field)
         (target "John")
         (new-tag-list (goldentag:untag +default-tag-list+ non-existing-field target)))
    (is (fset2:equal? nil (fset2:lookup new-tag-list non-existing-field)))))

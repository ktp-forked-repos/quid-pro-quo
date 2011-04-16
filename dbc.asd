(defpackage dbc-system
  (:use #:cl #:asdf))

(in-package #:dbc-system)

(defsystem dbc
  :author "Matthias Hölzl <tc@gauss.muc.de>"
  :maintainer "Greg Pfeil <greg@technomadic.org>"
  :license "Public Domain"
  :depends-on (closer-mop)
  :pathname "src/"
  :components ((:file "package")
               (:file "conditions" :depends-on ("package"))
               (:file "method-combination" :depends-on ("package"))
               (:file "metaclass" :depends-on ("package")))
  :in-order-to ((test-op (load-op dbc-tests)))
  :perform (test-op :after (op c)
                    (funcall (intern "RUN!" :dbc-test)
                             (intern "TESTS" :dbc-test))))

(defmethod operation-done-p
    ((op test-op) (c (eql (find-system :dbc))))
  (values nil))

(defsystem dbc-tests
  :author "Matthias Hölzl <tc@gauss.muc.de>"
  :maintainer "Greg Pfeil <greg@technomadic.org>"
  :depends-on (dbc fiveam)
  :components ((:file "dbc-test")))

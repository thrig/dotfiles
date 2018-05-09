;;; so one can say things like (frequency nil '(e e e c)) or
;;; (frequency #'length '((a) (b b) (c c c) (d d d)) :test #'equal)
(defun frequency (fn list &key (test #'eql))
  (let ((table (make-hash-table :test test)) (key nil) (value nil) (output nil))
    (dolist (item list)
      (setf key (if (null fn) item (funcall fn item)))
      (setf value (gethash key table))
      (setf (gethash key table) (1+ (if (numberp value) value 0))))
    (maphash #'(lambda (k v) (push (list v k) output)) table)
    (sort output #'< :key #'car)))

;;; reminder: probably want
;;;   (make-hash-table :test 'equal)
;;; as the default test is surprising coming from Perl
;;; PORTABILITY style warning reduction for SBCL
(defun hash-empty (table)
  #+SBCL (declare (sb-ext:muffle-conditions style-warning))
  (maphash #'(lambda (k unused) (remhash k table)) table))

(defun hash-show (table)
  (maphash #'(lambda (k v) (format t "~a => ~a~%" k v)) table))

(defmacro sethash (hash key &optional (value nil))
  `(setf (gethash ,key ,hash) ,value))

;;; and this form needs a '(key value key2 value2 ...) list.
(defun sethash-fromlist (hash list)
  ; without this guard value of trailing key would be nil, and there
  ; would be no error
  (if (oddp (list-length list)) (error "odd number of elements in list"))
  (loop while list do
        (sethash hash (pop list) (pop list))))


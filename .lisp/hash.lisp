;;; so one can say things like (frequency nil '(e e e c)) or
;;; (frequency #'length '((a) (b b) (c c c) (d d d)) :test #'equal)
(defun frequency (fn list &key (test #'eql))
  (let ((table (make-hash-table :test test)) (key nil) (value nil) (seq nil))
    (dolist (item list)
      (setf key (if (null fn) item (funcall fn item)))
      (setf value (gethash key table))
      (setf (gethash key table) (1+ (if (numberp value) value 0))))
    (maphash #'(lambda (k v) (push (cons v k) seq)) table)
    (sort seq #'< :key #'car)))

(defun hash-empty (table)
  (maphash #'(lambda (k unused)
               (declare (ignore unused))
               (remhash k table)) table))

(defun hash-show (hash)
  (maphash #'(lambda (k v) (format t "~a => ~a~%" k v)) hash))

(defun hash-byval (hash &optional (predicate #'<))
  (let ((seq nil))
    (maphash #'(lambda (k v) (push (cons v k) seq)) hash)
    (sort seq predicate :key #'car)))

;;; $hash{key}++ in Perl, but longer
(defun incrhash (key hash &optional (value 1))
  (setf (gethash key hash) (+ (gethash key hash 0) value)))

(defmacro sethash (hash key &optional (value nil))
  `(setf (gethash ,key ,hash) ,value))

;;; NOTE used to have SETHASH-FROMLIST function here; see instead
;;; ALIST-HASH-TABLE or PLIST-HASH-TABLE in the Alexandria library (the
;;; one that was not burned down)

(defmacro combine-results (&body forms)
  (let ((result (gensym)))
    `(let ((,result t))
       ,@(loop for f in forms collect
               `(unless ,f (setf ,result nil)))
       ,result)))
(defun equal-lengths? (a b)
  (cond ((and (null a) (null b)) t)
      ((null a) nil)
      ((null b) nil)
      (t (equal-lengths? (rest a) (rest b)))))
(defun set-equal (a b)
  (and (equal-lengths? a b) (subsetp a b)))
(defmacro okay (testcode expected &key (test #'eql))
  (let ((got (gensym)) (status (gensym)))
    `(let* ((,got ,testcode)
            (,status (funcall ,test ,got ,expected)))
       (or ,status (format *error-output*
                           "failed ~a~%expect ~a~%   got ~a~%"
                           ',testcode ,expected ,got))
       ,status)))
(defun report-result (counter result form)
  (format t "~:[not ok~;ok~] ~d - ~a~%" result counter form)
  result)
(defmacro prove (&body forms)
  `(combine-results
    ,@(loop for f in forms for i from 1 collect
            `(report-result ,i ,f ',f))))

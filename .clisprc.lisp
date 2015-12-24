;;; nixes return value (though there's still a trailing blank line in
;;; `clisp -q -q -x ...` output).
(defmacro no-return (&body body)
  `(progn ,@body (values)))

;;; repeat N times doing something(s), e.g.
;;;   (repeat 4 (print "hi"))
;;;   (repeat 4 (print "hi") (print "there"))
(defmacro repeat (count &body body)
  ;; Prevent (repeat 4 (setf repnum 42)) or such from screwing up the loop
  ;; http://www.gigamonkeys.com/book/macros-defining-your-own.html
  (let ((repnum (gensym)))
  `(progn
     (if (or (not (integerp ,count)) (< ,count 1))
       (error "repeat count must be positive integer"))
     (do ((,repnum ,count (1- ,repnum)))
       ((< ,repnum 1) (return))
       (progn ,@body)))))

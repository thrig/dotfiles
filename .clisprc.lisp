;;; default is otherwise to use the same seed on each invocation :/
;;; TODO what algo is clisp using?
(setq *random-state* (make-random-state t))

;;; integer modulus more or less how Perl does it
(defmacro % (a b)
  `(mod (truncate ,a) (truncate ,b)))

(defmacro append-file (file)
  `(open ,file
         :direction :output
         :if-exists :append
         :if-does-not-exist :create))

;;; Captures output to the given stream, sending it instead to the given
;;; destination (a stream, otherwise assumed a filename that will be
;;; opened and appended to) and runs the remainder of the arguments
;;; within that capture. For example, to send the output of a (format)
;;; call to "somefile", via the (capture-stdout) wrapper macro:
;;;   (capture-stdout "somefile" (format t ...))
(defmacro capture (stream where &body body)
  (let ((out (gensym)))
    `(progn
       (if (streamp ,where)
         (setf ,out ,where)
         (setf ,out (append-file ,where)))
       (when ,out
         (let ((,stream ,out)) ,@body)
         (if (not (streamp ,where))
           (close ,out))))))

(defmacro capture-stdout (where &body body)
  `(capture *standard-output* ,where ,@body))

;;; lazy(?) way to peek at contents of a given file
(defmacro cat (file)
  (let ((in (gensym)))
  `(progn
     (setf ,in (open ,file :if-does-not-exist nil))
     (when ,in
       (loop for line = (read-line ,in nil)
           while line do (format t "~a~%" line))
       (close ,in)))))

;;; Copies text into clipboard (assuming Mac OS X or that a PATH-available
;;; `pbcopy` command exists (that calls `xsel` or `xclip` or whatever) with
;;; the necessary arguments to set the clipboard from the contents of stdin.
;;;   (clippy "blah")
;;;   (clippy (format nil "~d" (truncate pi)))
(defmacro clippy (this)
  (let ((out (gensym)))
    `(progn
       ; TODO needs better error checking
       (setf ,out (run-program "pbcopy" :input :stream :output nil))
       (when ,out
         (write-string ,this ,out)
         (close ,out)))))

;;; Returns stream (check if nil, though) to write to
(defmacro clobber-file (file)
  `(open ,file :direction :output :if-exists :supersede))

;;; nixes return value (though there's still a trailing blank line in
;;; `clisp -q -q -x ...` output).
(defmacro no-return (&body body)
  `(progn ,@body (values)))

;;; from Practical Common Lisp (clisp has something named the same, only
;;; with a different interface - (with-gensyms ("PREFIX-" var1 var2) ...))
(defmacro pcl-with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

;;; Like warnx, below, only for stdout
(defmacro putf (format &rest args)
  `(progn
     (format *standard-output* ,format ,@args)
     (fresh-line *standard-output*)))

;;; Unix shell habit
(defmacro pwd () `(cd))

(defmacro random-list-item (alist)
  `(progn
     (or (listp ,alist)
       (error "random-list-item needs a list to act on"))
     (nth (random (list-length ,alist)) ,alist)))

;;; repeat N times doing something(s), e.g.
;;;   (repeat 4 (print "hi"))
;;;   (repeat 4 (print "hi") (print "there"))
(defmacro repeat (count &body body)
  (let ((repnum (gensym)))
    `(progn
       (if (or (not (integerp ,count)) (< ,count 1))
         (error "repeat count must be positive integer"))
       (do ((,repnum ,count (1- ,repnum)))
         ((< ,repnum 1) (return))
         (progn ,@body)))))

;;; for music related needs. also note the (/= a b) function to check
;;; whether the given values differ or not
(defmacro sign-of (number)
  `(if (minusp ,number) -1 1))

;;; Lisp already has (warn) but I want something similar that emits to
;;; stderr but without the WARNING prefix of (warn). So, copy a C
;;; system call.
(defmacro warnx (format &rest args)
  `(progn
     (format *error-output* ,format ,@args)
     (fresh-line *error-output*)))

;;; copying Perl 'while' loop, roughly
(defmacro while (expr &body body)
  `(do () ((not ,expr)) (progn ,@body)))

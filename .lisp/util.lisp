;;; integer modulus more or less how Perl does it
(defmacro % (a b)
  `(mod (truncate ,a) (truncate ,b)))

;;; also copied from perl as can't remember expt (... but SBCL is very
;;; unhappy about this definition, and CLISP also complains, so leave it
;;; disabled here for reference)
;#+SBCL (sb-ext:unlock-package 'COMMON-LISP)
;(defmacro ** (a b)
;  `(expt ,a ,b))

;;; PORTABILITY just the command line arguments, if any
(defun cli-args ()
  #+CLISP ext:*args*
  #+SBCL (cdr *posix-argv*)    ; nix the program name
; not sure what these give so instead error out if encountered
; #+LISPWORKS system:*line-arguments-list*
; #+CMU extensions:*command-line-words*
  #-(or CLISP SBCL) (error "cli-args unimplemented"))
; tested with:
;   clisp .clisprc.lisp test test 1 2 3
;   sbcl --script .clisprc.lisp test test 1 2 3
;(print (cli-args)) (fresh-line)

(defun coinflip () (plusp (random 2)))

(defun date ()
  (multiple-value-bind (ss mm hh day mon year) (get-decoded-time)
    (format nil "~D-~2,'0D-~2,'0D ~2,'0D:~2,'0D:~2,'0D"
            year mon day hh mm ss)))

;;; nixes return value (though there's still a trailing blank line in
;;; `clisp -q -q -x ...` output).
(defmacro no-return (&body body)
  `(progn ,@body (values)))

;;; from Practical Common Lisp (clisp has something named the same, only
;;; with a different interface - (with-gensyms ("PREFIX-" var1 var2) ...))
(defmacro pcl-with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro random-list-item (alist)
  `(progn
     (or (listp ,alist)
       (error "random-list-item needs a list to act on"))
     (if (= 0 (list-length ,alist))
       nil
       (nth (random (list-length ,alist)) ,alist))))

;;; ported from my .tclshrc, allows stuff like
;;;   (reduce #'+ (range 2 5))
(defun range (min max &optional (step 1))
  (if (zerop step) (error "step must not be zero"))
  (if (and (< max min) (plusp step)) (setf step (* step -1)))
  (do ((list nil) (op (if (< min max) #'> #'<)))
    ((funcall op min max) (nreverse list))
    (push min list)
    (setf min (+ min step))))

;;; range + reducing lambda so can say
;;;   (rangel 2 5 #'+)
;;; to avoid the generation-of-the-complete-list thing under
;;;   (reduce ... (range ...))
(defmacro rangel (min max step &optional call)
  (let
    ((fn (gensym)) (incr (gensym)) (op (gensym)) (ret (gensym)) (val (gensym)))
    `(progn
       (if (null ,call)
         (progn
           (setf ,fn ,step)
           (setf ,incr 1))
         (progn
           (if (zerop ,step) (error "step must not be zero"))
           (setf ,fn ,call)
           (setf ,incr ,step)))
       (if (and (< ,max ,min) (plusp ,incr)) (setf ,incr (* ,incr -1)))
       (setf ,op (if (< ,min ,max) #'> #'<))
       (setf ,ret ,min)
       (do ((,val (+ ,min ,incr) (+ ,val ,incr))) ((funcall ,op ,val ,max))
         (setf ,ret (funcall ,fn ,ret ,val)))
       ,ret)))

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
         ,@body))))

;;; for music related needs. also note the (/= a b) function to check
;;; whether the given values differ or not
(defun sign-of (number)
  (if (minusp number) -1 1))

;;; mostly so I can build a list up from either end; if building a list
;;; only from one end, (push) and then (nreverse) if needed would be
;;; more idiomatic (and efficient).
(defmacro unshift (item place)
  `(progn
     (if (consp ,place)
       (rplacd (last ,place) (cons ,item nil))
       (setf ,place (cons ,item nil)))
     ,place))

;;; as (last vector) barfs with not-a-list
(defmacro vector-last (v) `(elt ,v (1- (length ,v))))
(defmacro vector-index (v) `(1- (length ,v)))

;;; Lisp already has (warn) but I want something similar that emits to
;;; stderr but without the WARNING prefix of (warn). So, copy a C system
;;; call. (reminder: ~& is like (fresh-line) within a format but then
;;; the user would have to remember to use it in their format...)
(defun warnx (format &rest args)
  (format *error-output* format args)
  (fresh-line *error-output*)
  (values))

;;; copying Perl 'while' loop, roughly
(defmacro while (expr &body body)
  `(tagbody check (if ,expr (progn ,@body (go check)))))

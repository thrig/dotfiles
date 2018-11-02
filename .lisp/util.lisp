;;; integer modulus more or less how Perl does it
(defun % (a b)
  (mod (truncate a) (truncate b)))

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

;;; nixes return value (though there's still a trailing blank line in
;;; `clisp -q -q -x ...` output).
(defmacro no-return (&body body)
  `(progn ,@body (values)))

;;; from Practical Common Lisp (clisp has something named the same, only
;;; with a different interface - (with-gensyms ("PREFIX-" var1 var2) ...))
(defmacro pcl-with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defun random-list-item (alist &optional alen)
  (or (listp alist)
      (error "need a list to act on"))
  (let ((len (if (integerp alen) alen (list-length alist))))
    (if (= 0 len) nil
      (nth (random len) alist))))

;;; ported from my .tclshrc, allows stuff like
;;;   (reduce #'+ (range 2 5))
(defun range (min max &optional (step 1))
  (if (zerop step) (error "step must not be zero"))
  (if (and (< max min) (plusp step)) (setf step (* step -1)))
  (do ((list nil) (op (if (< min max) #'> #'<)))
    ((funcall op min max) (nreverse list))
    (push min list)
    (setf min (+ min step))))

;;;   (rrange #'+ 2 5)
;;; to avoid the generation-of-the-complete-list thing under
;;;   (reduce ... (range ...))
(defun rrange (fn min max &optional (step 1))
  (if (zerop step) (error "step must not be zero"))
  (if (and (< max min) (plusp step)) (setf step (* step -1)))
  (do* ((op (if (< min max) #'> #'<))
        (ret min (funcall fn ret val))
        (val (+ min step) (+ val step)))
    ((funcall op val max) ret)))

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

; from "On Lisp" chapter 7
(defmacro showm (expr)
  `(pprint (macroexpand-1 ',expr)))

;;; for music related needs. also note the (/= a b) function to check
;;; whether the given values differ or not (or SIGNUM from Common Lisp)
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
  `(block while (tagbody check (if ,expr (progn ,@body (go check))))))

;;; again copying Perl only extended to "undefine" multiple arguments
;;; (similar to "zip" with a list of nils as the alternate array, as
;;; seen in List::UtilsBy or the ZSH ${name:^arrayname} form?)
(defmacro undef (&rest args)
  `(setq ,@(mapcan #'(lambda (a) (list a nil)) args)))

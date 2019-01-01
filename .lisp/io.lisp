(defmacro capture-append (file &body body)
  `(with-open-file
     (*standard-output* ,file
                        :direction :output
                        :if-exists :append
                        :if-does-not-exist :create)
     ,@body))

(defmacro capture-clobber (file &body body)
  `(with-open-file
     (*standard-output* ,file
                        :direction :output
                        :if-exists :supersede)
     ,@body))

;;; lazy(?) way to peek at contents of a given file
(defun cat (file)
  (with-open-file (in file)
    (loop for line = (read-line in nil) while line do
          (write-string line)
          (fresh-line))
    (values)))

;;; Copies text into clipboard
;;;   (clippy "blah")
;;;   (clippy (format nil "~d" (truncate pi)))
;;;
;;; Assuming Mac OS X or that a `pbcopy` command exists that Does The
;;; Right Thing, e.g. perhaps something like
;;;
;;;   #!/bin/sh
;;;   exec xclip -in
;;;
;;; or instead with xsel, or whatever.
(defmacro clippy (this)
  (let ((out (gensym)))
    `(with-open-stream (,out (stream-to-program "pbcopy"))
       (unwind-protect (write-string ,this ,out)
         (close ,out)))))

; read from STDIN or arguments as files similar to how readline in Perl
; functions. (number t) resets (or mnemonic "t"runcates) the line number
; counter between files, otherwise not (similar to $. variable in Perl)
; needs CLI-ARGS (see util.lisp)
;(with-input-lines (line (number t) stream file)
;(with-input-lines (line (number) stream file)
;  (format t "~a ~a:~a~%" file number line))
(defmacro with-input-lines
          ((line (number &optional (eof-reset-p nil)) stream file-name)
           &body body)
  (let ((args (gensym)) (total (gensym)))
    `(let ((,args (cli-args)) (,total 1))
       (when (null ,args) (setf ,args (list "-")))
       (dolist (,file-name ,args)
         (let ((,stream
                (if (equal "-" ,file-name)
                    *standard-input*
                    (open ,file-name :direction :input))))
           (unwind-protect
               (do ((,line (read-line ,stream nil)
                           (read-line ,stream nil))
                    (,number ,total (1+ ,number)))
                   ((not ,line) (setf ,total (if ,eof-reset-p 1 ,number)))
                ,@body)
             (when (equal "-" ,file-name) (close ,stream)))))
       (values))))

;;; more PORTABILITY
(defun stream-to-program (prog &rest args)
  #+CLISP (run-program prog
                       :arguments args
                       :input :stream
                       :output nil)
  #+SBCL (sb-ext:process-input
           (sb-ext:run-program prog args
                               :input :stream
                               :output nil
                               :search t
                               :wait nil))
  #-(or CLISP SBCL) (error "run-program unimplemented"))

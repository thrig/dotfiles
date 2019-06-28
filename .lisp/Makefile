.SUFFIXES: .lisp .fasl

.lisp.fasl:
	sbcl --noinform --non-interactive --eval '(let ((file (second *posix-argv*))) (if file (compile-file (second *posix-argv*)) (error "use BSD make")))' ${.IMPSRC}

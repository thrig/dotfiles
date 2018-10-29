.SUFFIXES: .lisp .fasl

.lisp.fasl:
	sbcl --noinform --non-interactive --eval '(compile-file (second *posix-argv*))' ${.IMPSRC}

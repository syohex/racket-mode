EMACS=$(shell if [ -z "`which emacs`" ]; then echo "Emacs executable not found"; exit 1; else echo emacs; fi)

BATCHEMACS=${EMACS} --batch --no-site-file -q -eval '(add-to-list (quote load-path) "${PWD}/")'

EL=$(ls *.el)

ELC=$(EL:.el=.elc)

BYTECOMP = $(BATCHEMACS) -eval '(progn (require (quote bytecomp)) (setq byte-compile-warnings t) (setq byte-compile-error-on-warn t))' -f batch-byte-compile

default:

clean:
	-rm *.elc

%.elc : %.el
	$(BYTECOMP) $<

compile: clean racket-font-lock.elc racket-indent.elc racket-keywords-and-builtins.elc racket-mode.elc

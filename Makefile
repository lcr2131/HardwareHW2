INTERFACE = ffinterface.sv
TOP = top.sv



.PHONY: help

help:

	@echo "The following make targets are supported in the DCL Makefile:" ;\
	echo " bench - builds the testbench";\
	echo " indent - indents verilog and c files.  lazy man's tab.  everyone should have one.";\
	echo " clean - cleans testbench and associated files":\
	ecbo " help - displays this help file";\



indent:
	emacs --batch *.sv -f verilog-batch-indent
	indent -linux *.c *.h
	rm *~

bench:

test:
	vcs -PP -sverilog +define+SV +define+VPD $() $()
clean:


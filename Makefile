#DUV = flipflop.sv
TOP = top.sv
DUV = $(filter-out $(TOP), $(wildcard *.sv))
OUTPUT = testbench.exe


.PHONY: help all indent bench test clean

all:
	make clean
	make bench
	make test

help:

	@echo "The following make targets are supported in the DCL Makefile:"
	echo " all    - cleans, builds, and tests"
	echo " bench  - builds the testbench"
	echo " test   - runs the testbench"
	echo " indent - indents verilog and c files.  lazy man's tab.  everyone should have one."
	echo " clean  - cleans testbench and associated files"
	echo " help   - displays this help file. but you already knew that."

indent:
	emacs --batch *.sv -f verilog-batch-indent
	indent -linux *.c *.h
	rm *~

bench:
	vcs -full64 -PP -sverilog +define+SV +define+VPD +lint=all,noVCDE $(TOP) $(DUV) -o $(OUTPUT)

test:
#	vcs -PP -sverilog +define+SV +define+VPD $() $()
	./$(OUTPUT)

clean:
	rm -rf *~ csrc *.exe.daidir *.exe *.log *.inf .leda_work *.key *.vpd *.vcd DVEfiles

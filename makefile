
all: commonlib utillib ambalib build elaborate run

commonlib: 
	ghdl -a --work=commonlib types_common.vhd

utillib:
	ghdl -a --work=utillib types_util.vhd

ambalib:
	ghdl -a --work=ambalib types_amba4.vhd

build:
	ghdl -a test.vhd axictrl.vhd master.vhd slave.vhd

elaborate:
	ghdl -e test

run:
	ghdl -r test

clean:
	rm -f *.cf


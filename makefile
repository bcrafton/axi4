
all: commonlib utillib ambalib axictrl elaborate run

commonlib: 
	ghdl -a --work=commonlib types_common.vhd

utillib:
	ghdl -a --work=utillib types_util.vhd

ambalib:
	ghdl -a --work=ambalib types_amba4.vhd

axictrl:
	ghdl -a axictrl.vhd

elaborate:
	ghdl -e axictrl

run:
	ghdl -r axictrl

clean:
	rm -f *.cf


all: questa_lib comp elab sim

questa_lib: questa_lib
	mkdir questa_lib

comp: 
	compile.sh $(XILINX_VIP_INCLUDE_PATH)

elab: 
	elaborate.sh

sim:
	simulate.sh

clean:
	rm -rf questa_lib/msim/ questa_lib/work/ vsim.wlf
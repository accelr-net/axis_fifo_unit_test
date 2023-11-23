# Makefile for Vivado Simulation

# Variables
VIVADO_BIN_DIR := /tools/Xilinx/Vivado/2022.2/bin
SIM_DIR := fifo_ip_project.sim/sim_1/behav/xsim
TOP_MODULE := tb_top
TB_TCL_FILE := tb_top.tcl
RUN_ALL_SCRIPT := run_all.tcl

# Targets
all: launch_simulation

launch_simulation: compile elaborate simulate

compile:
	@echo "Compiling design..."
	$(VIVADO_BIN_DIR)/xvlog --incr --relax -L uvm -L axi4stream_vip_v1_1_13 -L xilinx_vip -prj $(SIM_DIR)/tb_top_vlog.prj

elaborate:
	@echo "Elaborating design..."
	$(VIVADO_BIN_DIR)/xelab --incr --debug typical --relax --mt 8 -L xil_defaultlib -L axis_infrastructure_v1_1_0 -L axi4stream_vip_v1_1_13 -L uvm -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot $(TOP_MODULE)_behav xil_defaultlib.$(TOP_MODULE) xil_defaultlib.glbl -log elaborate.log

simulate:
	@echo "Simulating design..."
	$(VIVADO_BIN_DIR)/xsim $(TOP_MODULE)_behav -key {Behavioral:sim_1:Functional:$(TOP_MODULE)} -tclbatch $(RUN_ALL_SCRIPT) -log simulate.log

clean: 
	rm -rf *.log *.pg *.log *.str *.jou *.pb xsim.dir .Xil *.wdb *.wcfg

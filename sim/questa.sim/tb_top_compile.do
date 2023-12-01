######################################################################
#
# File name : tb_top_compile.do
# Created on: Fri Dec 01 12:50:05 +0530 2023
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -64 -incr -mfcu -sv -L axi4stream_vip_v1_1_13 -L xilinx_vip -work xil_defaultlib  "+incdir+../../fifo_ip_project.ip_user_files/ipstatic/hdl" "+incdir+../../axi4s_vip_base" "+incdir+../../fifo_vip" "+incdir+/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/include" \
"../../fifo_ip_project.gen/sources_1/ip/axi4stream_vip_1_2/sim/axi4stream_vip_1_pkg.sv" \
"../../fifo_ip_project.gen/sources_1/ip/axi4stream_vip_1_2/sim/axi4stream_vip_1.sv" \
"../../fifo_ip_project.gen/sources_1/ip/axi4stream_vip_0_1/sim/axi4stream_vip_0_pkg.sv" \
"../../fifo_ip_project.gen/sources_1/ip/axi4stream_vip_0_1/sim/axi4stream_vip_0.sv" \
"../../rtl/AXI_FIFO.sv" \
"../../rtl/async_fwft_fifo_bin_ptr.sv" \
"../../axi4s_vip_base/axi4s_vip_base.sv" \
"../../fifo_vip/fifo_pkg.sv" \
"../../rtl/memory.sv" \
"../../sim/tb_top.sv" \


# compile glbl module
vlog -work xil_defaultlib "glbl.v"


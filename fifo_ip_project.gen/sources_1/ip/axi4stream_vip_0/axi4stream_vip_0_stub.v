// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Fri Nov 17 11:01:02 2023
// Host        : sachith-Inspiron-16-5620 running 64-bit Ubuntu 22.04.3 LTS
// Command     : write_verilog -force -mode synth_stub
//               /tools/Xilinx/Vivado/2022.2/bin/fifo_ip_project/fifo_ip_project.gen/sources_1/ip/axi4stream_vip_0/axi4stream_vip_0_stub.v
// Design      : axi4stream_vip_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "axi4stream_vip_v1_1_13_top,Vivado 2022.2" *)
module axi4stream_vip_0(aclk, aresetn, m_axis_tvalid, m_axis_tready, 
  m_axis_tdata, m_axis_tlast)
/* synthesis syn_black_box black_box_pad_pin="aclk,aresetn,m_axis_tvalid[0:0],m_axis_tready[0:0],m_axis_tdata[7:0],m_axis_tlast[0:0]" */;
  input aclk;
  input aresetn;
  output [0:0]m_axis_tvalid;
  input [0:0]m_axis_tready;
  output [7:0]m_axis_tdata;
  output [0:0]m_axis_tlast;
endmodule

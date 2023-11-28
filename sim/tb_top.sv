`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2023 11:04:08 AM
// Design Name: 
// Module Name: tb_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

import axi4stream_vip_pkg::*;
import axi4stream_vip_0_pkg::*;
import axi4stream_vip_1_pkg::*;
import axi4s_vip_base::*;
import fifo_pkg::*;


module tb_top(

    );

localparam              TDATA_WIDTH = 8;

localparam              CLK_PERIOD  = 10;

localparam              FIFO_WIDTH  = 10;
localparam              FIFO_DEPTH  = 8;
localparam              SYNC_DEPTH  = 2;

logic                   aclk;
logic                   aresetn;

logic                   m_axis_tvalid;
logic                   m_axis_tready;
logic [TDATA_WIDTH-1:0] m_axis_tdata;
logic                   m_axis_tlast;

logic                   s_axis_tvalid;
logic                   s_axis_tready;
logic [TDATA_WIDTH-1:0] s_axis_tdata;
logic                   s_axis_tlast;

/***************************************************************************************************
    * Verbosity level which specifies how much debug information to be printed out
    * 0         - No information will be printed out
    * 400       - All information will be printed out
    ***************************************************************************************************/
    // Master VIP agent verbosity level
    xil_axi4stream_uint                           mst_agent_verbosity = 0;
    // Slave VIP agent verbosity level
    xil_axi4stream_uint                           slv_agent_verbosity = 0;
    /***************************************************************************************************
    * Parameterized agents which customer needs to declare according to AXI4STREAM VIP configuration
    * If AXI4STREAM VIP is being configured in master mode, "component_name"_mst_t has to declared 
    * If AXI4STREAM VIP is being configured in slave mode, "component_name"_slv_t has to be declared 
    * If AXI4STREAM VIP is being configured in pass-through mode,"component_name"_passthrough_t has to be declared
    * "component_name can be easily found in vivado bd design: click on the instance, 
    * then click CONFIG under Properties window and Component_Name will be shown
    * More details please refer PG277 for more details
    ***************************************************************************************************/
    axi4stream_vip_0_mst_t           mst_agent;
    axi4stream_vip_1_slv_t           slv_agent;

    fifo_packet_sequence                fifo_sequence;
    fifo_beat_subscriber                fifo_beat_subscriber_for_mst;
    fifo_beat_subscriber                fifo_beat_subscriber_for_slv;
    fifo_packet_subscriber              fifo_subscriber_for_packet;
    // packet_subscriber #(fifo_packet)    model;
    fifo_model           fmodel;

 
axi4stream_vip_0 axi4master (
 .aclk(aclk),                    // input wire aclk
 .aresetn(aresetn),              // input wire aresetn
 .m_axis_tvalid(m_axis_tvalid),  // output wire [0 : 0] m_axis_tvalid
 .m_axis_tready(m_axis_tready),  // input wire [0 : 0] m_axis_tready
 .m_axis_tdata(m_axis_tdata),    // output wire [7 : 0] m_axis_tdata
 .m_axis_tkeep(m_axis_tkeep),    // output wire [0 : 0] m_axis_tkeep
 .m_axis_tlast(m_axis_tlast)     // output wire [0 : 0] m_axis_tlast
);

axi4stream_vip_1 axi4slave (
 .aclk(aclk),                    // input wire aclk
 .aresetn(aresetn),              // input wire aresetn
 .s_axis_tvalid(s_axis_tvalid),  // input wire [0 : 0] s_axis_tvalid
 .s_axis_tready(s_axis_tready),  // output wire [0 : 0] s_axis_tready
 .s_axis_tdata(s_axis_tdata),    // input wire [7 : 0] s_axis_tdata
 .s_axis_tkeep(s_axis_tkeep),    // input wire [0 : 0] s_axis_tkeep
 .s_axis_tlast(s_axis_tlast)     // input wire [0 : 0] s_axis_tlast
);

AXI_FIFO #(
   .FIFO_WIDTH(FIFO_WIDTH),
   .FIFO_DEPTH(FIFO_DEPTH),
   .SYNC_DEPTH(SYNC_DEPTH)
)axi_fifo_0(
   .aclk(aclk),    
   .aresetn(aresetn),
   .data_i({m_axis_tkeep,m_axis_tlast,m_axis_tdata}),
   .valid_i(m_axis_tvalid),
   .ready_i(m_axis_tready),
   .data_o({s_axis_tkeep,s_axis_tlast,s_axis_tdata}),
   .valid_o(s_axis_tvalid),
   .ready_o(s_axis_tready)
);

// axi4stream_vip_0_mst_t  axi4stream_vip_0_mst;
// initial begin : START_axi4stream_vip_0_MASTER
//   axi4stream_vip_0_mst = new("axi4stream_vip_0_mst", axi4master.inst.IF);
//   axi4stream_vip_0_mst.start_master();
// end

initial forever #(CLK_PERIOD/2) aclk <= ~aclk;

initial begin
    aclk    = 1'b0;
    aresetn = 1'b0;
    #3;
    @(posedge aclk) aresetn <= 1'b1;
end

//Main process
initial begin
  /***************************************************************************************************
  * The hierarchy path of the AXI4STREAM VIP's interface is passed to the agent when it is newed. 
  * Method to find the hierarchy path of AXI4STREAM VIP is to run simulation without agents being newed,
  * message like "Xilinx AXI4STREAM VIP Found at Path: 
  * my_ip_exdes_tb.DUT.ex_design.axi4stream_vip_mst.inst" will be printed out.
  ***************************************************************************************************/
  mst_agent = new("master vip agent", axi4master.inst.IF);
  slv_agent = new("slave vip agent", axi4slave.inst.IF); //axi4slave.inst.IF
  $timeformat (-12, 1, " ps", 1);

  /***************************************************************************************************
  * When bus is in idle, it must drive everything to 0.otherwise it will 
  * trigger false assertion failure from axi_protocol_chekcer
  ***************************************************************************************************/
  mst_agent.vif_proxy.set_dummy_drive_type(XIL_AXI4STREAM_VIF_DRIVE_NONE);
  slv_agent.vif_proxy.set_dummy_drive_type(XIL_AXI4STREAM_VIF_DRIVE_NONE);

  /***************************************************************************************************
  * Set tag for agents for easy debug,if not set here, it will be hard to tell which driver is filing 
  * if multiple agents are called in one testbench
  ***************************************************************************************************/
  mst_agent.set_agent_tag("Master VIP");
  slv_agent.set_agent_tag("Slave VIP");

  // set print out verbosity level.
  mst_agent.set_verbosity(mst_agent_verbosity);
  slv_agent.set_verbosity(slv_agent_verbosity);

  /***************************************************************************************************
  * Master,slave agents start to run 
  ***************************************************************************************************/
  mst_agent.start_master();
  slv_agent.start_slave();

  /***************************************************************************************************
  * Fork off the process
  * Master VIP create transaction
  * Slave VIP create TREADY if it is on 
  ***************************************************************************************************/
  fifo_sequence = new(mst_agent,slv_agent);
//   model         = new();
  fifo_beat_subscriber_for_mst  = new(mst_agent.monitor.item_collected_port);
  fifo_beat_subscriber_for_slv  = new(slv_agent.monitor.item_collected_port);
//   model         = new(fifo_beat_subscriber_for_slv, fifo_beat_subscriber_for_mst, fmodel);
  fmodel = new();
  fifo_subscriber_for_packet    = new(fifo_beat_subscriber_for_slv,fifo_beat_subscriber_for_mst,fmodel);
  
  fork
      begin
          fifo_sequence.do_work();
          #1000;
      end
      begin
          fifo_subscriber_for_packet.do_work();
      end
      begin
          fifo_beat_subscriber_for_mst.do_work();
          
      end
      begin
          fifo_beat_subscriber_for_slv.do_work();
      end
  join_any
    // join
  #1000000;
  disable fork;
  fifo_subscriber_for_packet.publish_results();
  #1ns;
  $finish();
end

endmodule

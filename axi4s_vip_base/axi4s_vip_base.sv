package axi4s_vip_base;
    import xil_common_vip_pkg::*;
    import axi4stream_vip_pkg::*;
    import axi4stream_vip_0_pkg::*;
    import axi4stream_vip_1_pkg::*;

    typedef logic [7:0]                                         u8;
    typedef logic [7:0]                                         u8_array[$];
    typedef xil_analysis_port #(axi4stream_monitor_transaction) axi4s_item_collected_port;
    
    `include "data_packet.svh"
    `include "packet_sequence.svh"
    `include "beat_subscriber.svh"
    `include "model.svh"
    `include "packet_subscriber.svh"
endpackage: axi4s_vip_base
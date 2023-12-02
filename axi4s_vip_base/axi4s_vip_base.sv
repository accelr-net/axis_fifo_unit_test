//------------------------------------------------------------------------------
//
// Package: axi4s_vip_base
//
// The packege gather all the other packeges as below and deefines u8, u8_array, 
// axi4s_item_collected_port type definitions to the architecture.
//------------------------------------------------------------------------------
package axi4s_vip_base;

    // Package imports: axi4stream vip packages. 
    //
    // this  includes all the axi4stream base packages.
    import xil_common_vip_pkg::*;
    import axi4stream_vip_pkg::*;
    import axi4stream_vip_0_pkg::*;
    import axi4stream_vip_1_pkg::*;

    // Type definitions: design base types. 
    //
    // u8, u8_array, axi4s_item_collected_port.
    typedef logic [7:0]                                         u8;
    typedef logic [7:0]                                         u8_array[$];
    typedef xil_analysis_port #(axi4stream_monitor_transaction) axi4s_item_collected_port;

    // SystemVerilog header files: Base design SystemVerilog header files. 
    //
    // data_packet, packet_sequence, beat_subscriber, model, packet_subscriber.
    `include "data_packet.svh"
    `include "packet_sequence.svh"
    `include "beat_subscriber.svh"
    `include "model.svh"
    `include "packet_subscriber.svh"

endpackage: axi4s_vip_base
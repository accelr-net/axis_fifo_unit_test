// ************************************************************************************************************************
//
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka
//
// ************************************************************************************************************************
//
// PROJECT      :   axi_fifo_unit_test
// PRODUCT      :   axi_fifo_unit_test
// FILE         :   fifo_pkg.sv
// AUTHOR       :   Kasun Buddhi
// DESCRIPTION  :   support file for axi_fifo_unit_test project
//
// ************************************************************************************************************************
//
// REVISIONS:
//
//  Date           Developer               Description
//  -----------    --------------------    -----------
//  13-JUN-2023    Kasun Buddhi            Creation
//  4-DEC-2023     Sachith Rathnayake      Updated
//
//*************************************************************************************************************************

//------------------------------------------------------------------------------
//
// Package: fifo_pkg
//
// The packege gather the axi4stream base packages and includes fifo_ip 
// SystemVerilog header files.
//------------------------------------------------------------------------------
package fifo_pkg;

    // Package imports: axi4stream vip packages. 
    //
    // this  includes all the axi4stream base packages.
    import xil_common_vip_pkg::*;
    import axi4s_vip_base::*;
    import axi4stream_vip_pkg::*;
    import axi4stream_vip_0_pkg::*;
    import axi4stream_vip_1_pkg::*;

    // SystemVerilog header files: Base design SystemVerilog header files from fifo_ip. 
    //
    // fifo_packet, fifo_packet_sequence, fifo_model.
    `include "fifo_packet.svh"
    `include "fifo_packet_sequence.svh"
    `include "fifo_model.svh"

    // Type definitions: design base types. 
    //
    // fifo_beat_subscriber, fifo_packet_subscriber.
    typedef beat_subscriber #(fifo_packet)      fifo_beat_subscriber;
    typedef packet_subscriber #(fifo_packet)    fifo_packet_subscriber;
endpackage: fifo_pkg
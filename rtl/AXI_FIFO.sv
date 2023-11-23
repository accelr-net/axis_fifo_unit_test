// ************************************************************************************************************************
//
// Copyright(C) 2022 ACCELR
// All rights reserved.
//
// THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
// ACCELER LOGIC (PVT) LTD, SRI LANKA.
//
// This copy of the Source Code is intended for ACCELR's internal use only and is
// intended for view by persons duly authorized by the management of ACCELR. No
// part of this file may be reproduced or distributed in any form or by any
// means without the written approval of the Management of ACCELR.
//
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka         +94 77 3166850
//
// ************************************************************************************************************************
//
// PROJECT      :   AXI_FIFO
// PRODUCT      :   AXI_FIFO
// FILE         :   AXI_FIFO.sv
// AUTHOR       :   Sachith Rathnayake
// DESCRIPTION  :   Design Practice
//
// ************************************************************************************************************************
//
// REVISIONS:
//
//  Date           Developer               Description
//  -----------    --------------------    -----------
//  08-SEP-2023    Sachith Rathnayake      Creation
//
//
//*************************************************************************************************************************
`timescale 1ns/1ps

// `include "advance_fifo.sv"

module AXI_FIFO (
    aclk,
    aresetn,
    data_i,
    valid_i,
    ready_i,
    data_o,
    valid_o,
    ready_o
);

    //---------------------------------------------------------------------------------------------------------------------
    // Global constant headers
    //---------------------------------------------------------------------------------------------------------------------
    // None
    
    //---------------------------------------------------------------------------------------------------------------------
    // parameter definitions
    //---------------------------------------------------------------------------------------------------------------------
    parameter FIFO_WIDTH    = 9;
    parameter FIFO_DEPTH    = 8;
    parameter SYNC_DEPTH    = 2;
    
    //---------------------------------------------------------------------------------------------------------------------
    // localparam definitions
    //---------------------------------------------------------------------------------------------------------------------
    // None
    
    //---------------------------------------------------------------------------------------------------------------------
    // type definitions
    //---------------------------------------------------------------------------------------------------------------------
    // None
    
    //---------------------------------------------------------------------------------------------------------------------
    // I/O signals
    //---------------------------------------------------------------------------------------------------------------------
    input   logic                   aclk;
    input   logic                   aresetn;
    input   logic [FIFO_WIDTH-1:0]  data_i;
    input   logic                   valid_i;
    output  logic                   ready_i;
    output  logic [FIFO_WIDTH-1:0]  data_o;
    output  logic                   valid_o;
    input   logic                   ready_o;
    
    //---------------------------------------------------------------------------------------------------------------------
    // Internal signals
    //---------------------------------------------------------------------------------------------------------------------
    logic full_fifo;
    logic empty_fifo;
    
    //---------------------------------------------------------------------------------------------------------------------
    // Implementation
    //---------------------------------------------------------------------------------------------------------------------
    assign ready_i = ~full_fifo;
    assign valid_o = ~empty_fifo;

    async_fwft_fifo_bin_ptr #( 
        .FIFO_DEPTH(FIFO_DEPTH),
        .FIFO_WIDTH(FIFO_WIDTH),
        .SYNC_DEPTH(SYNC_DEPTH)
    ) fifo (
        .wr_clk(aclk),
        .wr_reset_n(aresetn),
        .rd_clk(aclk),
        .rd_reset_n(aresetn),
        .wr_data_i(data_i),
        .wr_en_i(valid_i),
        .wr_full_o(full_fifo),
        .rd_en_i(ready_o),
        .rd_data_o(data_o),
        .rd_empty_o(empty_fifo)
    );   
endmodule
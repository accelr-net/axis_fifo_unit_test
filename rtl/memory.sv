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
// PROJECT      :   FIFO_BUILD
// PRODUCT      :   FIFO_BUILD
// FILE         :   mem.sv
// AUTHOR       :   Sachith Rathnayake
// DESCRIPTION  :   FIFO_BUILD
//
// ************************************************************************************************************************
//
// REVISIONS:
//
//  Date           Developer               Description
//  -----------    --------------------    -----------
//  21-SEP-2023    Sachith Rathnayake      Creation
//
//
//*************************************************************************************************************************

`timescale 1ns/1ps

module memory (
    wr_clk,
    wr_clk_en_i,
    wr_data_i,
    wr_addr_i,
    rd_data_o,
    rd_addr_i
);

    //---------------------------------------------------------------------------------------------------------------------
    // Global constant headers
    //---------------------------------------------------------------------------------------------------------------------
    // None
    
    
    //---------------------------------------------------------------------------------------------------------------------
    // parameter definitions
    //---------------------------------------------------------------------------------------------------------------------
    parameter WIDTH    = 8;
    parameter DEPTH    = 8;
    
    
    //---------------------------------------------------------------------------------------------------------------------
    // localparam definitions
    //---------------------------------------------------------------------------------------------------------------------
    localparam ADDR_WIDTH       = $clog2(DEPTH);
    localparam ACTUAL_DEPTH    = {1'b1,{ADDR_WIDTH{1'b0}}};
    
    //---------------------------------------------------------------------------------------------------------------------
    // type definitions
    //---------------------------------------------------------------------------------------------------------------------
    // None
    
    
    //---------------------------------------------------------------------------------------------------------------------
    // I/O signals
    //---------------------------------------------------------------------------------------------------------------------
    input   logic                   wr_clk;
    input   logic                   wr_clk_en_i;
    input   logic [     WIDTH-1:0]  wr_data_i;
    input   logic [ADDR_WIDTH-1:0]  wr_addr_i;
    output  logic [     WIDTH-1:0]  rd_data_o;
    input   logic [ADDR_WIDTH-1:0]  rd_addr_i;
    
    
    //---------------------------------------------------------------------------------------------------------------------
    // Internal signals
    //---------------------------------------------------------------------------------------------------------------------
    logic [WIDTH-1:0] mem [0:ACTUAL_DEPTH-1];
    
    
    //---------------------------------------------------------------------------------------------------------------------
    // Implementation
    //---------------------------------------------------------------------------------------------------------------------
    assign rd_data_o = mem[rd_addr_i];

    always_ff @(posedge wr_clk) begin :wr_block
        mem[wr_addr_i]  <= (wr_clk_en_i)? wr_data_i : mem[wr_addr_i];
    end :wr_block
       
endmodule
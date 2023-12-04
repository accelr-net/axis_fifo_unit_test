// ************************************************************************************************************************
// 
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka
//
// ************************************************************************************************************************
//
// PROJECT      :   async_fwft_fifo build
// PRODUCT      :   async_fwft_fifo build
// FILE         :   async_fwft_fifo.sv
// AUTHOR       :   Sachith
// DESCRIPTION  :   testing and developing advance fifo design
//
// ************************************************************************************************************************
//
// REVISIONS:
//
//  Date           Developer               Description
//  -----------    --------------------    -----------
//  13-SEP-2023    Sachith Rathnayake      Creation
//
//
//*************************************************************************************************************************
`timescale 1ns/1ps

module async_fwft_fifo_bin_ptr (
    wr_clk,
    wr_reset_n,
    rd_clk,
    rd_reset_n,
    wr_data_i,
    wr_en_i,
    wr_full_o,
    rd_en_i,
    rd_data_o,
    rd_empty_o
);

    //---------------------------------------------------------------------------------------------------------------------
    // Global constant headers
    //---------------------------------------------------------------------------------------------------------------------
    // None

    //--------------------------------------------------------------------------------------------------------------------
    // parameter definitions
    //---------------------------------------------------------------------------------------------------------------------
    parameter FIFO_WIDTH    = 8;
    parameter FIFO_DEPTH    = 8;
    parameter SYNC_DEPTH    = 2;

    //---------------------------------------------------------------------------------------------------------------------
    // localparam definitions
    //---------------------------------------------------------------------------------------------------------------------
    localparam PTR_WIDTH            = $clog2(FIFO_DEPTH);
    localparam ACTUAL_FIFO_DEPTH    = {1'b1,{PTR_WIDTH{1'b0}}};
    localparam POINTER_INIT_VALUE   = {PTR_WIDTH{1'b0}};

    //---------------------------------------------------------------------------------------------------------------------
    // type definitions
    //---------------------------------------------------------------------------------------------------------------------
    // None
    
    //---------------------------------------------------------------------------------------------------------------------
    // I/O signals
    //---------------------------------------------------------------------------------------------------------------------
    input   logic                   wr_clk;
    input   logic                   wr_reset_n;

    input   logic                   rd_clk;
    input   logic                   rd_reset_n;

    input   logic [FIFO_WIDTH-1:0]  wr_data_i;
    input   logic                   wr_en_i;
    output  logic                   wr_full_o;

    input   logic                   rd_en_i;
    output  logic [FIFO_WIDTH-1:0]  rd_data_o;
    output  logic                   rd_empty_o;
    
    //---------------------------------------------------------------------------------------------------------------------
    // Internal signals
    //---------------------------------------------------------------------------------------------------------------------
    logic [PTR_WIDTH-1:0] wr_ptr;
    logic [PTR_WIDTH-1:0] next_wr_ptr;
    logic [PTR_WIDTH-1:0] gray_wr_ptr;
    logic [PTR_WIDTH-1:0] sync_r2w_gray_rd_ptr;
    logic [PTR_WIDTH-1:0] sync_r2w_rd_ptr;
    logic [PTR_WIDTH-1:0] sync_wire_r2w [0:SYNC_DEPTH];

    logic [PTR_WIDTH-1:0] rd_ptr;
    logic [PTR_WIDTH-1:0] next_rd_ptr;
    logic [PTR_WIDTH-1:0] gray_rd_ptr;
    logic [PTR_WIDTH-1:0] sync_w2r_gray_wr_ptr;
    logic [PTR_WIDTH-1:0] sync_w2r_wr_ptr;
    logic [PTR_WIDTH-1:0] sync_wire_w2r [0:SYNC_DEPTH];

    //---------------------------------------------------------------------------------------------------------------------
    // Assertions 
    //---------------------------------------------------------------------------------------------------------------------
    always_comb begin
        reset_check: assert ((wr_reset_n === rd_reset_n))
            else $fatal(1, "**** reset check failed! wr_reset_n != rd_reset_n ****"); 
    end
    
    //---------------------------------------------------------------------------------------------------------------------
    // Implementation
    //---------------------------------------------------------------------------------------------------------------------
    always_ff @(posedge wr_clk or negedge wr_reset_n) begin :wr_ptr_logic
        if (!wr_reset_n) begin
            wr_ptr <= POINTER_INIT_VALUE;
        end
        else begin
            wr_ptr <= (!wr_full_o && wr_en_i)? next_wr_ptr : wr_ptr; 
        end
    end :wr_ptr_logic

    always_ff @(posedge rd_clk or negedge rd_reset_n) begin :rd_ptr_logic
        if (!rd_reset_n) begin
            rd_ptr <= POINTER_INIT_VALUE;
        end
        else begin
            rd_ptr <= (!rd_empty_o && rd_en_i)? next_rd_ptr : rd_ptr;
        end
    end :rd_ptr_logic
    
    always_comb begin :next_ptr_gtr_wr
        next_wr_ptr = wr_ptr + 1'b1;
    end :next_ptr_gtr_wr

    always_comb begin :next_ptr_gtr_rd
        next_rd_ptr = rd_ptr + 1'b1;
    end :next_ptr_gtr_rd

    always_comb begin :sync_empty_full_logic
        rd_empty_o  = (rd_ptr == sync_w2r_wr_ptr);
        wr_full_o   = (next_wr_ptr == sync_r2w_rd_ptr);
    end :sync_empty_full_logic


    
    always_comb begin :bin2gray_converter_logic_r2w
        gray_rd_ptr = (rd_ptr>>1)^(rd_ptr);
    end :bin2gray_converter_logic_r2w
    genvar i;
    generate
        for(i=0;i<SYNC_DEPTH;i++) begin
            always_ff @(posedge wr_clk or negedge wr_reset_n) begin :synchronizer_seq_logic_r2w
                sync_wire_r2w[i+1] <= (!wr_reset_n)? POINTER_INIT_VALUE : sync_wire_r2w[i];
            end :synchronizer_seq_logic_r2w
        end
    endgenerate
    always_comb begin :synchronizer_logic_r2w
        sync_wire_r2w[0] = gray_rd_ptr;
        sync_r2w_gray_rd_ptr  = sync_wire_r2w[SYNC_DEPTH];
    end :synchronizer_logic_r2w
    //gray2bin_converter_logic_r2w
    genvar k;
    generate
        for(k=0;k<PTR_WIDTH;k++) begin
            assign sync_r2w_rd_ptr[k] = ^(sync_r2w_gray_rd_ptr >> k);
        end
    endgenerate



    always_comb begin :bin2gray_converter_logic_w2r
        gray_wr_ptr = (wr_ptr>>1)^(wr_ptr);
    end :bin2gray_converter_logic_w2r
    genvar j;
    generate
        for(j=0;j<SYNC_DEPTH;j++) begin
            always_ff @(posedge rd_clk or negedge rd_reset_n) begin :synchronizer_seq_logic_w2r
                sync_wire_w2r[j+1] <= (!rd_reset_n)? POINTER_INIT_VALUE : sync_wire_w2r[j];
            end :synchronizer_seq_logic_w2r
        end
    endgenerate
    always_comb begin :synchronizer_logic_w2r
        sync_wire_w2r[0] = gray_wr_ptr;
        sync_w2r_gray_wr_ptr  = sync_wire_w2r[SYNC_DEPTH];
    end :synchronizer_logic_w2r
    //gray2bin_converter_logic_w2r
    genvar l;
    generate
        for(l=0;l<PTR_WIDTH;l++) begin
            assign sync_w2r_wr_ptr[l] = ^(sync_w2r_gray_wr_ptr >> l);
        end
    endgenerate


    
    memory #( 
        .WIDTH(FIFO_WIDTH),
        .DEPTH(ACTUAL_FIFO_DEPTH)
    ) memory_int (
        .wr_clk(wr_clk),
        .wr_clk_en_i(wr_en_i),
        .wr_data_i(wr_data_i),
        .wr_addr_i(wr_ptr),
        .rd_data_o(rd_data_o),
        .rd_addr_i(rd_ptr)
    );
    
endmodule
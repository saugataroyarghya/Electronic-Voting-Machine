//-----------------------------------------------------------------------------
//
// Title       : memory_block_4bit
// Design      : evm
// Author      : Saugata
// Company     : KUET
//
//-----------------------------------------------------------------------------
//
// File        : C:/Users/Saugata/Desktop/DSD Project/evm/evm/src/memory_block_4bit.v
// Generated   : Wed Jan  8 23:19:12 2025
// From        : Interface description file
// By          : ItfToHdl ver. 1.0
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------



//{{ Section below this comment is automatically maintained
//    and may be overwritten
//{module {memory_block_4bit}}

`timescale 1ps / 1ps

module memory_block_4bit (
    input [3:0] data_in,     // Input data
    input write_enable,      // Write enable signal
    input clk,               // Clock signal
    output [3:0] data_out    // Output data
);
    // Intermediate wires for D flip-flop outputs
    wire q0, q1, q2, q3;
    wire qBar0, qBar1, qBar2, qBar3;

    // Logic for write enable gating (hardware-based)
    wire din0 = (write_enable & data_in[0]) | (~write_enable & q0);
    wire din1 = (write_enable & data_in[1]) | (~write_enable & q1);
    wire din2 = (write_enable & data_in[2]) | (~write_enable & q2);
    wire din3 = (write_enable & data_in[3]) | (~write_enable & q3);

    // Instantiate D flip-flops for each bit
    dflipflop dff0 (
        .din(din0),
        .clk(clk),
        .q(q0),
        .qBar(qBar0)
    );

    dflipflop dff1 (
        .din(din1),
        .clk(clk),
        .q(q1),
        .qBar(qBar1)
    );

    dflipflop dff2 (
        .din(din2),
        .clk(clk),
        .q(q2),
        .qBar(qBar2)
    );

    dflipflop dff3 (
        .din(din3),
        .clk(clk),
        .q(q3),
        .qBar(qBar3)
    );

    // Combine D flip-flop outputs into data_out
    assign data_out = {q3, q2, q1, q0};

endmodule


		  

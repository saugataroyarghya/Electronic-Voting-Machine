//-----------------------------------------------------------------------------
//
// Title       : adder
// Design      : evm
// Author      : Saugata
// Company     : KUET
//
//-----------------------------------------------------------------------------
//
// File        : C:/Users/Saugata/Desktop/DSD Project/evm/evm/src/adder.v
// Generated   : Sat Jan 11 10:54:33 2025
// From        : Interface description file
// By          : ItfToHdl ver. 1.0
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------


`timescale 1ps / 1ps

module adder_4bit (
    input [3:0] a,         // First 4-bit input
    input [3:0] b,         // Second 4-bit input
    output [3:0] sum,      // 4-bit sum output
    output carry_out       // Carry-out from the most significant bit
);
    // Internal wires for carry between full adders
    wire c1, c2, c3;

    // Instantiate full adders for each bit
    full_adder fa0 (
        .a(a[0]),
        .b(b[0]),
        .cin(1'b0),  // No carry-in for the least significant bit
        .sum(sum[0]),
        .cout(c1)
    );

    full_adder fa1 (
        .a(a[1]),
        .b(b[1]),
        .cin(c1),    // Carry-in from the previous bit
        .sum(sum[1]),
        .cout(c2)
    );

    full_adder fa2 (
        .a(a[2]),
        .b(b[2]),
        .cin(c2),    // Carry-in from the previous bit
        .sum(sum[2]),
        .cout(c3)
    );

    full_adder fa3 (
        .a(a[3]),
        .b(b[3]),
        .cin(c3),    // Carry-in from the previous bit
        .sum(sum[3]),
        .cout(carry_out) // Carry-out from the most significant bit
    );

endmodule

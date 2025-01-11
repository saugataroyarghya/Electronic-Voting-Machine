//-----------------------------------------------------------------------------
//
// Title       : comparator
// Design      : evm
// Author      : Saugata
// Company     : KUET
//
//-----------------------------------------------------------------------------
//
// File        : C:/Users/Saugata/Desktop/DSD Project/evm/evm/src/comparator.v
// Generated   : Wed Jan  8 22:30:49 2025
// From        : Interface description file
// By          : ItfToHdl ver. 1.0
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`timescale 1ps / 1ps

//{{ Section below this comment is automatically maintained
//    and may be overwritten
//{module {comparator}}

module comparator_4bit (
    input [3:0] A,       // 4-bit input A
    input [3:0] B,       // 4-bit input B
    output A_equal_B,    // Output for A = B
    output A_greater_B,  // Output for A > B
    output A_less_B      // Output for A < B
);
    // Intermediate wires for A=B condition
    wire x3, x2, x1, x0;

    // Generate A=B intermediate conditions
    assign x3 = ~(A[3] ^ B[3]); // A3 == B3
    assign x2 = ~(A[2] ^ B[2]); // A2 == B2
    assign x1 = ~(A[1] ^ B[1]); // A1 == B1
    assign x0 = ~(A[0] ^ B[0]); // A0 == B0

    // A=B condition
    assign A_equal_B = x3 & x2 & x1 & x0;

    // A>B condition
    assign A_greater_B = (A[3] & ~B[3]) |
                         (x3 & A[2] & ~B[2]) |
                         (x3 & x2 & A[1] & ~B[1]) |
                         (x3 & x2 & x1 & A[0] & ~B[0]);

    // A<B condition
    assign A_less_B = (~A[3] & B[3]) |
                      (x3 & ~A[2] & B[2]) |
                      (x3 & x2 & ~A[1] & B[1]) |
                      (x3 & x2 & x1 & ~A[0] & B[0]);

endmodule

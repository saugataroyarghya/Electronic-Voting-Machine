//-----------------------------------------------------------------------------
//
// Title       : voter_memory_unit
// Design      : evm
// Author      : Saugata
// Company     : KUET
//
//-----------------------------------------------------------------------------
//
// File        : C:/Users/Saugata/Desktop/DSD Project/evm/evm/src/voter_memory_unit.v
// Generated   : Wed Jan  8 23:21:03 2025
// From        : Interface description file
// By          : ItfToHdl ver. 1.0
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------


`timescale 1ps / 1ps

module voter_memory_unit (
    input [3:0] voter_number,       // Voter number input
    input vote_cast,                // Signal indicating a vote has been cast
    input clk,                      // Clock signal
    output [3:0] voter_out          // Output stored voter number and flag
);
    wire [3:0] current_voter_status; // Current voter data from memory
    wire msb_set;                    // MSB flag indicating voter has voted
    wire [3:0] next_voter_status;    // Updated voter data with flag set

    // Use hardware logic to set MSB based on vote_cast
    assign msb_set = vote_cast | current_voter_status[3]; // OR operation for MSB flag

    // Combine MSB and voter number into next voter status
    assign next_voter_status = {msb_set, voter_number[2:0]};

    // Memory block for storing voter data (including flag)
    memory_block_4bit voter_memory (
        .data_in(next_voter_status),
        .write_enable(vote_cast),
        .clk(clk),
        .data_out(current_voter_status)
    );

    // Output the current voter data
    assign voter_out = current_voter_status;

endmodule

		

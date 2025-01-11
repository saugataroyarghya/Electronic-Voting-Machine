`timescale 1ps / 1ps

module ballot_memory_unit (
    input [3:0] candidate_number,  // Candidate number input
    input vote_cast,               // Signal indicating a vote has been cast
    input clk,                     // Clock signal
    output [3:0] candidate_out,    // Output: Stored candidate number
    output [3:0] vote_count        // Output: Vote count for the candidate
);
    // Internal signals for current vote count, increment value, and next vote count
    wire [3:0] current_vote_count; // Current vote count from memory
    wire [3:0] increment;          // Increment value
    wire [3:0] next_vote_count;    // Next vote count after increment
    wire carry_out;                // Carry out (unused for vote count)

    // Initialize vote count to 0
    reg [3:0] current_vote_count_reg = 4'b0000;
    
    // Increment is always 1 when a vote is cast, otherwise 0
    assign increment = vote_cast ? 4'b0001 : 4'b0000;

    // Instantiate the 4-bit adder to calculate the next vote count
    adder_4bit adder (
        .a(current_vote_count), // Current vote count
        .b(increment),          // Increment value (1 or 0)
        .sum(next_vote_count),  // Updated vote count
        .carry_out(carry_out)   // Carry out (unused for vote count)
    );

    // Memory block for storing the candidate number
    memory_block_4bit candidate_memory (
        .data_in(candidate_number), // Candidate number input
        .write_enable(vote_cast),   // Write only when a vote is cast
        .clk(clk),                  // Clock signal
        .data_out(candidate_out)    // Stored candidate number output
    );

    // Memory block for storing the vote count
    memory_block_4bit vote_count_memory (
        .data_in(next_vote_count),  // Updated vote count
        .write_enable(vote_cast),   // Write only when a vote is cast
        .clk(clk),                  // Clock signal
        .data_out(current_vote_count) // Stored current vote count
    );

    // Output the current vote count
    assign vote_count = current_vote_count;

    // Use an initial block to set initial state for the vote count
    initial begin
        current_vote_count_reg = 4'b0000; // Initialize the vote count to 0
    end

    // Use the initialized value
    assign current_vote_count = current_vote_count_reg;

endmodule

`timescale 1ps / 1ps

module ballot_memory_unit (
    input [3:0] candidate_number,  // Candidate number input
    input vote_cast,               // Signal indicating a vote has been cast
    input clk,                     // Clock signal
    input initializer,             // Signal to initialize/reset the module
    output [3:0] candidate_out,    // Output: Stored candidate number
    output [3:0] vote_count        // Output: Vote count for the candidate
);
    // Internal signals for vote count and increment
    wire [3:0] current_vote_count; // Current vote count from memory
    wire [3:0] increment;          // Increment value
    wire [3:0] temp_vote_count;    // Temporary vote count from the adder
    wire [3:0] next_vote_count;    // Final vote count after considering initializer
    wire carry_out;                // Carry out (unused for vote count)

    // Generate the increment value
    assign increment[0] = vote_cast;  // LSB is the vote_cast signal
    assign increment[1] = 1'b0;       // Other bits are 0 since increment is 1
    assign increment[2] = 1'b0;
    assign increment[3] = 1'b0;

    // Use the 4-bit adder module to calculate the next vote count
    adder_4bit adder (
        .a(current_vote_count), // Current vote count
        .b(increment),          // Increment value (1 or 0)
        .sum(temp_vote_count),  // Updated vote count
        .carry_out(carry_out)   // Carry out (ignored)
    );

    // Logic to handle initializer using multiplexer
    assign next_vote_count[0] = (initializer & 1'b0) | (~initializer & temp_vote_count[0]);
    assign next_vote_count[1] = (initializer & 1'b0) | (~initializer & temp_vote_count[1]);
    assign next_vote_count[2] = (initializer & 1'b0) | (~initializer & temp_vote_count[2]);
    assign next_vote_count[3] = (initializer & 1'b0) | (~initializer & temp_vote_count[3]);

    // Memory block for storing the candidate number
    memory_block_4bit candidate_memory (
        .data_in(candidate_number), // Candidate number input
        .write_enable(initializer | vote_cast), // Write on initializer or vote_cast
        .clk(clk),                  // Clock signal
        .data_out(candidate_out)    // Stored candidate number output
    );

    // Memory block for storing the vote count
    memory_block_4bit vote_count_memory (
        .data_in(next_vote_count),  // Updated vote count
        .write_enable(initializer | vote_cast), // Write on initializer or vote_cast
        .clk(clk),                  // Clock signal
        .data_out(current_vote_count) // Stored current vote count
    );

    // Output the current vote count
    assign vote_count = current_vote_count;

endmodule

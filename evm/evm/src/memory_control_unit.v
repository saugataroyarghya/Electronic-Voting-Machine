`timescale 1ps / 1ps

module memory_control_unit (
    input [3:0] candidate_number,      // Candidate number input
    input [3:0] voter_number,          // Voter number input
    input [2:0] candidate_select,      // Candidate selection signal (3 candidates)
    input [3:0] voter_select,          // Voter selection signal (4 voters)
    input vote_cast,                   // Signal indicating a vote has been cast
    input clk,                         // Clock signal
    output [3:0] candidate_out [2:0],  // Output vote counts for each candidate
    output [3:0] voter_out [3:0]       // Output voter statuses for each voter
);
    // Internal wires for ballot memory unit outputs
    wire [3:0] ballot_outputs[2:0];
    wire [3:0] voter_outputs[3:0];

    // Instantiate 3 Ballot Memory Units
    ballot_memory_unit ballot_0 (
        .candidate_number(candidate_number),
        .vote_cast(candidate_select[0] & vote_cast), // Cast vote only for selected candidate
        .clk(clk),
        .candidate_out(), // Optional: can expose candidate number if needed
        .vote_count(ballot_outputs[0])
    );

    ballot_memory_unit ballot_1 (
        .candidate_number(candidate_number),
        .vote_cast(candidate_select[1] & vote_cast), // Cast vote only for selected candidate
        .clk(clk),
        .candidate_out(), // Optional: can expose candidate number if needed
        .vote_count(ballot_outputs[1])
    );

    ballot_memory_unit ballot_2 (
        .candidate_number(candidate_number),
        .vote_cast(candidate_select[2] & vote_cast), // Cast vote only for selected candidate
        .clk(clk),
        .candidate_out(), // Optional: can expose candidate number if needed
        .vote_count(ballot_outputs[2])
    );

    // Instantiate 4 Voter Memory Units
    voter_memory_unit voter_0 (
        .voter_number(voter_number),
        .vote_cast(voter_select[0] & vote_cast), // Allow vote only for selected voter
        .clk(clk),
        .voter_out(voter_outputs[0])
    );

    voter_memory_unit voter_1 (
        .voter_number(voter_number),
        .vote_cast(voter_select[1] & vote_cast), // Allow vote only for selected voter
        .clk(clk),
        .voter_out(voter_outputs[1])
    );

    voter_memory_unit voter_2 (
        .voter_number(voter_number),
        .vote_cast(voter_select[2] & vote_cast), // Allow vote only for selected voter
        .clk(clk),
        .voter_out(voter_outputs[2])
    );

    voter_memory_unit voter_3 (
        .voter_number(voter_number),
        .vote_cast(voter_select[3] & vote_cast), // Allow vote only for selected voter
        .clk(clk),
        .voter_out(voter_outputs[3])
    );

    // Output vote counts for each candidate
    assign candidate_out[0] = ballot_outputs[0];
    assign candidate_out[1] = ballot_outputs[1];
    assign candidate_out[2] = ballot_outputs[2];

    // Output statuses for each voter
    assign voter_out[0] = voter_outputs[0];
    assign voter_out[1] = voter_outputs[1];
    assign voter_out[2] = voter_outputs[2];
    assign voter_out[3] = voter_outputs[3];
endmodule

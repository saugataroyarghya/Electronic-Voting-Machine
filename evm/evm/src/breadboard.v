`timescale 1ps / 1ps

module breadboard (
    input [3:0] voter_id,          // Input: Voter ID
    input [3:0] candidate_number,  // Input: Candidate number
    input clk,                     // Clock signal
    input vote_cast,               // Signal to cast the vote
    output reg [3:0] winner        // Output: Winner candidate number
);
    // Outputs of the memory control unit
    wire [3:0] candidate_out [2:0]; // Vote counts for 3 candidates
    wire [3:0] voter_out [3:0];     // Voter statuses for 4 voters

    // Instantiate the memory control unit
    memory_control_unit mcu (
        .candidate_number(candidate_number),
        .voter_number(voter_id),
        .candidate_select(3'b111),  // Enable all candidates
        .voter_select(4'b1111),     // Enable all voters
        .vote_cast(vote_cast),
        .clk(clk),
        .candidate_out(candidate_out),
        .voter_out(voter_out)
    );

    // Winner determination logic
    wire [3:0] max_vote_count;
    wire [3:0] candidate_with_max_votes;

    winner_logic winner_calc (
        .vote_counts({candidate_out[2], candidate_out[1], candidate_out[0]}),
        .winner(candidate_with_max_votes),
        .max_votes(max_vote_count)
    );

    // Update winner based on voting results
    always @(posedge clk) begin
        winner <= candidate_with_max_votes;
    end
endmodule

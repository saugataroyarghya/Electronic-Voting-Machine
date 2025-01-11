`timescale 1ps / 1ps

module winner_logic (
    input [2:0][3:0] candidate_numbers, // Array of candidate numbers
    input [2:0][3:0] vote_counts,       // Array of vote counts
    output [3:0] winner_candidate,      // Winner candidate number
    output [3:0] winner_vote_count      // Winner vote count
);
    // Internal wires for comparison results
    wire [3:0] max_01, max_012;
    wire [3:0] winner_candidate_01, winner_candidate_012;
    wire greater_0_1, greater_01_2;

    // First comparison: Candidate 0 vs Candidate 1
    comparator_4bit comp_0_1 (
        .A(vote_counts[0]),
        .B(vote_counts[1]),
        .A_equal_B(),
        .A_greater_B(greater_0_1),
        .A_less_B()
    );

    // Implement max_01 using logic gates
    assign max_01 = (vote_counts[0] & {4{greater_0_1}}) | (vote_counts[1] & {4{~greater_0_1}});

    // Implement winner_candidate_01 using logic gates
    assign winner_candidate_01 = (candidate_numbers[0] & {4{greater_0_1}}) | 
                                 (candidate_numbers[1] & {4{~greater_0_1}});

    // Second comparison: Winner of 0 vs 1 vs Candidate 2
    comparator_4bit comp_01_2 (
        .A(max_01),
        .B(vote_counts[2]),
        .A_equal_B(),
        .A_greater_B(greater_01_2),
        .A_less_B()
    );

    // Implement max_012 using logic gates
    assign max_012 = (max_01 & {4{greater_01_2}}) | (vote_counts[2] & {4{~greater_01_2}});

    // Implement winner_candidate_012 using logic gates
    assign winner_candidate_012 = (winner_candidate_01 & {4{greater_01_2}}) | 
                                  (candidate_numbers[2] & {4{~greater_01_2}});

    // Final outputs
    assign winner_candidate = winner_candidate_012;
    assign winner_vote_count = max_012;

endmodule

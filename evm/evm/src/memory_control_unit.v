`timescale 1ps / 1ps

module memory_control_unit(
    input [1:0] candidate_number,  // Candidate index (0-2)
    input [2:0] voter_number,      // Voter index (0-4)
    input vote_signal,             // Signal to indicate voting
    input clk,                     // Clock signal
    output reg [1:0] winner_candidate, // Winner candidate index
    output reg [2:0] out_vote      // Maximum vote count
);

    // Register array for voters (5 voters, 4-bit each)
    reg [3:0] voters [4:0];
    // Register array for candidates (3 candidates, vote count)
    reg [3:0] candidates [2:0];
    
    // Wires for vote enable and validation
    wire valid_voter;
    wire voter_has_not_voted;
    wire valid_candidate;
    wire vote_enable;

    // Wires for the adder results
    wire [3:0] candidate0_new_vote, candidate1_new_vote, candidate2_new_vote;

    // Internal wires for winner determination
    wire [3:0] candidate_votes [2:0];
    wire [3:0] max_vote_01, max_vote_012;
    wire [1:0] winner_01, winner_012;
    wire greater_0_1, greater_01_2;

    // Initialize voters and candidates
    initial begin
        // Initialize voter statuses (0 means not voted)
        voters[0] = 4'b0000; 
        voters[1] = 4'b0001;
        voters[2] = 4'b0010;
        voters[3] = 4'b0011;
        voters[4] = 4'b0100;

        // Initialize candidate vote counts
        candidates[0] = 4'b0000;
        candidates[1] = 4'b0000; 
        candidates[2] = 4'b0000;

        // Initialize outputs
        winner_candidate = 2'b00;
        out_vote = 3'b000;
    end

    // Assign wires for candidate votes
    assign candidate_votes[0] = candidates[0];
    assign candidate_votes[1] = candidates[1];
    assign candidate_votes[2] = candidates[2];

    // Comparator for voter validation (voter_number < 5)
    comparator_4bit comp_voter (
        .A({1'b0, voter_number}), // Pad voter_number to 4 bits
        .B(4'b0101),              // 5 in binary (4-bit)
        .enable(1'b1),            // Enable comparison
        .A_greater_B(),
        .A_less_B(valid_voter),
        .A_equal_B()
    );

    // Check if voter has not voted (MSB of voter record is 0)
    assign voter_has_not_voted = ~voters[voter_number][3];

    // Comparator for candidate validation (candidate_number < 3)
    comparator_4bit comp_candidate (
        .A({2'b00, candidate_number}), // Pad candidate_number to 4 bits
        .B(4'b0011),                   // 3 in binary (4-bit)
        .enable(1'b1),                 // Enable comparison
        .A_greater_B(),
        .A_less_B(valid_candidate),
        .A_equal_B()
    );

    // Voting enable signal: AND gate for all conditions
    assign vote_enable = vote_signal & valid_voter & voter_has_not_voted & valid_candidate;

   // Comparator to check if candidate_number == 2'b00
	wire candidate_is_0;
	wire candidate_is_1;
	wire candidate_is_2;
	comparator_4bit comp_candidate_0 (
    	.A({2'b00, candidate_number}), // Pad candidate_number to 4 bits
    	.B(4'b0000),                   // 0 in 4-bit
    	.enable(1'b1),                 // Enable comparison
    	.A_greater_B(),
    	.A_less_B(),
    	.A_equal_B(candidate_is_0)
	);

	// Comparator to check if candidate_number == 2'b01

	comparator_4bit comp_candidate_1 (
    	.A({2'b00, candidate_number}), // Pad candidate_number to 4 bits
    	.B(4'b0001),                   // 1 in 4-bit
    	.enable(1'b1),                 // Enable comparison
    	.A_greater_B(),
    	.A_less_B(),
    	.A_equal_B(candidate_is_1)
	);

	// Comparator to check if candidate_number == 2'b10

	comparator_4bit comp_candidate_2 (
    	.A({2'b00, candidate_number}), // Pad candidate_number to 4 bits
    	.B(4'b0010),                   // 2 in 4-bit
    	.enable(1'b1),                 // Enable comparison
    	.A_greater_B(),
    	.A_less_B(),
    	.A_equal_B(candidate_is_2)
	);

	// Instantiate adder_4bit for each candidate using comparator outputs
	adder_4bit adder_candidate0 (
    	.a(candidates[0]),
    	.b(4'b0001 & {4{vote_enable & candidate_is_0}}),
    	.sum(candidate0_new_vote),
    	.carry_out()
	);

	adder_4bit adder_candidate1 (
    	.a(candidates[1]),
    	.b(4'b0001 & {4{vote_enable & candidate_is_1}}),
    	.sum(candidate1_new_vote),
    	.carry_out()
	);

	adder_4bit adder_candidate2 (
    	.a(candidates[2]),
    	.b(4'b0001 & {4{vote_enable & candidate_is_2}}),
    	.sum(candidate2_new_vote),
    	.carry_out()
	);


    // Update candidate votes and voter records
    always @(posedge clk) begin
        candidates[0] <= candidate0_new_vote;
        candidates[1] <= candidate1_new_vote;
        candidates[2] <= candidate2_new_vote;

        // Mark voter as having voted
        voters[voter_number] <= voters[voter_number] | {1'b1, 3'b000} & {4{vote_enable}};
    end

    // Winner determination using comparators and bitwise logic
    comparator_4bit comp_0_1 (
        .A(candidate_votes[0]),
        .B(candidate_votes[1]),
        .enable(1'b1),
        .A_greater_B(greater_0_1),
        .A_less_B(),
        .A_equal_B()
    );

    assign max_vote_01 = (candidate_votes[0] & {4{greater_0_1}}) | 
                         (candidate_votes[1] & {4{~greater_0_1}});
    assign winner_01 = (2'b00 & {2{greater_0_1}}) | 
                       (2'b01 & {2{~greater_0_1}});

    comparator_4bit comp_01_2 (
        .A(max_vote_01),
        .B(candidate_votes[2]),
        .enable(1'b1),
        .A_greater_B(greater_01_2),
        .A_less_B(),
        .A_equal_B()
    );

    assign max_vote_012 = (max_vote_01 & {4{greater_01_2}}) | 
                          (candidate_votes[2] & {4{~greater_01_2}});
    assign winner_012 = (winner_01 & {2{greater_01_2}}) | 
                        (2'b10 & {2{~greater_01_2}});

    // Assign final outputs
    always @(posedge clk) begin
        winner_candidate <= winner_012;
        out_vote <= max_vote_012[2:0];
    end

endmodule

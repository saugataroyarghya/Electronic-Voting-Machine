`timescale 1ps / 1ps

module tb_winner_logic;
    // Testbench inputs
    reg [2:0][3:0] candidate_numbers; // Candidate numbers (3 candidates)
    reg [2:0][3:0] vote_counts;       // Vote counts for 3 candidates

    // Testbench outputs
    wire [3:0] winner_candidate;     // Winner candidate number
    wire [3:0] winner_vote_count;    // Winner vote count

    // Instantiate the winner_logic module
    winner_logic uut (
        .candidate_numbers(candidate_numbers),
        .vote_counts(vote_counts),
        .winner_candidate(winner_candidate),
        .winner_vote_count(winner_vote_count)
    );

    // Test sequence
    initial begin
        // Test case 1: Candidate 0 has the most votes
        candidate_numbers = {4'b0010, 4'b0001, 4'b0000}; // Candidates: 2, 1, 0
        vote_counts = {4'b0011, 4'b0010, 4'b0001};       // Votes: 3, 2, 1
        #10; // Wait for logic to settle
        $display("Test Case 1: Winner = %b, Votes = %b", winner_candidate, winner_vote_count);
        $display("Expected Winner = 2, Votes = 3");

        // Test case 2: Candidate 2 has the most votes
        candidate_numbers = {4'b0000, 4'b0001, 4'b0010}; // Candidates: 0, 1, 2
        vote_counts = {4'b0001, 4'b0010, 4'b0011};       // Votes: 1, 2, 3
        #10;
        $display("Test Case 2: Winner = %b, Votes = %b", winner_candidate, winner_vote_count);
        $display("Expected Winner = 2, Votes = 3");

        // Test case 3: Tie between candidates 0 and 1
        candidate_numbers = {4'b0000, 4'b0001, 4'b0010}; // Candidates: 0, 1, 2
        vote_counts = {4'b0011, 4'b0011, 4'b0010};       // Votes: 3, 3, 2
        #10;
        $display("Test Case 3: Winner = %b, Votes = %b", winner_candidate, winner_vote_count);
        $display("Expected Winner = 0 or 1, Votes = 3");

        // Test case 4: All candidates have zero votes
        candidate_numbers = {4'b0000, 4'b0001, 4'b0010}; // Candidates: 0, 1, 2
        vote_counts = {4'b0000, 4'b0000, 4'b0000};       // Votes: 0, 0, 0
        #10;
        $display("Test Case 4: Winner = %b, Votes = %b", winner_candidate, winner_vote_count);
        $display("Expected Winner = 0, Votes = 0");

        // Test case 5: Candidate 1 has the most votes
        candidate_numbers = {4'b0000, 4'b0001, 4'b0010}; // Candidates: 0, 1, 2
        vote_counts = {4'b0001, 4'b0100, 4'b0010};       // Votes: 1, 4, 2
        #10;
        $display("Test Case 5: Winner = %b, Votes = %b", winner_candidate, winner_vote_count);
        $display("Expected Winner = 1, Votes = 4");

        $stop; // End simulation
    end
endmodule

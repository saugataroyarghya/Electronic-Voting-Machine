`timescale 1ps / 1ps

module tb_ballot_memory_unit;
    // Testbench inputs
    reg [3:0] candidate_number;  // Candidate number input
    reg vote_cast;               // Signal to cast a vote
    reg clk;                     // Clock signal

    // Testbench outputs
    wire [3:0] candidate_out;    // Output: Stored candidate number
    wire [3:0] vote_count;       // Output: Vote count for the candidate

    // Instantiate the ballot_memory_unit
    ballot_memory_unit uut (
        .candidate_number(candidate_number),
        .vote_cast(vote_cast),
        .clk(clk),
        .candidate_out(candidate_out),
        .vote_count(vote_count)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock with 10ps period
    end

    // Test sequence
    initial begin
        // Initialize inputs
        candidate_number = 4'b0000;
        vote_cast = 0;

        // Test case 1: Cast one vote for candidate 3
        #10;
        candidate_number = 4'b0011; // Candidate 3
        vote_cast = 1;
        #10;
        vote_cast = 0; // Stop casting votes
        #10;
        $display("Test Case 1: Candidate = %b, Votes = %b", candidate_out, vote_count);
        $display("Expected: Candidate = 3, Votes = 1");

        // Test case 2: Cast two more votes for candidate 3
        #10;
        vote_cast = 1; // Cast vote 2
        #10;
        vote_cast = 1; // Cast vote 3
        #10;
        vote_cast = 0; // Stop casting votes
        #10;
        $display("Test Case 2: Candidate = %b, Votes = %b", candidate_out, vote_count);
        $display("Expected: Candidate = 3, Votes = 3");

        // Test case 3: Switch to candidate 1 and cast one vote
        #10;
        candidate_number = 4'b0001; // Candidate 1
        vote_cast = 1;
        #10;
        vote_cast = 0; // Stop casting votes
        #10;
        $display("Test Case 3: Candidate = %b, Votes = %b", candidate_out, vote_count);
        $display("Expected: Candidate = 1, Votes = 1");

        // Test case 4: Cast two votes for candidate 2
        #10;
        candidate_number = 4'b0010; // Candidate 2
        vote_cast = 1; // Cast vote 1
        #10;
        vote_cast = 1; // Cast vote 2
        #10;
        vote_cast = 0; // Stop casting votes
        #10;
        $display("Test Case 4: Candidate = %b, Votes = %b", candidate_out, vote_count);
        $display("Expected: Candidate = 2, Votes = 2");

        $stop; // End simulation
    end
endmodule

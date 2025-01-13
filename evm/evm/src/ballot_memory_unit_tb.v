`timescale 1ps / 1ps

module ballot_memory_unit_tb;

    // Testbench signals
    reg [3:0] candidate_number; // Input candidate number
    reg vote_cast;              // Signal to indicate a vote is cast
    reg clk;                    // Clock signal
    reg initializer;            // Signal to initialize/reset the module
    wire [3:0] candidate_out;   // Output candidate number
    wire [3:0] vote_count;      // Output vote count

    // Instantiate the ballot_memory_unit
    ballot_memory_unit uut (
        .candidate_number(candidate_number),
        .vote_cast(vote_cast),
        .clk(clk),
        .initializer(initializer),
        .candidate_out(candidate_out),
        .vote_count(vote_count)
    );

    // Clock generation (50% duty cycle)
    always #5 clk = ~clk;

    // Testbench logic
    initial begin
        // Initialize signals
        clk = 0;
        vote_cast = 0;
        initializer = 0;
        candidate_number = 4'b0000;

        // Display header for test output
        $display("Time\tInit\tVote\tCand_in\tCand_out\tVote_count");
        $display("--------------------------------------------------");

        // Test case 1: Initializing the module
        initializer = 1;        // Set initializer high
        candidate_number = 4'b1010; // Set candidate number to 10
        #10;                    // Wait for one clock cycle
        initializer = 0;        // Deactivate initializer
        #10;
        $display("%0d\t%b\t%b\t%b\t%b\t%b", $time, initializer, vote_cast, candidate_number, candidate_out, vote_count);

        // Test case 2: Casting a vote
        vote_cast = 1;          // Set vote_cast high
        #10;                    // Wait for one clock cycle
        vote_cast = 0;          // Deactivate vote_cast
        #10;
        $display("%0d\t%b\t%b\t%b\t%b\t%b", $time, initializer, vote_cast, candidate_number, candidate_out, vote_count);

        // Test case 3: Cast multiple votes
        vote_cast = 1;
        #10; // First vote
        vote_cast = 0;
        #10;
        vote_cast = 1;
        #10; // Second vote
        vote_cast = 0;
        #10;
        $display("%0d\t%b\t%b\t%b\t%b\t%b", $time, initializer, vote_cast, candidate_number, candidate_out, vote_count);

        // Test case 4: Reinitializing the module
        initializer = 1;
        candidate_number = 4'b1100; // Change candidate number to 12
        #10; // Wait for one clock cycle
        initializer = 0;
        #10;
        $display("%0d\t%b\t%b\t%b\t%b\t%b", $time, initializer, vote_cast, candidate_number, candidate_out, vote_count);

        // Test case 5: Cast votes after reinitialization
        vote_cast = 1;
        #10; // Cast one vote
        vote_cast = 0;
        #10;
        $display("%0d\t%b\t%b\t%b\t%b\t%b", $time, initializer, vote_cast, candidate_number, candidate_out, vote_count);

        // Finish the simulation
        $finish;
    end
endmodule

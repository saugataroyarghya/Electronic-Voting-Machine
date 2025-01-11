`timescale 1ps / 1ps

module final_breadboard_tb;

    // Testbench signals
    reg [3:0] voter_id;          // Input: Voter ID
    reg [3:0] candidate_number;  // Input: Candidate number
    reg clk;                     // Clock signal
    reg vote_cast;               // Signal to cast the vote
    wire [3:0] winner;           // Output: Winner candidate number

    // Instantiate the final_breadboard module
    breadboard fb (
        .voter_id(voter_id),
        .candidate_number(candidate_number),
        .clk(clk),
        .vote_cast(vote_cast),
        .winner(winner)
    );

    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units clock period
    end

    // Test stimulus
    initial begin
        // Initialize signals
        voter_id = 4'b0000;  // Voter ID 0
        candidate_number = 4'b0000;  // Candidate 0
        vote_cast = 0;      // No vote cast initially
        
        // Wait for some time before casting votes
        #10;
        
        // Voter 0 votes for Candidate 0
        voter_id = 4'b0000; 
        candidate_number = 4'b0000; 
        vote_cast = 1;      // Cast vote
        #10 vote_cast = 0;  // Reset vote_cast

        // Voter 1 votes for Candidate 1
        #10;
        voter_id = 4'b0001;
        candidate_number = 4'b0001;
        vote_cast = 1;      // Cast vote
        #10 vote_cast = 0;

        // Voter 2 votes for Candidate 1
        #10;
        voter_id = 4'b0010;
        candidate_number = 4'b0001;
        vote_cast = 1;      // Cast vote
        #10 vote_cast = 0;

        // Voter 3 votes for Candidate 2
        #10;
        voter_id = 4'b0011;
        candidate_number = 4'b0010;
        vote_cast = 1;      // Cast vote
        #10 vote_cast = 0;

        // Voter 4 votes for Candidate 2
        #10;
        voter_id = 4'b0100;
        candidate_number = 4'b0010;
        vote_cast = 1;      // Cast vote
        #10 vote_cast = 0;

        // Wait for the final vote count to settle
        #10;

        // Display winner
        $display("Winner Candidate: %d", winner);
        
        // Finish simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t, Voter ID = %d, Candidate = %d, Vote Cast = %d, Winner = %d", 
                 $time, voter_id, candidate_number, vote_cast, winner);
    end

endmodule

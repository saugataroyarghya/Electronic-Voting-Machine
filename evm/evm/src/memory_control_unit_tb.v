`timescale 1ps / 1ps

module memory_control_unit_tb;
    // Testbench signals
    reg [3:0] candidate_number;
    reg [3:0] voter_number;
    reg [2:0] candidate_select;
    reg [3:0] voter_select;
    reg vote_cast;
    reg clk;
    wire [3:0] candidate_out [2:0];
    wire [3:0] voter_out [3:0];

    // Instantiate the memory_control_unit
    memory_control_unit uut (
        .candidate_number(candidate_number),
        .voter_number(voter_number),
        .candidate_select(candidate_select),
        .voter_select(voter_select),
        .vote_cast(vote_cast),
        .clk(clk),
        .candidate_out(candidate_out),
        .voter_out(voter_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ps clock period
    end

    // Testbench stimulus
    initial begin
        // Initialize inputs
        candidate_number = 4'b0000;
        voter_number = 4'b0000;
        candidate_select = 3'b000;
        voter_select = 4'b0000;
        vote_cast = 0;

        // Wait for a few clock cycles
        #20;

        // Cast a vote for candidate 0 by voter 0
        $display("Test: Voter 0 voting for Candidate 0...");
        candidate_number = 4'b0000;    // Candidate 0
        voter_number = 4'b0000;       // Voter 0
        candidate_select = 3'b001;    // Select Candidate 0
        voter_select = 4'b0001;       // Select Voter 0
        vote_cast = 1;                // Enable voting
        #10;                          // Wait for one clock cycle
        vote_cast = 0;                // Disable voting
        #20;

        // Cast a vote for candidate 1 by voter 1
        $display("Test: Voter 1 voting for Candidate 1...");
        candidate_number = 4'b0001;    // Candidate 1
        voter_number = 4'b0001;       // Voter 1
        candidate_select = 3'b010;    // Select Candidate 1
        voter_select = 4'b0010;       // Select Voter 1
        vote_cast = 1;                // Enable voting
        #10;                          // Wait for one clock cycle
        vote_cast = 0;                // Disable voting
        #20;

        // Cast a vote for candidate 2 by voter 2
        $display("Test: Voter 2 voting for Candidate 2...");
        candidate_number = 4'b0010;    // Candidate 2
        voter_number = 4'b0010;       // Voter 2
        candidate_select = 3'b100;    // Select Candidate 2
        voter_select = 4'b0100;       // Select Voter 2
        vote_cast = 1;                // Enable voting
        #10;                          // Wait for one clock cycle
        vote_cast = 0;                // Disable voting
        #20;

        // Cast another vote for candidate 0 by voter 3
        $display("Test: Voter 3 voting for Candidate 0...");
        candidate_number = 4'b0000;    // Candidate 0
        voter_number = 4'b0011;       // Voter 3
        candidate_select = 3'b001;    // Select Candidate 0
        voter_select = 4'b1000;       // Select Voter 3
        vote_cast = 1;                // Enable voting
        #10;                          // Wait for one clock cycle
        vote_cast = 0;                // Disable voting
        #20;

        // Display final results
        $display("\nFinal Results:");
        $display("Candidate 0 vote count: %d", candidate_out[0]);
        $display("Candidate 1 vote count: %d", candidate_out[1]);
        $display("Candidate 2 vote count: %d", candidate_out[2]);

        $display("Voter 0 status: %b", voter_out[0]);
        $display("Voter 1 status: %b", voter_out[1]);
        $display("Voter 2 status: %b", voter_out[2]);
        $display("Voter 3 status: %b", voter_out[3]);

        $stop; // End simulation
    end
endmodule

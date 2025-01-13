`timescale 1ps / 1ps

module comparator_4bit_tb;

    // Testbench signals
    reg [3:0] A;                  // Input A
    reg [3:0] B;                  // Input B
    wire A_equal_B;               // Output for A = B
    wire A_greater_B;             // Output for A > B
    wire A_less_B;                // Output for A < B

    // Instantiate the comparator_4bit module
    comparator_4bit uut (
        .A(A),
        .B(B),
		.enable(1),
        .A_equal_B(A_equal_B),
        .A_greater_B(A_greater_B),
        .A_less_B(A_less_B)
    );

    // Test stimulus
    initial begin
        // Display header
        $display("Time\t A      B      | A_equal_B A_greater_B A_less_B");

        // Apply test cases
        A = 4'b0000; B = 4'b0000; #5; $display("%0t\t %b  %b  |     %b          %b          %b", $time, A, B, A_equal_B, A_greater_B, A_less_B);
        A = 4'b0001; B = 4'b0000; #5; $display("%0t\t %b  %b  |     %b          %b          %b", $time, A, B, A_equal_B, A_greater_B, A_less_B);
        A = 4'b0010; B = 4'b0010; #5; $display("%0t\t %b  %b  |     %b          %b          %b", $time, A, B, A_equal_B, A_greater_B, A_less_B);
        A = 4'b0101; B = 4'b0110; #5; $display("%0t\t %b  %b  |     %b          %b          %b", $time, A, B, A_equal_B, A_greater_B, A_less_B);
        A = 4'b1111; B = 4'b1111; #5; $display("%0t\t %b  %b  |     %b          %b          %b", $time, A, B, A_equal_B, A_greater_B, A_less_B);
        A = 4'b1010; B = 4'b1001; #5; $display("%0t\t %b  %b  |     %b          %b          %b", $time, A, B, A_equal_B, A_greater_B, A_less_B);
        A = 4'b1000; B = 4'b1100; #5; $display("%0t\t %b  %b  |     %b          %b          %b", $time, A, B, A_equal_B, A_greater_B, A_less_B);

        // Finish simulation
        #5 $finish;
    end

    // Monitor changes
    initial begin
        $monitor("At time %0t: A=%b, B=%b => A_equal_B=%b, A_greater_B=%b, A_less_B=%b", $time, A, B, A_equal_B, A_greater_B, A_less_B);
    end

endmodule

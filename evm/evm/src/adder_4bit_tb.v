`timescale 1ps / 1ps

module adder_4bit_tb;

    // Testbench signals
    reg [3:0] a;          // First 4-bit input
    reg [3:0] b;          // Second 4-bit input
    wire [3:0] sum;       // 4-bit sum output
    wire carry_out;       // Carry-out from the most significant bit

    // Instantiate the adder_4bit module
    adder_4bit uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry_out(carry_out)
    );

    // Test stimulus
    initial begin
        // Display header
        $display("Time\t a      b      | sum    carry_out");

        // Apply test cases
        a = 4'b0000; b = 4'b0000; #5; $display("%0t\t %b  %b  |  %b  %b", $time, a, b, sum, carry_out);
        a = 4'b0001; b = 4'b0001; #5; $display("%0t\t %b  %b  |  %b  %b", $time, a, b, sum, carry_out);
        a = 4'b0010; b = 4'b0011; #5; $display("%0t\t %b  %b  |  %b  %b", $time, a, b, sum, carry_out);
        a = 4'b0100; b = 4'b0111; #5; $display("%0t\t %b  %b  |  %b  %b", $time, a, b, sum, carry_out);
        a = 4'b0110; b = 4'b1010; #5; $display("%0t\t %b  %b  |  %b  %b", $time, a, b, sum, carry_out);
        a = 4'b1111; b = 4'b1111; #5; $display("%0t\t %b  %b  |  %b  %b", $time, a, b, sum, carry_out);

        // Finish simulation
        #5 $finish;
    end

    // Monitor changes
    initial begin
        $monitor("At time %0t: a=%b, b=%b => sum=%b, carry_out=%b", $time, a, b, sum, carry_out);
    end

endmodule

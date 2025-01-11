`timescale 1ps / 1ps

module full_adder_tb;

    // Testbench signals
    reg a;          // First bit
    reg b;          // Second bit
    reg cin;        // Carry-in
    wire sum;       // Sum output
    wire cout;      // Carry-out

    // Instantiate the full_adder module
    full_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Test stimulus
    initial begin
        // Display header
        $display("Time\t a b cin | sum cout");

        // Apply all possible combinations of inputs
        a = 0; b = 0; cin = 0; #5; $display("%0t\t %b %b  %b   |  %b   %b", $time, a, b, cin, sum, cout);
        a = 0; b = 0; cin = 1; #5; $display("%0t\t %b %b  %b   |  %b   %b", $time, a, b, cin, sum, cout);
        a = 0; b = 1; cin = 0; #5; $display("%0t\t %b %b  %b   |  %b   %b", $time, a, b, cin, sum, cout);
        a = 0; b = 1; cin = 1; #5; $display("%0t\t %b %b  %b   |  %b   %b", $time, a, b, cin, sum, cout);
        a = 1; b = 0; cin = 0; #5; $display("%0t\t %b %b  %b   |  %b   %b", $time, a, b, cin, sum, cout);
        a = 1; b = 0; cin = 1; #5; $display("%0t\t %b %b  %b   |  %b   %b", $time, a, b, cin, sum, cout);
        a = 1; b = 1; cin = 0; #5; $display("%0t\t %b %b  %b   |  %b   %b", $time, a, b, cin, sum, cout);
        a = 1; b = 1; cin = 1; #5; $display("%0t\t %b %b  %b   |  %b   %b", $time, a, b, cin, sum, cout);

        // Finish simulation
        #5 $finish;
    end

    // Monitor all changes
    initial begin
        $monitor("At time %0t: a=%b, b=%b, cin=%b => sum=%b, cout=%b", $time, a, b, cin, sum, cout);
    end

endmodule

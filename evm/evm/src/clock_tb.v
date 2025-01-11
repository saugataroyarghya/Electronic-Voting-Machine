`timescale 1ps / 1ps

module clock_tb;

    // Testbench signals
    reg strt_clk;  // Start clock signal
    wire clk;      // Generated clock signal

    // Instantiate the clock module
    clock clk_gen (
        .strt_clk(strt_clk),
        .clk(clk)
    );

    // Generate the start signal for the clock
    initial begin
        // Initialize the start clock signal
        strt_clk = 0;
        #5 strt_clk = 1;  // Start the clock after 5 time units
        #5 strt_clk = 0;  // Reset the start clock signal to 0
    end

    // Monitor the clock output
    initial begin
        $monitor("At time %t, clk = %b", $time, clk);
    end

    // End simulation after 100 time units
    initial begin
        #100;
        $finish;
    end

endmodule

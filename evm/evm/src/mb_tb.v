`timescale 1ps / 1ps

module memory_block_4bit_tb;

    // Testbench signals
    reg [3:0] data_in;    // Input data for the memory block
    reg write_enable;     // Write enable signal
    reg clk;              // Clock signal
    wire [3:0] data_out;  // Output data from the memory block

    // Instantiate the memory block
    memory_block_4bit mem_block (
        .data_in(data_in),
        .write_enable(write_enable),
        .clk(clk),
        .data_out(data_out)
    );

    // Clock generation: 1ps clock period
    initial begin
        clk = 0;
        forever #1 clk = ~clk;  // Toggle clock every 1ps
    end

    // Stimulus
    initial begin
        // Initialize signals
        data_in = 4'b0000;
        write_enable = 0;

        // Apply test cases
        #5  data_in = 4'b1010;  write_enable = 1;  // Apply data and enable write
        #5  write_enable = 0;    // Disable write (data_out should hold previous value)
        #10 data_in = 4'b1111;   write_enable = 1;  // Apply new data and enable write
        #5  write_enable = 0;    // Disable write (data_out should hold new value)

        // Monitor the output
        #5  $display("At time %t, data_out = %b", $time, data_out);
        #10 $finish;  // End simulation
    end

    // Display the output
    initial begin
        $monitor("At time %t, data_out = %b", $time, data_out);
    end

endmodule

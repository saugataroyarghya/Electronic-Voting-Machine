`timescale 1ps / 1ps

module clock (
    input strt_clk, 
    output reg clk
);

    initial clk = 0; // Initialize clock

    always @(posedge strt_clk) begin
        forever begin
            #1 clk = ~clk; // Toggle clock with a 1ps delay
        end
    end

endmodule

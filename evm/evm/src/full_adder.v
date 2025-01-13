`timescale 1ps / 1ps
module full_adder (
    input a,        // First bit
    input b,        // Second bit
    input cin,      // Carry-in
    output sum,     // Sum output
    output cout     // Carry-out
);
    // Logic for sum and carry-out
    assign sum =  a ^ b ^ cin;     // XOR gates for sum
    assign cout = (a & b) | (b & cin) | (a & cin); // OR gate combining AND gates for carry-out
endmodule

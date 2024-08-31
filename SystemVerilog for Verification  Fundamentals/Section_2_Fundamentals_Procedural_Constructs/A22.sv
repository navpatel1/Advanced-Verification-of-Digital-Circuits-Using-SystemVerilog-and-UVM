// ### A22
// * Assume a system consists of two global signals, resetn and clk. Use an initial block to initialize 
// clk to '0 and resetn to '0. Generate a 25 MHz square wave waveform for the Signal clk. Assume a timescale of 1 ns/1 ps.

`timescale 1ns/1ps

module clock_generator;
    reg clk = 0;
    reg resetn = 0;

    initial begin
        resetn = 0;
        clk = 0;
    end

    always #20 clk = ~clk;

endmodule

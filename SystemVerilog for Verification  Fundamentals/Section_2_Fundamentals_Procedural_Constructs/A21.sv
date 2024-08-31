// ### A21
// Assume a system consists of two global signals, resetn and clk. Use an initial block to initialize clk to '0 and resetn to 
// '0. The user must maintain resetn in an active-low state for 60 ns at the start of the simulation and then make it
//  active-high. Assume a timescale of 1 ns/1 ps.


`timescale 1ns/1ps

module testbench;

    reg clk;
    reg resetn;

    always #5 clk = ~clk;  // Generate a clock signal with a period of 10 ns 100 MHz

    initial begin
        clk = 0;
        resetn = 0;

        // Hold resetn low for 60 ns
        #60;
        resetn = 1;

        #1000 $finish;  // Ends the simulation after 1000 ns
    end

endmodule

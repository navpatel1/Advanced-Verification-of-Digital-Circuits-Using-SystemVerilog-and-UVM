// A53
// Questions for this assignment
// Refer to A53.png
// Create a task that will generate stimulus for addr , wr, and en signal as mentioned in a waveform of the Instruction tab. 
// Assume address is 6-bit wide while en and wr both are 1-bit wide. 
// The stimulus should be sent on a positive edge of 25 MHz clock signal.


`timescale 1ns / 1ps;

module top();

bit [5:0] addr;

bit en = 0,wr = 0;

bit clk = 0;

always #40 clk = ~clk;

task stimulus_addr();

@(posedge clk);

addr = $urandom();

$display("%0d", addr);

endtask

initial begin

for (int i = 0; i < 64; i++) begin

stimulus_addr();

end

end

initial begin

@(posedge clk);

wr = 1;

en = 1;

#80;

wr = 0;

#80

en = 0;

end

// initial begin

// #400 $finish();

// end

endmodule
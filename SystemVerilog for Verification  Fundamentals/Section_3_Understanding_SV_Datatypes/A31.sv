// A31
// Assume you have four variables ( a, b,c, and d )  in your testbench top. a and b are of the 8-bit reg type, while c and d are of the integer type. 
// initialize a,b,c, and d to values of 12, 34, 67, and 255 respectively. Add a code to print the values of all the variables after 12 nSec.


`timescale 1ns/1ps

module testbench;

    reg [7:0] a, b;
    integer c, d;

    initial begin
        a = 12;
        b = 34;
        c = 67;
        d = 255;

        #12;
        $display("Time: %0t ns, a: %0d, b: %0d, c: %0d, d: %0d", $time, a, b, c, d);

        #100 $finish;
    end

endmodule

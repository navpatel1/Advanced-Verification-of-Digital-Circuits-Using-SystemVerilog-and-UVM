// A51
// Create a Class consisting of 3 data members each of unsigned integer type.
// Initialize them to 45,78, and 90. Use the display function to print the values on the console.

`timescale 1ns/1ps

class MyClass;
    // Data members
    bit [31:0] data1;
    bit [31:0] data2;
    bit [31:0] data3;

    // Constructor to initialize data members
    function new();
        data1 = 45;
        data2 = 78;
        data3 = 90;
    endfunction

    function void display();
        $display("data1: %0d, data2: %0d, data3: %0d", data1, data2, data3);
    endfunction
endclass

module testbench;

    MyClass obj;

    initial begin
        // Create an object of MyClass
        obj = new();

        obj.display();

        #100 $finish;
    end

endmodule

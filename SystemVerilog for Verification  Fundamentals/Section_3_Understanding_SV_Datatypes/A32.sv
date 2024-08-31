// ##A32
// Create an array capable of storing 10 elements of an unsigned integer. Initialize all the 10 elements to a value equal 
// to the square of the index of that element. for e.g. first element has index no. 0 so initialize it to 0, the second 
// element has index no. 1 so initialize it to 1, the third element has index no. 2 so initialize it to 4, and so on. 
// Verify the code by sending values of all the elements on Console.

`timescale 1ns/1ps

module array_initialization;

    reg [31:0] arr [0:9];

    initial begin
        // Initialize the array elements to the square of their indices
        integer i;
        for (i = 0; i < 10; i = i + 1) begin
            arr[i] = i * i;
        end

        // Print the values of the array elements
        $display("Array values:");
        for (i = 0; i < 10; i = i + 1) begin
            $display("Index %0d: %0d", i, arr[i]);
        end

        #100 $finish;
    end

endmodule

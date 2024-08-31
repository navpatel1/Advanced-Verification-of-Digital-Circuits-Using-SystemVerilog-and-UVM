// A33
// Create two arrays of reg type capable of storing 15 elements. 
// Use $urandom function to add 15 values to the array. Print the value of all the elements of the array 
// on a single line.

`timescale 1ns/1ps

module array_random_values;

    
    reg [31:0] arr1 [0:14];
    reg [31:0] arr2 [0:14];

    integer i;

    initial begin
        // Populate both arrays with random values
        for (i = 0; i < 15; i = i + 1) begin
            arr1[i] = $urandom;
            arr2[i] = $urandom;
        end

       
        $write("Array 1 values: ");
        for (i = 0; i < 15; i = i + 1) begin
            $write("%0d ", arr1[i]);
        end
        $write("\n");

        
        $write("Array 2 values: ");
        for (i = 0; i < 15; i = i + 1) begin
            $write("%0d ", arr2[i]);
        end
        $write("\n");

        #100 $finish;
    end

endmodule

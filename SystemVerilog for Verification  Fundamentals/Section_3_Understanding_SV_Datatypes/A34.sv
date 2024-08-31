// A34
// Use Dynamic array in Testbench top.

// Questions for this assignment


// Create a dynamic array capable of storing 7 elements. add a value of multiple of 7 starting from 7 in the array (7, 14, 21 ....49). After 20 nsec Update the size of the dynamic array to 20. Keep existing values of the array as it is and update the rest 13 elements to a multiple of 5 starting from 5. Print Value of the dynamic array after updating all the elements.

// Expected result : 7, 14, 21, 28 ..... 49, 5, 10, 15 ..... 65 
// systemVerilog implementation

`timescale 1ns/1ps

module testbench;

    // Declare a dynamic array
    integer dynamic_array[];

    integer i;

    initial begin
        
        dynamic_array = new[7];
        for (i = 0; i < 7; i = i + 1) begin
            dynamic_array[i] = (i + 1) * 7;
        end

        // Print initial values
        $write("Initial values: ");
        for (i = 0; i < 7; i = i + 1) begin
            $write("%0d ", dynamic_array[i]);
        end
        $write("\n");

        // Wait for 20 ns
        #20;

        // Update the size of the dynamic array to 20
        dynamic_array = dynamic_array.new[20];

        // Keep existing values
        for (i = 0; i < 7; i = i + 1) begin
            dynamic_array[i] = (i + 1) * 7;
        end

        // Update the rest of the elements with multiples of 5
        for (i = 7; i < 20; i = i + 1) begin
            dynamic_array[i] = (i - 6) * 5;
        end

        // Print all values after updating
        $write("Updated values: ");
        for (i = 0; i < 20; i = i + 1) begin
            $write("%0d ", dynamic_array[i]);
        end
        $write("\n");

        #100 $finish;
    end

endmodule

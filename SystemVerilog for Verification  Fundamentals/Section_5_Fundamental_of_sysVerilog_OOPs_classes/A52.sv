// A52
// Create a function that will perform the multiplication of the two unsigned integer variables.
// Compare values return by function with the expected result and if both values match send "Test Passed" to Console else send "Test Failed".

`timescale 1ns/1ps

module testbench;

    // Function to multiply two unsigned integers and compare with the expected result
    function void multiply_and_check(input logic [31:0] a, input logic [31:0] b, input logic [31:0] expected_result);
        logic [31:0] result;

        // Perform multiplication
        result = a * b;

        // Compare result with expected result and print the outcome
        if (result == expected_result) begin
            $display("Test Passed: %0d * %0d = %0d", a, b, result);
        end else begin
            $display("Test Failed: %0d * %0d = %0d (Expected: %0d)", a, b, result, expected_result);
        end
    endfunction

    initial begin
        // Test cases
        multiply_and_check(5, 6, 30);  // Should pass
        multiply_and_check(7, 8, 56);  // Should pass
        multiply_and_check(10, 15, 150); // Should pass
        multiply_and_check(4, 3, 10);  // Should fail (expected: 12)
        
        #100 $finish;
    end

endmodule
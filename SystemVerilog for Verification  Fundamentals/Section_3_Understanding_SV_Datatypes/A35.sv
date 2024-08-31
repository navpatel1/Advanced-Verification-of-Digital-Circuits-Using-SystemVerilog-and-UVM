// A35
// Use Queue and Fixed-Size array

// Questions for this assignment
// Create a Fixed-size array capable of storing 20 elements. Add random values to all the 20 elements by using 
// $urandom function. Now add all the elements of the fixed-size array to the Queue in such a way that the first element of the Fixed-size array should be the last element of the Queue. 
// Print all the elements of both fixed-size array and Queue on Console.

module queue_array_example;

    // Fixed-size array
    reg [31:0] fixed_array[19:0];
    // Queue
    queue [31:0] q;

    integer i;

    initial begin
        // Initialize the fixed-size array with random values
        for (i = 0; i < 20; i = i + 1) begin
            fixed_array[i] = $urandom;
        end

        $display("Fixed-size Array Elements:");
        for (i = 0; i < 20; i = i + 1) begin
            $display("fixed_array[%0d] = %0d", i, fixed_array[i]);
        end

        // Add elements to the queue in reverse order
        for (i = 19; i >= 0; i = i - 1) begin
            q.push_back(fixed_array[i]);
        end

        $display("Queue Elements:");
        foreach (q[i]) begin
            $display("q[%0d] = %0d", i, q[i]);
        end
    end

endmodule

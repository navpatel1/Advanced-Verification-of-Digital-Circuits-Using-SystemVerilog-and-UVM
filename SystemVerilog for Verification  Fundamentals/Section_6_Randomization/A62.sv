// A62
// Assume generator class consists of three 8-bit data members (x,y, and z). 
// Write a code to generate 20 random values for all the data members at an interval of 20 ns. 
// Random values for all data members should range from 0 to 50

class Generator;
  bit [7:0] x, y, z;

  function new();
    // Initialize with default values
    x = 8'b0;
    y = 8'b0;
    z = 8'b0;
  endfunction

  // Task to generate random values within the range [0, 50]
  task generate_random_values();
    x = $random % 51;  // Generate a value in the range [0, 50]
    y = $random % 51;  // Generate a value in the range [0, 50]
    z = $random % 51;  // Generate a value in the range [0, 50]
    
    // Ensure values are within range [0, 50]
    x = (x < 0) ? -x : x;
    y = (y < 0) ? -y : y;
    z = (z < 0) ? -z : z;
    x = (x > 50) ? 50 : x;
    y = (y > 50) ? 50 : y;
    z = (z > 50) ? 50 : z;

    $display("x = %0d, y = %0d, z = %0d", x, y, z);
  endtask

endclass

module testbench;
  Generator gen;
  integer i;

  initial begin
    gen = new();
    
    fork
      // Generate random values every 20 ns
      begin
        for (i = 0; i < 20; i++) begin
          #20ns gen.generate_random_values();
        end
      end
    join
  end
endmodule

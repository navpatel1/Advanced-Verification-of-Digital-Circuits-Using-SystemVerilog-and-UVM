// A61
// Assume generator class consists of three 8-bit data members (x,y, and z).
// Write a code to generate 20 random values for all the data members at an interval of 20 ns.

class Generator;
  bit [7:0] x, y, z;

  function new();
    // Initialize with default values
    x = 8'b0;
    y = 8'b0;
    z = 8'b0;
  endfunction

  // Task to generate random values
  task generate_random_values();
    x = $random;
    y = $random;
    z = $random;
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

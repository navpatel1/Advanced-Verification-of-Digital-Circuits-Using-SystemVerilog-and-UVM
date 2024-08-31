// A63
// class generator;
  
//   rand bit [4:0] a;
//   rand bit [5:0] b;
  
 
  
// endclass
 
 
// //////////////////Add constraint and TB top code
// Questions for this assignment
// For the Generator code mentioned in the Instruction tab, expected values for variable a ranges from 0 to 8, variable b ranges from 0 to 5. Also, add logic to store the number of times randomization failed. Print values of variables during each iteration and
//  error count after generating 20 random values for a and b. Add Constraint Code and Testbench top code to  the Design.

class generator;
  
  rand bit [4:0] a;
  rand bit [5:0] b;

  int error_count;
  
  // Constraints for a and b
  constraint range_constraints {
    a inside {[0:8]};
    b inside {[0:5]};
  }

  // Constructor to initialize error count
  function new();
    error_count = 0;
  endfunction

  // Method to attempt randomization and track errors
  function void attempt_randomize();
    if (!randomize()) begin
      error_count++;
      $display("Randomization failed for a: %0d, b: %0d", a, b);
    end else begin
      $display("a: %0d, b: %0d", a, b);
    end
  endfunction

endclass

module tb;
  
  generator g;
  int i;
  
  initial begin
    g = new();
    
    for (i = 0; i < 20; i++) begin
      g.attempt_randomize();
      #10;
    end
    
    $display("Total randomization failures: %0d", g.error_count);
  end
  
endmodule

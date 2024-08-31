//A64
// class generator;
  
//   rand bit rst;
//   rand bit wr;
  
//   /////////////////add constraint 
  
  
  
  
  
// endclass
 
// /////////////////Add testbench top code
// Questions for this assignment
// Take the help of pseudo-random number generator to generate values for wr and rst signal.
// rst should be low for apprx. 30% of time whie wr should be high for apprx. 50% of time. Verify your code for 20 iterations by sending values of both wr and rst on a console.
// Generator code is mentioned in the Instruction tab.

class generator;

  rand bit rst;
  rand bit wr;

  // Constraints to achieve desired probability distributions
  constraint prob_constraints {
    // Ensure rst is low approximately 30% of the time
    (rst == 0) iff ($random % 10 < 3);

    // Ensure wr is high approximately 50% of the time
    (wr == 1) iff ($random % 10 < 5);
  }

endclass

module tb;

  generator g;
  int i;

  initial begin
    g = new();
    
    for (i = 0; i < 20; i++) begin
      g.randomize();
      $display("Iteration %0d: wr = %b, rst = %b", i, g.wr, g.rst);
      #10;
    end

  end

endmodule

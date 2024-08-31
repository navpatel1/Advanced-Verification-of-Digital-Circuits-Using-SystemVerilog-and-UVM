// A65
// Generate values between 0 to 7 for addr signal when wr is high and values between 8 to 15 when wr is low. 
// Generator code is mentioned in the Instruction tab. 
// Verify your code for 20 iterations by sending values of both wr and addr on a console.

class generator;

  rand bit wr;
  rand bit [3:0] addr;

  // Constraints for addr based on the value of wr
  constraint addr_constraints {
    if (wr == 1) 
      addr inside {[0:7]};
    else 
      addr inside {[8:15]};
  }

endclass

module tb;

  generator g;
  int i;

  initial begin
    g = new();
    
    for (i = 0; i < 20; i++) begin
      g.randomize();
      $display("Iteration %0d: wr = %b, addr = %0d", i, g.wr, g.addr);
      #10;
    end

  end

endmodule

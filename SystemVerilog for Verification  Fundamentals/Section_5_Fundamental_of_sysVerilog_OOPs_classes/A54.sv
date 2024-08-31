// A54
// Create a function that generate and return 32 values of multiple of 8 (0, 8, 16, 24, 32, 40 .... 248). 
// Store this value in the local array of the testbench top and also print the
// value of each element of this array on the console.

module testbench;
  
  // Function to generate and return multiples of 8
  function void generate_and_print_multiples_of_8();
    int multiples[31:0];
    int i;
    
    for (i = 0; i < 32; i++) begin
      multiples[i] = i * 8;
      $display("%0d", multiples[i]);
    end
  endfunction
  
  initial begin
    generate_and_print_multiples_of_8();
  end
  
endmodule

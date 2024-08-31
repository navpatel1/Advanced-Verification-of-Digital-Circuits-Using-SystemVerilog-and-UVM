// A57
// Create a deep copy of the Generator class. To verify the deep copy code assign value of the copy method to another 
// instance of the generator class in TB top. Print the value of data members in the generator class as well as copied class. 
// Refer Instruction tab for Generator class code.

class Generator;
  bit [7:0] data1, data2;

  function new(bit [7:0] init_data1, bit [7:0] init_data2);
    data1 = init_data1;
    data2 = init_data2;
  endfunction

  // Deep copy method
  function Generator deep_copy();
    Generator copy;
    copy = new(data1, data2);
    return copy;
  endfunction

  // Method to display values
  function void display();
    $display("data1 = %0d", data1);
    $display("data2 = %0d", data2);
  endfunction

endclass


module testbench;
  initial begin
    Generator gen1 = new(10, 20);
    Generator gen2;
    
    gen2 = gen1.deep_copy();
    
    $display("Original Generator:");
    gen1.display();
    
    $display("Copied Generator:");
    gen2.display();
  end
endmodule

// A55
// Assume the class consists of three 8-bit data members a, b, and c.
// Create a Custom Constructor that allows the user to update the value of these data members while adding a constructor to the class.
// Test your code by adding the value of 2, 4, and 56 to a, b and c respectively.

class MyClass;
  // 8-bit data members
  bit [7:0] a, b, c;

  // Custom constructor
  function new(bit [7:0] init_a, bit [7:0] init_b, bit [7:0] init_c);
    a = init_a;
    b = init_b;
    c = init_c;
  endfunction

  // Method to display the values
  function void display();
    $display("a = %0d", a);
    $display("b = %0d", b);
    $display("c = %0d", c);
  endfunction

endclass

module testbench;
  initial begin
    MyClass obj = new(2, 4, 56);
    obj.display();
  end
endmodule

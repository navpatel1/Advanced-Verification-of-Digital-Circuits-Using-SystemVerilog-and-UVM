// A56
// Assume class consists of three data members a, b, and c each of size 4-bit. 
// Create a task inside the class that returns the result of the addition of data members. 
// The task must also be capable of sending the value of a, b, c, and result to the console. 
// Verify code for a = 1, b = 2, and c = 4.

class MyClass;
  bit [3:0] a, b, c;

  function new(bit [3:0] init_a, bit [3:0] init_b, bit [3:0] init_c);
    a = init_a;
    b = init_b;
    c = init_c;
  endfunction

  task add_and_display();
    bit [4:0] result;
    result = a + b + c;
    $display("a = %0d", a);
    $display("b = %0d", b);
    $display("c = %0d", c);
    $display("result = %0d", result);
  endtask

endclass

module testbench;
  initial begin
    MyClass obj = new(1, 2, 4);
    obj.add_and_display();
  end
endmodule

// Use Automation for sending variable values to console.

// Questions for this assignment
// Create a class "my_object" by extending the UVM_OBJECT class. 
// Add three logic datatype datamembers "a", "b", and "c" with sizes of 2, 4, and 8 respectively. 
// Generate a random value for all the data members and send the values of the variables to the console by using the print method.

`include "uvm_macros.svh"
import uvm_pkg::*; // Import the UVM package

class my_object extends uvm_object;
    // Register the class with the UVM factory and enable utilities
    `uvm_object_utils(my_object)

    // Declare logic data members
    rand logic [1:0] a;  // 2-bit logic variable
    rand logic [3:0] b;  // 4-bit logic variable
    rand logic [7:0] c;  // 8-bit logic variable

    // Constructor
    function new(string name = "my_object");
        super.new(name); // Call the parent class constructor
    endfunction

    // Virtual method to randomize and print data members
    virtual function void do_print(uvm_printer printer);
        super.do_print(printer); // Call the parent class do_print method
        printer.print_field_int("a", a, $bits(a), UVM_BIN); // Print 'a' in binary format
        printer.print_field_int("b", b, $bits(b), UVM_BIN); // Print 'b' in binary format
        printer.print_field_int("c", c, $bits(c), UVM_BIN); // Print 'c' in binary format
    endfunction
endclass

// Top-level module to demonstrate the functionality
module tb;

    initial begin
        // Create an instance of my_object
        my_object obj;
        obj = my_object::type_id::create("obj");

        // Randomize the object's fields
        if (!obj.randomize()) begin
            `uvm_error("RANDOMIZE_FAIL", "Randomization failed for my_object")
        end

        // Print the values of the object's fields to the console
        obj.print();
    end

endmodule

// 1) Create a class "my_object" by extending the UVM_OBJECT class. Add three logic datatype datamembers "a", "b", and "c" with sizes of 2, 4, and 8 respectively.

// 2) Create two objects of my_object class in TB Top. Generate random data for data members of one of the object and then copy the data to other object by using clone method.

// 3) Compare both objects and send the status of comparison to Console using Standard UVM reporting macro. Add User defined implementation for the copy method.

// Questions for this assignment
// Comparing two objects of the class.

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

    // Override the copy method for custom copy behavior
    function void copy(uvm_object rhs);
        my_object rhs_obj;
        // Check if the right-hand side is of type my_object
        if (!$cast(rhs_obj, rhs)) begin
            `uvm_error("COPY_FAIL", "Casting failed in copy method")
            return;
        end
        // Copy values from rhs_obj to this object
        this.a = rhs_obj.a;
        this.b = rhs_obj.b;
        this.c = rhs_obj.c;
    endfunction

    // Method to compare two my_object instances
    function bit compare(my_object rhs_obj, uvm_comparer comparer);
        // Compare the data members of both objects
        if (this.a == rhs_obj.a && this.b == rhs_obj.b && this.c == rhs_obj.c) begin
            return 1; // Return true if all members are equal
        end
        else begin
            return 0; // Return false if any member is different
        end
    endfunction
endclass

// Top-level module to demonstrate the functionality
module tb;

    initial begin
        // Create two instances of my_object
        my_object obj1, obj2;
        obj1 = my_object::type_id::create("obj1");
        obj2 = my_object::type_id::create("obj2");

        // Randomize the first object
        if (!obj1.randomize()) begin
            `uvm_error("RANDOMIZE_FAIL", "Randomization failed for obj1")
        end

        // Use the clone method to copy values from obj1 to obj2
        obj2.copy(obj1);

        // Compare obj1 and obj2, and report the result
        if (obj1.compare(obj2, null)) begin
            `uvm_info("COMPARE_PASS", "obj1 and obj2 are identical", UVM_LOW)
        end
        else begin
            `uvm_info("COMPARE_FAIL", "obj1 and obj2 are not identical", UVM_LOW)
        end
    end

endmodule

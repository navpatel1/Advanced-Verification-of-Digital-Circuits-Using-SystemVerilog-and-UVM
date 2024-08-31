// Write a code to change the verbosity of the entire verification environment to UVM_DEBUG. 
// To demonstrate successful configuration, print the value of the verbosity level on the console.
// Use GET and SET method with UVM_ROOT to configure Verbosity.

// Questions for this assignment
// Change the Verbosity of entire Verification Environment.

// UVM Testbench Example to Change Verbosity Level

`include "uvm_macros.svh"
import uvm_pkg::*;

class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    function new(string name = "my_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Main test phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        // Set the verbosity level of the entire environment to UVM_DEBUG
        uvm_root root;
        root = uvm_root::get();

        root.set_verbosity_level(UVM_DEBUG);

        // Retrieve the current verbosity level to verify the change
        uvm_verbosity current_verbosity;
        current_verbosity = root.get_verbosity_level();

        // Print the current verbosity level
        if (current_verbosity == UVM_DEBUG) begin
            UVM_INFO("VERBOSITY_CHECK", "The verbosity level is successfully set to UVM_DEBUG.", UVM_LOW);
        end else begin
            UVM_INFO("VERBOSITY_CHECK", $sformatf("The verbosity level is not set to UVM_DEBUG, current level: %0d", current_verbosity), UVM_LOW);
        end
    endtask
endclass

// Top-level module to run the test
module top;
    initial begin
        run_test("my_test");
    end
endmodule

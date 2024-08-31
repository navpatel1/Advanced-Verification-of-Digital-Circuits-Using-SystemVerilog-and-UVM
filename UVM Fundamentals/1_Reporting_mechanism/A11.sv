// Use UVM_INFO

// Questions for this assignment
// Send the name of the first RTL that you designed in Verilog.


// Assuming this is part of a UVM component class or testbench

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

        // Use UVM_INFO to print out a message
        UVM_INFO("MY_INFO", "The first RTL I designed in Verilog was a 4-bit adder.", UVM_LOW);
    endtask
endclass

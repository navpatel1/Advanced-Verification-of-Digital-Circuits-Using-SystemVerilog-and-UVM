// Use methods that allows us to change verbosity with ID.

// `include "uvm_macros.svh"
// import uvm_pkg::*;
 
// //////////////////////////////////////////////////
// class component extends uvm_component;
//   `uvm_component_utils(component)
  
//   function new(string path , uvm_component parent);
//     super.new(path, parent);
//   endfunction
 
  
//   task run();
//     `uvm_info("CMP1", "Executed CMP1 Code", UVM_DEBUG);
//     `uvm_info("CMP2", "Executed CMP2 Code", UVM_DEBUG);
//   endtask
  
// endclass
// Questions for this assignment
// Write a TB_TOP Code to send message with ID : CMP1 to console while blocking message with ID : CMP2.
// Do not change Component code.

`include "uvm_macros.svh"
import uvm_pkg::*;

class tb_top extends uvm_test;
    `uvm_component_utils(tb_top)

    function new(string name = "tb_top", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase to instantiate components
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // Create an instance of the component
        component comp_inst;
        comp_inst = component::type_id::create("comp_inst", this);
    endfunction

    // Run phase to set up verbosity filtering and run the test
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        // Set verbosity level for message ID "CMP1" to UVM_DEBUG (to be printed)
        uvm_report_handler::get_report_handler().set_report_verbosity_level_id("CMP1", UVM_DEBUG);

        // Set verbosity level for message ID "CMP2" to UVM_NONE (to block it)
        uvm_report_handler::get_report_handler().set_report_verbosity_level_id("CMP2", UVM_NONE);

        // Run the component's run task
        phase.raise_objection(this);
        uvm_top.run_test();
        phase.drop_objection(this);
    endtask
endclass

// Top-level module to start the simulation
module top;
    initial begin
        run_test("tb_top");
    end
endmodule

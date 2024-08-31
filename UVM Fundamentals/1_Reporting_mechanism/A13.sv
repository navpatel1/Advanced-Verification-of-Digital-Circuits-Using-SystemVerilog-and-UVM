// Override the UVM_WARNING action to make quit_count equal to the number of times UVM_WARNING executes.
//  Write an SV code to send four random messages to a terminal with potential error severity, 
//  Simulation must stop as soon as we reach to quit_count of four. Do not use UVM_INFO, UVM_ERROR, UVM_FATAL, or $finish in the code.

// Questions for this assignment
// Override the UVM_WARNING action

`include "uvm_macros.svh"
import uvm_pkg::*;

class custom_report_handler extends uvm_report_handler;
    int quit_count = 0; // Initialize quit_count

    function new(string name="custom_report_handler");
        super.new(name);
    endfunction

    virtual function void report(uvm_severity severity,
                                 string id,
                                 string message,
                                 integer verbosity,
                                 string filename,
                                 integer line);
        // Override report behavior for UVM_WARNING
        if (severity == UVM_WARNING) begin
            quit_count++;
            if (quit_count >= 4) begin
                // Stop simulation when quit_count reaches 4
                uvm_report_server::get_server().set_max_quit_count(1);
            end
        end

        // Call the parent class report method
        super.report(severity, id, message, verbosity, filename, line);
    endfunction
endclass

class my_test extends uvm_test;
    `uvm_component_utils(my_test)

    function new(string name="my_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        // Create and set a custom report handler
        custom_report_handler handler = new();
        uvm_report_server::get_server().set_report_handler(handler);

        // Send four random messages with potential error severity
        int i;
        for (i = 0; i < 4; i++) begin
            case ($urandom_range(0, 2))
                0: uvm_report(UVM_WARNING, "RAND_WARNING", "Random warning message.");
                1: uvm_report(UVM_ERROR, "RAND_ERROR", "Random error message.");
                2: uvm_report(UVM_FATAL, "RAND_FATAL", "Random fatal message.");
            endcase
        end
    endtask
endclass

module top;
    initial begin
        run_test("my_test");
    end
endmodule

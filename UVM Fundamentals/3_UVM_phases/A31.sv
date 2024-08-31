// Add End of elaboration phase in Driver, Monitor, Environment and Test Class. Driver and Monitor are child to Environment while Environment is child to Test Class. Build Heirarchy and perform execution of the code to verify End of ELaboration phase executes in Bottom-Up fashion. Use template mentioned below.



// `include "uvm_macros.svh"
// import uvm_pkg::*;
 
 
 
 
// ///////////////////////////////////////////////////////////////
 
// class driver extends uvm_driver;
//   `uvm_component_utils(driver) 
  
  
//   function new(string path = "test", uvm_component parent = null);
//     super.new(path, parent);
//   endfunction
  
 
  
// endclass
 
// ///////////////////////////////////////////////////////////////
 
// class monitor extends uvm_monitor;
//   `uvm_component_utils(monitor) 
  
  
//   function new(string path = "monitor", uvm_component parent = null);
//     super.new(path, parent);
//   endfunction
  
 
  
// endclass
 
// ////////////////////////////////////////////////////////////////////////////////////
 
// class env extends uvm_env;
//   `uvm_component_utils(env) 
  
//   driver d;
//   monitor m;
  
//   function new(string path = "env", uvm_component parent = null);
//     super.new(path, parent);
//   endfunction
  
 
// endclass
 
 
 
// ////////////////////////////////////////////////////////////////////////////////////////
 
// class test extends uvm_test;
//   `uvm_component_utils(test)
  
//   env e;
  
//   function new(string path = "test", uvm_component parent = null);
//     super.new(path, parent);
//   endfunction
  
 
  
// endclass
 
// ///////////////////////////////////////////////////////////////////////////
// module tb;
  
//   initial begin
//     run_test("test");
//   end
  
 
// endmodule
// Questions for this assignment
// Demonstrate Start of Elaboration phase executes in Bottom-Up fashion.


`include "uvm_macros.svh"
import uvm_pkg::*;

///////////////////////////////////////////////////////////////

class driver extends uvm_driver;
  `uvm_component_utils(driver) 
  
  function new(string path = "driver", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  // Override the end_of_elaboration_phase method
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("DRIVER", "End of elaboration phase in driver", UVM_LOW)
  endfunction
  
endclass

///////////////////////////////////////////////////////////////

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor) 
  
  function new(string path = "monitor", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  // Override the end_of_elaboration_phase method
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("MONITOR", "End of elaboration phase in monitor", UVM_LOW)
  endfunction
  
endclass

////////////////////////////////////////////////////////////////////////////////////

class env extends uvm_env;
  `uvm_component_utils(env) 
  
  driver d;
  monitor m;
  
  function new(string path = "env", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  // Override the build_phase method to create instances of driver and monitor
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    d = driver::type_id::create("d", this);
    m = monitor::type_id::create("m", this);
  endfunction

  // Override the end_of_elaboration_phase method
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("ENV", "End of elaboration phase in env", UVM_LOW)
  endfunction
  
endclass

////////////////////////////////////////////////////////////////////////////////////////

class test extends uvm_test;
  `uvm_component_utils(test)
  
  env e;
  
  function new(string path = "test", uvm_component parent = null);
    super.new(path, parent);
  endfunction

  // Override the build_phase method to create an instance of env
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e", this);
  endfunction

  // Override the end_of_elaboration_phase method
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info("TEST", "End of elaboration phase in test", UVM_LOW)
  endfunction
  
endclass

///////////////////////////////////////////////////////////////////////////
module tb;
  
  initial begin
    run_test("test");
  end
  
endmodule

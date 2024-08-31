// Questions for this assignment
// Design an environment consisting of a single producer class "PROD" and three subscribers viz., iz.
//  "SUB1", "SUB2", and "SUB3". Add logic such that the producer broadcasts the name of the coder and all 
//  the subscribers are able to receive the string data sent by the producer. If Zen is writing the logic, 
// then the producer should broadcast the string "ZEN" and all the subscribers must receive "ZEN".

class PROD extends uvm_component;
  `uvm_component_utils(PROD)

  // TLM put port for broadcasting messages
  uvm_tlm_analysis_port #(string) broadcast_port;

  function new(string name = "PROD", uvm_component parent = null);
    super.new(name, parent);
    broadcast_port = new("broadcast_port", this);
  endfunction

  // Override the run_phase to broadcast the message
  task run_phase(uvm_phase phase);
    string coder_name = "ZEN";

    // Broadcast the message
    broadcast_port.write(coder_name);
    `uvm_info("PROD", $sformatf("Broadcasted message: %s", coder_name), UVM_LOW)
  endtask

endclass

class SUB1 extends uvm_component;
  `uvm_component_utils(SUB1)

  // TLM put export for receiving messages
  uvm_tlm_analysis_export #(string) receive_export;

  function new(string name = "SUB1", uvm_component parent = null);
    super.new(name, parent);
    receive_export = new("receive_export", this);
  endfunction

  // Handle received message
  function void write(string message);
    `uvm_info("SUB1", $sformatf("Received message: %s", message), UVM_LOW)
  endfunction

endclass

class SUB2 extends uvm_component;
  `uvm_component_utils(SUB2)

  // TLM put export for receiving messages
  uvm_tlm_analysis_export #(string) receive_export;

  function new(string name = "SUB2", uvm_component parent = null);
    super.new(name, parent);
    receive_export = new("receive_export", this);
  endfunction

  // Handle received message
  function void write(string message);
    `uvm_info("SUB2", $sformatf("Received message: %s", message), UVM_LOW)
  endfunction

endclass

class SUB3 extends uvm_component;
  `uvm_component_utils(SUB3)

  // TLM put export for receiving messages
  uvm_tlm_analysis_export #(string) receive_export;

  function new(string name = "SUB3", uvm_component parent = null);
    super.new(name, parent);
    receive_export = new("receive_export", this);
  endfunction

  // Handle received message
  function void write(string message);
    `uvm_info("SUB3", $sformatf("Received message: %s", message), UVM_LOW)
  endfunction

endclass


////TEST BENCH 






class test extends uvm_test;
  `uvm_component_utils(test)

  PROD prod;
  SUB1 sub1;
  SUB2 sub2;
  SUB3 sub3;

  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create instances of PROD and subscribers
    prod = PROD::type_id::create("prod", this);
    sub1 = SUB1::type_id::create("sub1", this);
    sub2 = SUB2::type_id::create("sub2", this);
    sub3 = SUB3::type_id::create("sub3", this);

    // Connect the broadcast port of PROD to the receive exports of the subscribers
    prod.broadcast_port.connect(sub1.receive_export);
    prod.broadcast_port.connect(sub2.receive_export);
    prod.broadcast_port.connect(sub3.receive_export);
  endfunction

endclass

module tb;
  initial begin
    run_test("test");
  end
endmodule

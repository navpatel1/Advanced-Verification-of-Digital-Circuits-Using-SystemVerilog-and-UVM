// Design UVM TB to perform verification of Data flipflop (D-FF). Design code is mentioned in the instruction tab.

`include "uvm_macros.svh"
import uvm_pkg::*;

/////////////////////////////////////////
// D Flip-Flop Module
/////////////////////////////////////////
module dff
  (
    input clk, rst, din,  // din - data input, rst - active high synchronous
    output reg dout        // dout - data output
  );
  
  always @(posedge clk)
    begin
      if (rst == 1'b1) 
        dout <= 1'b0;
      else
        dout <= din;
    end
  
endmodule

/////////////////////////////////////////
// Sequence Item Class
/////////////////////////////////////////
class dff_seq_item extends uvm_sequence_item;
  `uvm_object_utils(dff_seq_item)

  bit clk;
  bit rst;
  bit din;
  bit dout;

  function new(string name = "dff_seq_item");
    super.new(name);
  endfunction

  virtual function void do_print(string prefix = "", uvm_printer printer = null);
    `uvm_print_field(prefix, "clk", clk, printer);
    `uvm_print_field(prefix, "rst", rst, printer);
    `uvm_print_field(prefix, "din", din, printer);
    `uvm_print_field(prefix, "dout", dout, printer);
  endfunction
endclass

/////////////////////////////////////////
// Driver Class
/////////////////////////////////////////
class dff_driver extends uvm_driver #(dff_seq_item);
  `uvm_component_utils(dff_driver)

  // Reference to the DFF module
  virtual dff_if vif;

  function new(string name = "dff_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void run_phase(uvm_phase phase);
    dff_seq_item seq_item;

    // Drive the DFF inputs
    forever begin
      seq_item = get_next_item();
      if (seq_item == null)
        break;

      // Drive the inputs
      vif.clk = seq_item.clk;
      vif.rst = seq_item.rst;
      vif.din = seq_item.din;

      // Sample the inputs
      #1; // Wait time for simulation
      seq_item = null;
      item_done();
    end
  endfunction
endclass

/////////////////////////////////////////
// Monitor Class
/////////////////////////////////////////
class dff_monitor extends uvm_monitor;
  `uvm_component_utils(dff_monitor)

  // Analysis port to send monitored data
  uvm_analysis_port #(dff_seq_item) ap;

  function new(string name = "dff_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void run_phase(uvm_phase phase);
    dff_seq_item item;
    forever begin
      // Monitor the DFF outputs
      #1; // Wait time for simulation

      item = dff_seq_item::new();
      item.dout = vif.dout;
      ap.write(item); // Send to the scoreboard
    end
  endfunction
endclass

/////////////////////////////////////////
// Sequencer Class
/////////////////////////////////////////
class dff_sequencer extends uvm_sequencer #(dff_seq_item);
  `uvm_component_utils(dff_sequencer)

  function new(string name = "dff_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
endclass

/////////////////////////////////////////
// Scoreboard Class
/////////////////////////////////////////
class dff_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(dff_scoreboard)

  function new(string name = "dff_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Function to check output value against expected values
  function void write(dff_seq_item item);
    // Check if dout is correct based on din and rst
    if (item.rst == 1'b1) begin
      if (item.dout != 1'b0)
        `uvm_error("SCOREBOARD", "Output dout should be 0 when rst is 1");
    end else begin
      if (item.dout != item.din)
        `uvm_error("SCOREBOARD", $sformatf("Output dout %b does not match input din %b", item.dout, item.din));
    end
  endfunction
endclass

/////////////////////////////////////////
// Environment Class
/////////////////////////////////////////
class dff_env extends uvm_env;
  `uvm_component_utils(dff_env)

  dff_driver drv;
  dff_monitor mon;
  dff_sequencer seq;
  dff_scoreboard sb;

  function new(string name = "dff_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    drv = dff_driver::type_id::create("drv", this);
    mon = dff_monitor::type_id::create("mon", this);
    seq = dff_sequencer::type_id::create("seq", this);
    sb = dff_scoreboard::type_id::create("sb", this);

    // Connect driver and monitor to the sequencer and scoreboard
    drv.seq_item_port.connect(seq.seq_item_export);
    mon.ap.connect(sb.analysis_export);
  endfunction
endclass

/////////////////////////////////////////
// Test Class
/////////////////////////////////////////
class dff_test extends uvm_test;
  `uvm_component_utils(dff_test)

  dff_env env;

  function new(string name = "dff_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dff_env::type_id::create("env", this);
  endfunction

  function void run_phase(uvm_phase phase);
    super.run_phase(phase);
    // Start sequences
    // Example sequence: configure and start a sequence for testing
  endfunction
endclass

/////////////////////////////////////////
// Testbench Module
/////////////////////////////////////////
module tb;
  // Define the interface for dff module
  interface dff_if;
    logic clk;
    logic rst;
    logic din;
    logic dout;
  endinterface

  // Instantiate the dff module and connect it to the interface
  dff_if dff_if_inst();
  dff dff_inst(
    .clk(dff_if_inst.clk),
    .rst(dff_if_inst.rst),
    .din(dff_if_inst.din),
    .dout(dff_if_inst.dout)
  );

  initial begin
    run_test("dff_test");
  end
endmodule

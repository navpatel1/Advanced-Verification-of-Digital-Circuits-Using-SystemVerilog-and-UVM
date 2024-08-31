class COMPA extends uvm_component;

  `uvm_component_utils(COMPA)

  // TLM put port

  uvm_tlm_export #(transaction) put_port;

  function new(string name = "COMPA", uvm_component parent = null);

    super.new(name, parent);

    put_port = new("put_port", this);

  endfunction

  // Override the run_phase to send transactions

  task run_phase(uvm_phase phase);

    transaction t;

    t = transaction::new("t");

    // Send a transaction

    put_port.put(t);

    `uvm_info("COMPA", "Transaction sent from COMPA", UVM_LOW)

  endtask

endclass

class COMPB extends uvm_component;

  `uvm_component_utils(COMPB)

  // TLM put export

  uvm_tlm_export #(transaction) put_export;

  function new(string name = "COMPB", uvm_component parent = null);

    super.new(name, parent);

    put_export = new("put_export", this);

    put_export.connect(this);

  endfunction

  // TLM callback method to handle the received transaction

  function void write(transaction t);

    `uvm_info("COMPB", $sformatf("Transaction received: a=%0d, b=%0d, c=%0d", t.a, t.b, t.c), UVM_LOW)

  endfunction

endclass


//// TEST BENCH FILE








class COMPA extends uvm_component;

  `uvm_component_utils(COMPA)

  // TLM put port

  uvm_tlm_export #(transaction) put_port;

  function new(string name = "COMPA", uvm_component parent = null);

    super.new(name, parent);

    put_port = new("put_port", this);

  endfunction

  // Override the run_phase to send transactions

  task run_phase(uvm_phase phase);

    transaction t;

    t = transaction::new("t");

    // Send a transaction

    put_port.put(t);

    `uvm_info("COMPA", "Transaction sent from COMPA", UVM_LOW)

  endtask

endclass

class COMPB extends uvm_component;

  `uvm_component_utils(COMPB)

  // TLM put export

  uvm_tlm_export #(transaction) put_export;

  function new(string name = "COMPB", uvm_component parent = null);

    super.new(name, parent);

    put_export = new("put_export", this);

    put_export.connect(this);

  endfunction

  // TLM callback method to handle the received transaction

  function void write(transaction t);

    `uvm_info("COMPB", $sformatf("Transaction received: a=%0d, b=%0d, c=%0d", t.a, t.b, t.c), UVM_LOW)

  endfunction

endclass


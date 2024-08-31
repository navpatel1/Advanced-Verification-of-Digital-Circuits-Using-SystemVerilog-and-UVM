//A82
// Design Code:

// module top
// (
//   input clk,
//   input [3:0] a,b,
//   output reg [7:0] mul
// );
  
//   always@(posedge clk)
//     begin
//      mul <= a * b;
//     end
  
// endmodule


// Interface Code:

// interface top_if;
//   logic clk;
//   logic [3:0] a, b;
//   logic [7:0] mul;
  
// endinterface


// Testbench Top Code:

// module tb;
  
//   top_if vif();
  
//   top dut (vif.clk, vif.a, vif.b, vif.mul);
  
//   initial begin
//     vif.clk <= 0;
//   end
  
//   always #5 vif.clk <= ~vif.clk;
  
//   initial begin
//     for(int i = 0; i<20; i++) begin
//       @(posedge vif.clk);
//       vif.a <= $urandom_range(1,15);
//       vif.b <= $urandom_range(1,15);
//     end
    
//   end
  
//   initial begin
//     $dumpfile("dump.vcd");
//      $dumpvars;    
//     #300;
//     $finish();
//   end
  
// endmodule
// Questions for this assignment
// Create Monitor and Scoreboard Code for Synchronous 4-bit Multiplier. Stimulus is generated in Testbench top so do not add
//  Transaction, Generator, or Driver Code. Also, add the Scoreboard model to compare the response with an expected result.

class monitor;

  virtual top_if vif;  // Virtual interface to access DUT signals
  transaction tx;      // To store captured transactions
  mailbox txn_mbox;    // Mailbox to send transactions to the scoreboard
  
  // Constructor to initialize the virtual interface and mailbox
  function new(virtual top_if vif, mailbox txn_mbox);
    this.vif = vif;
    this.txn_mbox = txn_mbox;
  endfunction

  // Method to capture transactions from the interface
  task capture();
    forever begin
      @(posedge vif.clk);  // Wait for positive edge of the clock
      tx = new();
      tx.a = vif.a;
      tx.b = vif.b;
      tx.expected_mul = vif.a * vif.b;  // Calculate expected result
      tx.actual_mul = vif.mul;          // Capture actual result
      txn_mbox.put(tx);                 // Send transaction to mailbox
    end
  endtask

endclass

class scoreboard;

  mailbox txn_mbox;    // Mailbox to receive transactions
  int error_count = 0; // Counter for mismatches
  
  // Constructor to initialize the mailbox
  function new(mailbox txn_mbox);
    this.txn_mbox = txn_mbox;
  endfunction

  // Method to compare transactions and report mismatches
  task compare();
    transaction tx;
    forever begin
      txn_mbox.get(tx);  // Get transaction from mailbox
      if (tx.actual_mul !== tx.expected_mul) begin
        $display("Error: For a = %0h, b = %0h, Expected mul = %0h, Got mul = %0h", tx.a, tx.b, tx.expected_mul, tx.actual_mul);
        error_count++;
      end else begin
        $display("Match: For a = %0h, b = %0h, mul = %0h", tx.a, tx.b, tx.actual_mul);
      end
    end
  endtask

endclass

module tb;
  
  top_if vif();
  top dut (vif.clk, vif.a, vif.b, vif.mul);
  
  mailbox txn_mbox = new();  // Mailbox for transactions
  monitor mon;               // Monitor instance
  scoreboard sb;             // Scoreboard instance
  
  initial begin
    vif.clk <= 0;
  end
  
  always #5 vif.clk <= ~vif.clk;
  
  // Stimulus generation
  initial begin
    for(int i = 0; i < 20; i++) begin
      @(posedge vif.clk);
      vif.a <= $urandom_range(1, 15);
      vif.b <= $urandom_range(1, 15);
    end
  end

  // Monitor and Scoreboard setup
  initial begin
    mon = new(vif, txn_mbox); // Create monitor
    sb = new(txn_mbox);       // Create scoreboard
    fork
      mon.capture();  // Start capturing in parallel
      sb.compare();   // Start comparison in parallel
    join_none
  end
  
  // Simulation control
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;    
    #300;
    $finish();
  end
  
endmodule

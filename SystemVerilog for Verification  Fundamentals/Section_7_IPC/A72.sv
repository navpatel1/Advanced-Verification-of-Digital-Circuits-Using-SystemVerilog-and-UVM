// A72
// class transaction;
 
// bit [7:0] addr = 7'h12;
// bit [3:0] data = 4'h4;
// bit we = 1'b1;
// bit rst = 1'b0;
 
// endclass
// Questions for this assignment
// Code for transaction class is mentioned in the Instruction tab.
//  Write a code to send transaction data between generator and driver. Also, 
// verify the data by printing the value of data members of Generator and Driver.

class generator;

  // Method to create and send a transaction
  function void send_transaction(driver drv);
    transaction txn;
    
    // Create a transaction with default values
    txn = new();
    txn.addr = 8'hAB;  // Modify addr as needed
    txn.data = 4'h7;   // Modify data as needed
    txn.we = 1'b0;     // Modify we as needed
    txn.rst = 1'b1;    // Modify rst as needed
    
    // Send the transaction to the driver
    drv.receive_transaction(txn);
  endfunction

endclass

class driver;

  // Method to receive and process a transaction
  function void receive_transaction(transaction txn);
    $display("Driver received transaction:");
    $display("Address: %0h", txn.addr);
    $display("Data: %0h", txn.data);
    $display("Write Enable (we): %b", txn.we);
    $display("Reset (rst): %b", txn.rst);
  endfunction

endclass

module tb;

  generator gen;
  driver drv;

  initial begin
    // Instantiate the generator and driver
    gen = new();
    drv = new();

    // Send a transaction from the generator to the driver
    gen.send_transaction(drv);
    
    // End the simulation after a short delay
    #10;
    $finish;
  end

endmodule


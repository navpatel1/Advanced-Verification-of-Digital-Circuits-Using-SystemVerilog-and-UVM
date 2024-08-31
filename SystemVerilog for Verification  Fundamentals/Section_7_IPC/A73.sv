// A73
// Code for transaction class is mentioned in the Instruction tab.
// Write a code to send transaction data between generator and driver. Also, verify the data by printing the value of data members of Generator and Driver in each transaction.
// Execute the code for 10 random transactions.

class transaction;
  
  bit [7:0] addr = 8'h12;
  bit [3:0] data = 4'h4;
  bit we = 1'b1;
  bit rst = 1'b0;

endclass

class generator;

  // Method to create and send a transaction
  function void send_random_transaction(driver drv);
    transaction txn;
    
    // Create a new transaction
    txn = new();
    
    // Randomize the transaction fields
    if (!txn.randomize()) begin
      $display("Randomization failed");
      return;
    end
    
    // Send the transaction to the driver
    drv.receive_transaction(txn);
    
    // Print transaction values
    $display("Generator created transaction:");
    $display("Address: %0h", txn.addr);
    $display("Data: %0h", txn.data);
    $display("Write Enable (we): %b", txn.we);
    $display("Reset (rst): %b", txn.rst);
  endfunction

endclass

class driver;

  // Method to receive and process a transaction
  function void receive_transaction(transaction txn);
    // Print received transaction values
    $display("Driver received transaction:");
    $display("Address: %0h", txn.addr);
    $display("Data: %0h", txn.data);
    $display("Write Enable (we): %b", txn.we);
    $display("Reset (rst): %b", txn.rst);
  endfunction

endclass

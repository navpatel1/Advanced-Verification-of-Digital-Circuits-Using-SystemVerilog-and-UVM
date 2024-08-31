//A21

// Add two tasks in the driver code

// 1) write_till_full : this will perfrom series of write operation on FIFO till full flag is set

// 2) read_till_empty: this will perform series of read operations till empty flag is set.

// In the main task of driver call these two task in sequence

// class driver;
// .................
// ................
 
//  task run();
//     forever
//     begin
//     write_till_full();
//     read_till_empty();
//     end
//   endtask
// ...............
// ...............
// endclass


// Update Driver code to handle these transaction. Expected Test cases should show following behavior.

class driver;
  
  virtual fifo_if fif;     // Virtual interface to the FIFO
  mailbox #(transaction) mbx;  // Mailbox for communication
  transaction datac;       // Transaction object for communication
  
  function new(mailbox #(transaction) mbx);
    this.mbx = mbx;
  endfunction; 
 
  // Reset the DUT
  task reset();
    fif.rst <= 1'b1;
    fif.rd <= 1'b0;
    fif.wr <= 1'b0;
    fif.data_in <= 0;
    repeat (5) @(posedge fif.clock);
    fif.rst <= 1'b0;
    $display("[DRV] : DUT Reset Done");
    $display("------------------------------------------");
  endtask
   
  // Write data to the FIFO
  task write();
    @(posedge fif.clock);
    fif.rst <= 1'b0;
    fif.rd <= 1'b0;
    fif.wr <= 1'b1;
    fif.data_in <= $urandom_range(1, 10);
    @(posedge fif.clock);
    fif.wr <= 1'b0;
    $display("[DRV] : DATA WRITE  data : %0d", fif.data_in);  
    @(posedge fif.clock);
  endtask
  
  // Read data from the FIFO
  task read();  
    @(posedge fif.clock);
    fif.rst <= 1'b0;
    fif.rd <= 1'b1;
    fif.wr <= 1'b0;
    @(posedge fif.clock);
    fif.rd <= 1'b0;      
    $display("[DRV] : DATA READ");  
    @(posedge fif.clock);
  endtask
  
  // Write until FIFO is full
  task write_till_full();
    while (fif.full == 1'b0) begin
      write();
    end
    $display("[DRV] : FIFO is full");
  endtask
  
  // Read until FIFO is empty
  task read_till_empty();
    while (fif.empty == 1'b0) begin
      read();
    end
    $display("[DRV] : FIFO is empty");
  endtask
  
  // Apply random stimulus to the DUT
  task run();
    forever begin
      write_till_full();  // Write until FIFO is full
      read_till_empty();  // Read until FIFO is empty
    end
  endtask
  
endclass

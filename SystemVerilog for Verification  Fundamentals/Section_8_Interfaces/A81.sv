// A81
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
// Questions for this assignment
// Create Transaction, Generator and Driver code for Synchronus 4-bit Multiplier.

class transaction;

  bit [3:0] a;
  bit [3:0] b;
  bit [7:0] expected_mul;

  // Constructor to initialize the transaction
  function new(bit [3:0] a_in, bit [3:0] b_in, bit [7:0] mul_in);
    a = a_in;
    b = b_in;
    expected_mul = mul_in;
  endfunction

endclass

class generator;

  // Method to create and send a random transaction
  function void send_random_transaction(driver drv);
    transaction txn;
    bit [3:0] a, b;
    bit [7:0] expected_mul;

    // Generate random input values
    a = $random % 16; // Random value between 0 and 15
    b = $random % 16; // Random value between 0 and 15
    expected_mul = a * b; // Calculate expected result

    // Create a new transaction
    txn = new(a, b, expected_mul);

    // Send the transaction to the driver
    drv.receive_transaction(txn);
  endfunction

endclass

class driver;

  top uut;  // Instance of the Unit Under Test (UUT)
  transaction txn;

  // Method to receive a transaction and drive the UUT
  function void receive_transaction(transaction tx);
    txn = tx;
    
    // Drive the inputs to the UUT
    uut.a = txn.a;
    uut.b = txn.b;
    
    // Wait for the multiplication result to stabilize
    #10; // Wait for one clock cycle (assuming clock period is 10 ns)
    
    // Check if the output matches the expected multiplication result
    if (uut.mul !== txn.expected_mul) begin
      $display("Error: For a = %0h, b = %0h, Expected mul = %0h, Got mul = %0h", txn.a, txn.b, txn.expected_mul, uut.mul);
    end else begin
      $display("Success: For a = %0h, b = %0h, mul = %0h", txn.a, txn.b, uut.mul);
    end
  endfunction

endclass

module tb;

  reg clk;
  generator gen;
  driver drv;

  // Clock generation
  always #5 clk = ~clk; // 10 ns clock period

  initial begin
    // Initialize signals
    clk = 0;

    // Instantiate the UUT and classes
    top uut (
      .clk(clk),
      .a(4'b0),  // Initial values
      .b(4'b0),
      .mul()
    );

    gen = new();
    drv = new();

    drv.uut = uut;  // Connect driver to UUT

    // Generate and send 10 random transactions
    repeat (10) begin
      gen.send_random_transaction(drv);
      #20; // Wait time between transactions
    end

    // End the simulation
    #10;
    $finish;
  end

endmodule


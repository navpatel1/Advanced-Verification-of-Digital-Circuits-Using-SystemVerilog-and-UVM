`timescale 1ns / 1ps
 
 
module uarttx
#(
parameter clk_freq = 1000000,
parameter baud_rate = 9600
)
(
input clk,rst,
input newd,
input [7:0] tx_data,
output reg tx,
output reg donetx
);
 
  localparam clkcount = (clk_freq/baud_rate); ///x
  
integer count = 0;
integer counts = 0;
 
reg uclk = 0;
  
enum bit[1:0] {idle = 2'b00, start = 2'b01, transfer = 2'b10, send_parity = 2'b11} state;
 
 ///////////uart_clock_gen
  always@(posedge clk)
    begin
      if(count < clkcount/2)
        count <= count + 1;
      else begin
        count <= 0;
        uclk <= ~uclk;
      end 
    end
  
  
  reg [7:0] din;
  reg parity = 0; /// store odd parity
  ////////////////////Reset decoder
  
  
  always@(posedge uclk)
    begin
      if(rst) 
      begin
        state <= idle;
      end
     else
     begin
     case(state)
     
     //////detect new data and start transmission
       idle:
         begin
           counts <= 0;
           tx <= 1'b1;
           donetx <= 1'b0;
           
           if(newd) 
           begin
             state <= transfer;
             din <= tx_data;
             tx <= 1'b0; 
             parity <= ~^tx_data; 
           end
           else
             state <= idle;       
         end
       
 
      ///// wait till transmission of data is completed
      transfer: begin 
          
        if(counts <= 7) 
        begin
           counts <= counts + 1;
           tx     <= din[counts];
           state  <= transfer;
        end
        else 
        begin
           counts <= 0;
           tx     <= parity;
           state  <= send_parity;
        end
      end
      
      ////send parity and move to idle
      send_parity: 
      begin
      tx     <= 1'b1;
      state  <= idle;
      donetx <= 1'b1;
      end
      
      default : state <= idle;
      
    endcase
  end
end
 
endmodule
 
 
 


Verilog TB:

module uart_tb;
reg clk = 0,rst = 0;
reg newd;
reg [7:0] tx_data;
wire tx;
wire donetx;
 
uarttx #(1000000, 9600) dut (clk, rst, newd, tx_data, tx, donetx);
  
always #5 clk = ~clk;  
 
reg [7:0] data_tx;
 
initial 
begin
    rst = 1;
    repeat(5) @(posedge clk);
    rst = 0;
 
        for(int i = 0 ; i < 10; i++)
        begin
        rst = 0;
        newd = 1;
        tx_data = $urandom();
        
        wait(tx == 0);
        @(posedge dut.uclk);
        
            for(int j = 0; j < 8; j++)
            begin
            @(posedge dut.uclk);
            data_tx = {tx,data_tx[7:1]};
            end
            
        @(posedge donetx);
        
        end
 
 
end
 
 
endmodule
// Questions for this assignment
// Modify the Testbench environment used for the verification of UART to test the operation of 
// the UART transmitter with PARITY and STOP BIT. Add logic in scoreboard to verify that the data on 
// TX pin matches the random 8-bit data applied on the DIN bus by the user.Parity is always enabled and odd type. (9600 - 8 - O - 1)

module uart_tb;
  reg clk = 0, rst = 0;
  reg newd;
  reg [7:0] tx_data;
  wire tx;
  wire donetx;

  // Instantiate the UART transmitter
  uarttx #(1000000, 9600) dut (clk, rst, newd, tx_data, tx, donetx);

  // Clock generation
  always #5 clk = ~clk;

  // Variables for data verification
  reg [7:0] data_tx;
  reg expected_parity;
  reg received_parity;
  reg [7:0] received_data;
  integer i;

  // Generate and apply test stimulus
  initial begin
    // Apply reset
    rst = 1;
    repeat (5) @(posedge clk);
    rst = 0;

    // Apply test cases
    for (i = 0; i < 10; i = i + 1) begin
      newd = 1;
      tx_data = $urandom();
      expected_parity = ~^tx_data; // Calculate expected odd parity

      // Wait for transmission start
      wait(tx == 0);
      @(posedge dut.uclk); // Wait for the start bit

      // Capture the transmitted data bits
      received_data = 8'b0;
      for (int j = 0; j < 8; j = j + 1) begin
        @(posedge dut.uclk);
        received_data = {tx, received_data[7:1]};
      end

      // Capture the parity bit
      @(posedge dut.uclk);
      received_parity = tx;

      // Capture the stop bit
      @(posedge dut.uclk);
      if (tx !== 1'b1) begin
        $error("Stop bit error: Expected 1, Got %b", tx);
      end

      // Check the results
      if (received_data !== tx_data) begin
        $error("Data mismatch: Expected %0h, Got %0h", tx_data, received_data);
      end else begin
        $display("Data match: %0h", received_data);
      end

      if (received_parity !== expected_parity) begin
        $error("Parity mismatch: Expected %b, Got %b", expected_parity, received_parity);
      end else begin
        $display("Parity match: %b", received_parity);
      end

      // Wait for done signal
      @(posedge donetx);
      newd = 0;
    end

    $stop; // End of test
  end

  // Dump waveforms for analysis
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, uart_tb);
  end

endmodule

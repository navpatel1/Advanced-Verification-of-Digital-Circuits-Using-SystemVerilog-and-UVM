// Create a testbench environment for validating the SPI interface's ability to transmit data serially immediately when
// the CS signal goes low. Utilize the negative edge of the SCLK to sample the MOSI signal in order to generate 
// reference data. Codes are added in Instruction tab

module tb;
  
  // Testbench Signals
  reg clk = 0, rst = 0, newd = 0;
  reg [11:0] din = 0;
  wire sclk, cs, mosi;
  reg [11:0] mosi_out;
  reg [11:0] expected_data;
  
  // Instantiate the SPI Master
  spi_master dut (
    .clk(clk),
    .newd(newd),
    .rst(rst),
    .din(din),
    .sclk(sclk),
    .cs(cs),
    .mosi(mosi)
  );

  // Clock Generation
  always #10 clk = ~clk;

  // SPI Master Test Sequence
  initial begin
    // Initialize Signals
    rst = 1;
    newd = 0;
    din = 12'h000; // Set initial data value
    
    // Release Reset
    #20;
    rst = 0;

    // Test Case 1: Transmit Data when CS is Low
    // Apply random data and activate newd
    din = $urandom % 12'hFFF; // Random 12-bit data
    $display("Transmitting data: %0h", din);
    expected_data = din; // Store the data to compare later
    newd = 1;
    #20;
    newd = 0;

    // Wait for transmission to complete
    wait(dut.state == 2'b00); // Wait until state returns to idle

    // Check the transmitted data
    #20;
    check_transmission(expected_data);
    
    // Finish simulation
    #2500;
    $stop;
  end

  // Task to check the transmission
  task check_transmission(input [11:0] expected);
    reg [11:0] received_data;
    integer i;
    begin
      received_data = 12'b0;
      for (i = 0; i < 12; i = i + 1) begin
        @(negedge sclk);
        received_data = {mosi, received_data[11:1]};
      end
      if (received_data == expected) begin
        $display("Transmission successful: %0h", received_data);
      end else begin
        $error("Transmission failed. Expected: %0h, Got: %0h", expected, received_data);
      end
    end
  endtask

  // Dumping for waveform viewing
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule



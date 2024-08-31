module tb_axilite_s;
 
  // Testbench signals
  reg         tb_s_axi_aclk    = 0;
  reg         tb_s_axi_aresetn = 0;
  reg         tb_s_axi_awvalid = 0;
  wire        tb_s_axi_awready;
  reg [31:0]  tb_s_axi_awaddr  = 0;
 
  reg         tb_s_axi_wvalid  = 0;
  wire        tb_s_axi_wready;
  reg [31:0]  tb_s_axi_wdata   = 0;
 
  wire        tb_s_axi_bvalid;
  reg         tb_s_axi_bready  = 0;
  wire [1:0]  tb_s_axi_bresp;
 
  reg         tb_s_axi_arvalid = 0;
  wire        tb_s_axi_arready;
  reg [31:0]  tb_s_axi_araddr  = 0;
 
  wire        tb_s_axi_rvalid;
  reg         tb_s_axi_rready  = 0;
  wire [31:0] tb_s_axi_rdata;
  wire [1:0]  tb_s_axi_rresp;
 
  // Instantiate the DUT
  axilite_s uut (
    .s_axi_aclk(tb_s_axi_aclk),
    .s_axi_aresetn(tb_s_axi_aresetn),
    .s_axi_awvalid(tb_s_axi_awvalid),
    .s_axi_awready(tb_s_axi_awready),
    .s_axi_awaddr(tb_s_axi_awaddr),
    .s_axi_wvalid(tb_s_axi_wvalid),
    .s_axi_wready(tb_s_axi_wready),
    .s_axi_wdata(tb_s_axi_wdata),
    .s_axi_bvalid(tb_s_axi_bvalid),
    .s_axi_bready(tb_s_axi_bready),
    .s_axi_bresp(tb_s_axi_bresp),
    .s_axi_arvalid(tb_s_axi_arvalid),
    .s_axi_arready(tb_s_axi_arready),
    .s_axi_araddr(tb_s_axi_araddr),
    .s_axi_rvalid(tb_s_axi_rvalid),
    .s_axi_rready(tb_s_axi_rready),
    .s_axi_rdata(tb_s_axi_rdata),
    .s_axi_rresp(tb_s_axi_rresp)
  );
 
  // Generate clock signal
  initial begin
    tb_s_axi_aclk = 0;
    forever #5 tb_s_axi_aclk = ~tb_s_axi_aclk; // 100 MHz clock
  end
 
  // Test stimulus
  initial begin
    // Initialize signal
    tb_s_axi_aresetn = 0;
    // Reset the design
    repeat(5) @(posedge tb_s_axi_aclk);
    tb_s_axi_aresetn = 1;
    
    // Write transaction
    repeat(2) @(posedge tb_s_axi_aclk);
    tb_s_axi_awvalid = 1;
    tb_s_axi_awaddr = 32'h87;
    @(negedge tb_s_axi_awready);
    tb_s_axi_awvalid = 0;
 
     repeat(2) @(posedge tb_s_axi_aclk);
    tb_s_axi_wvalid = 1;
    tb_s_axi_wdata = 32'hC0DECAFE;
    @(negedge tb_s_axi_wready);
    tb_s_axi_wvalid = 0;
 
    // Write response ready
    repeat(2) @(posedge tb_s_axi_aclk);
    tb_s_axi_bready = 1;
    @(negedge tb_s_axi_bvalid);
   // @(posedge tb_s_axi_aclk);
    tb_s_axi_bready = 0;
 
    // Read transaction
    repeat(2) @(posedge tb_s_axi_aclk);
    tb_s_axi_arvalid = 1;
    tb_s_axi_araddr = 32'h87;
    @(negedge tb_s_axi_arready);
    tb_s_axi_arvalid = 0;
 
    // Read data ready
     @(posedge tb_s_axi_aclk);
     tb_s_axi_rready = 1;
    @(negedge tb_s_axi_rvalid);
    tb_s_axi_rready = 0;
 
    // End of test
    #100;
    $stop;
  end
 
endmodule
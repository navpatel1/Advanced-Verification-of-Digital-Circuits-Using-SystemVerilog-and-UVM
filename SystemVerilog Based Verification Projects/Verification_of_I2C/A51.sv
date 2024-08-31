// "Revise the Testbench environment to actively trigger the generation of 'ack_err'
//  and make the necessary adjustments to the monitor and scoreboard to handle this change.
//   Additionally, configure the system to display a 'ACK_ERR detected' notification on the console whenever 'ack_err' goes high."


/////////////////////////Transaction
class transaction;
  
  bit newd;
  rand bit op;
  rand bit [7:0] din;
  rand bit [6:0] addr;
  bit [7:0] dout;
  bit done;
  bit busy;
  bit ack_err;
  
  constraint addr_c { addr > 1; addr < 5; din > 1; din < 10; }
  
  
  constraint rd_wr_c {
    op dist {1 :/ 50 ,  0 :/ 50};
  }
  
  
endclass
 
/////////////////////////Generator
/// Updated Generator

class generator;
  
  transaction tr;
  mailbox #(transaction) mbxgd;
  event done; // gen completed sending requested number of transactions
  event drvnext; // driver completes its work
  event sconext; // scoreboard completes its work
  
  int count = 0;
  
  function new(mailbox #(transaction) mbxgd);
    this.mbxgd = mbxgd;   
    tr = new();
  endfunction
  
  task run();
    repeat(count) begin
      assert(tr.randomize()) else $error("Randomization Failed");
      // Optionally set ack_err to true in some conditions
      tr.ack_err = (random() % 2 == 0); // Example of random error trigger
      mbxgd.put(tr);
      $display("[GEN]: op :%0d, addr : %0d, din : %0d, ack_err : %0d", 
               tr.op, tr.addr, tr.din, tr.ack_err);
      @(drvnext);
      @(sconext);
    end
    -> done;
  endtask

endclass

 
 
///////////////////////////////Driver
 
 
class driver;
  
  virtual i2c_if vif;
  
  transaction tr;
  
  event drvnext;
  
  mailbox #(transaction) mbxgd;
 
  
  function new( mailbox #(transaction) mbxgd );
    this.mbxgd = mbxgd; 
  endfunction
  
  //////////////////Resetting System
  task reset();
    vif.rst <= 1'b1;
    vif.newd <= 1'b0;
    vif.op <= 1'b0;
    vif.din <= 0;
    vif.addr  <= 0;
    repeat(10) @(posedge vif.clk);
    vif.rst <= 1'b0;
    $display("[DRV] : RESET DONE"); 
    $display("---------------------------------"); 
  endtask
  
  task write();
  vif.rst <= 1'b0;
  vif.newd <= 1'b1;
  vif.op <= 1'b0;
  vif.din <= tr.din;
  vif.addr <= tr.addr;
  repeat(5) @(posedge vif.clk);
  vif.newd <= 1'b0;
  @(posedge vif.done);
  if (vif.ack_err) begin
    $display("[DRV] : ACK_ERR DETECTED during WRITE");
  end else begin
    $display("[DRV] : OP: WR, ADDR:%0d, DIN : %0d", tr.addr, tr.din);
  end
  vif.newd <= 1'b0;
endtask

task read();
  vif.rst <= 1'b0;
  vif.newd <= 1'b1;
  vif.op <= 1'b1;
  vif.din <= 0;
  vif.addr <= tr.addr;
  repeat(5) @(posedge vif.clk);
  vif.newd <= 1'b0;
  @(posedge vif.done);
  if (vif.ack_err) begin
    $display("[DRV] : ACK_ERR DETECTED during READ");
  end else begin
    $display("[DRV] : OP: RD, ADDR:%0d, DOUT : %0d", tr.addr, vif.dout);
  end
endtask

  
  task run();
    tr = new();
    forever begin
      
      mbxgd.get(tr);
      
     if(tr.op == 1'b0)
       write();
      else
       read();
      
      ->drvnext;
    end
  endtask
  
    
  
endclass
 
 
 
/////////////////////////////////////
 
 
/* module tb;
   
  generator gen;
  driver drv;
  event next;
  event done;
  
  mailbox #(transaction) mbxgd;
  
  i2c_if vif();
  i2c_top dut (vif.clk, vif.rst,  vif.newd, vif.wr, vif.wdata, vif.addr, vif.rdata, vif.done);
 
  initial begin
    vif.clk <= 0;
  end
  
  always #5 vif.clk <= ~vif.clk;
  
  initial begin
 
    mbxgd = new();
    gen = new(mbxgd);
    drv = new(mbxgd);
    gen.count = 10;
    drv.vif = vif;
    
    drv.drvnext = next;
    gen.drvnext = next;
    
  end
  
  initial begin
    fork
      drv.reset();
      gen.run();
      drv.run();
    join_none  
    wait(gen.done.triggered);
    $finish();
  end
   
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;   
  end
 
   assign vif.sclk_ref = dut.e1.sclk_ref;
   
  
endmodule
 
*/
 
//////////////////////////////////////monitor
 
 
class monitor;
    
  virtual i2c_if vif; 
  transaction tr;
  mailbox #(transaction) mbxms;
 
 
  
 
  
  function new( mailbox #(transaction) mbxms );
    this.mbxms = mbxms;
  endfunction
  
  task run();
  tr = new();
  forever begin
    @(posedge vif.done);
    tr.din = vif.din;
    tr.addr = vif.addr;
    tr.op = vif.op;
    tr.dout = vif.dout;
    tr.ack_err = vif.ack_err;
    repeat(5) @(posedge vif.clk);
    mbxms.put(tr); 
    $display("[MON] op:%0d, addr: %0d, din : %0d, dout:%0d, ack_err:%0d", 
             tr.op, tr.addr, tr.din, tr.dout, tr.ack_err);
  end
endtask

  
endclass
///////////////////////////////////////////////////////////////
 
class scoreboard;
  
  transaction tr;
  
  mailbox #(transaction) mbxms;
  
  event sconext;
  
  bit [7:0] temp;  
  bit [7:0] mem[128] = '{default:0};
  
 
  
  function new( mailbox #(transaction) mbxms );
    this.mbxms = mbxms;
    
    for(int i = 0; i < 128; i++)
     begin
     mem[i] <= i;
     end
     
  endfunction
  
  
  task run();
  forever begin
    mbxms.get(tr);
    if (tr.ack_err) begin
      $display("[SCO] : ACK_ERR DETECTED for ADDR : %0d", tr.addr);
      $display("[SCO] : Operation failed or error occurred.");
    end else begin
      temp = mem[tr.addr];
      if (tr.op == 1'b0) begin   
        mem[tr.addr] = tr.din;
        $display("[SCO]: DATA STORED -> ADDR : %0d DATA : %0d", tr.addr, tr.din);
      end else begin
        if (tr.dout == temp) begin
          $display("[SCO] : DATA READ -> Data Matched exp: %0d rec:%0d", temp, tr.dout);
        end else begin
          $display("[SCO] : DATA READ -> DATA MISMATCHED exp: %0d rec:%0d", temp, tr.dout);
        end
      end
    end
    ->sconext;
  end
endtask

endclass
 
 

module tb;
   
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  event nextgd;
  event nextgs;
  
  mailbox #(transaction) mbxgd, mbxms;
  i2c_if vif();
  
  i2c_top dut (vif.clk, vif.rst, vif.newd, vif.op, vif.addr, vif.din, vif.dout, vif.busy, vif.ack_err, vif.done);
 
  initial begin
    vif.clk <= 0;
  end
  
  always #5 vif.clk <= ~vif.clk;
  
  initial begin
    mbxgd = new();
    mbxms = new();
    
    gen = new(mbxgd);
    drv = new(mbxgd);
    mon = new(mbxms);
    sco = new(mbxms);
    
    gen.count = 20;
  
    drv.vif = vif;
    mon.vif = vif;
    
    gen.drvnext = nextgd;
    drv.drvnext = nextgd;
    
    gen.sconext = nextgs;
    sco.sconext = nextgs;
  end
  
  task pre_test;
    drv.reset();
  endtask
  
  task test;
    fork
      gen.run();
      drv.run();
      mon.run();
      sco.run();
    join_any  
  endtask
  
  task post_test;
    wait(gen.done.triggered);
    $finish();    
  endtask
  
  task run();
    pre_test;
    test;
    post_test;
  endtask
  
  initial begin
    run();
  end
   
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();   
  end
   
endmodule

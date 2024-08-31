class transaction;
  
  randc bit        op;
  rand bit [31:0] awaddr;
  rand bit [31:0] wdata;
  rand bit [31:0] araddr;
       bit [31:0] rdata;
       bit [1:0]  wresp;
       bit [1:0]  rresp;
  
  constraint valid_addr_range {awaddr == 1; araddr == 1;}
  constraint valid_data_range {wdata < 12; rdata < 12;}
 
  
endclass
 
 
 
//////////////////////////////////
class generator;
  
  transaction tr;
  mailbox #(transaction) mbxgd;
  
  event done; ///gen completed sending requested no. of transaction
  event sconext; ///scoreboard complete its work
 
   int count = 0;
  
  function new( mailbox #(transaction) mbxgd);
    this.mbxgd = mbxgd;   
    tr =new();
  endfunction
  
    task run();
    for(int i=0; i < count; i++) 
    begin
      assert(tr.randomize) else $error("Randomization Failed");
      $display("[GEN] : OP : %0b awaddr : %0d wdata : %0d araddr : %0d",tr.op, tr.awaddr, tr.wdata, tr.araddr);
      mbxgd.put(tr);
      @(sconext);
    end
    ->done;
  endtask
  
   
endclass
 
 
/////////////////////////////////////
 
 
class driver;
  
  virtual axi_if vif;
  
  transaction tr;
  
  
  mailbox #(transaction) mbxgd;
  mailbox #(transaction) mbxdm;
 
  
  function new( mailbox #(transaction) mbxgd,  mailbox #(transaction) mbxdm);
    this.mbxgd = mbxgd; 
    this.mbxdm = mbxdm;
  endfunction
  
  //////////////////Resetting System
  task reset();
    
     vif.resetn  <= 1'b0; 
     vif.awvalid <= 1'b0;
     vif.awaddr  <= 0; 
     vif.wvalid <= 0;
     vif.wdata <= 0;
     vif.bready <= 0;  
     vif.arvalid <= 1'b0;
     vif.araddr <= 0;
    repeat(5) @(posedge vif.clk);
     vif.resetn <= 1'b1;
    
    $display("-----------------[DRV] : RESET DONE-----------------------------"); 
  endtask
  
  
   task write_data(input transaction tr);
     $display("[DRV] : OP : %0b awaddr : %0d wdata : %0d ",tr.op, tr.awaddr, tr.wdata);
      mbxdm.put(tr);
      vif.resetn  <= 1'b1;
      vif.awvalid <= 1'b1;
      vif.arvalid <= 1'b0;  ////disable read
      vif.araddr  <= 0;
      vif.awaddr  <= tr.awaddr;
      @(negedge vif.awready);
      vif.awvalid <= 1'b0;
      vif.awaddr  <= 0;
      vif.wvalid  <= 1'b1;
      vif.wdata   <= tr.wdata;
      @(negedge vif.wready);
      vif.wvalid  <= 1'b0;
      vif.wdata   <= 0;
      vif.bready  <= 1'b1;
      vif.rready  <= 1'b0;
      @(negedge vif.bvalid);
      vif.bready  <= 1'b0;
   endtask
     
     
   task read_data(input transaction tr);
     $display("[DRV] : OP : %0b araddr : %0d ",tr.op, tr.araddr);
      mbxdm.put(tr);
      vif.resetn  <= 1'b1;
      vif.awvalid <= 1'b0;
      vif.awaddr  <= 0;
      vif.wvalid  <= 1'b0;
      vif.wdata   <= 0;
      vif.bready  <= 1'b0;
      vif.arvalid <= 1'b1;  
      vif.araddr  <= tr.araddr;
      @(negedge vif.arready);
      vif.araddr  <= 0;
      vif.arvalid <= 1'b0;
      vif.rready  <= 1'b1;
      @(negedge vif.rvalid);
      vif.rready  <= 1'b0;
   endtask
 
  
 
  
  task run();
    
    forever 
    begin        
      mbxgd.get(tr);
      @(posedge vif.clk);     
     /////////////////////////write mode check and sig gen 
      if(tr.op == 1'b1) 
        write_data(tr);    
      else
        read_data(tr);    
    end
 
  endtask
  
    
  
endclass
///////////////////////////////////////////////////////
 
 
class monitor;
    
  virtual axi_if vif; 
  transaction tr,trd;
  mailbox #(transaction) mbxms;
  mailbox #(transaction) mbxdm;
 
 
  function new( mailbox #(transaction) mbxms , mailbox #(transaction) mbxdm);
    this.mbxms = mbxms;
    this.mbxdm = mbxdm;
  endfunction
  
  
  task run();
    
    tr = new();
    
    forever 
      begin 
        
      @(posedge vif.clk);
        mbxdm.get(trd);
        
        if(trd.op == 1)
          begin
            
            tr.op     = trd.op;
            tr.awaddr = trd.awaddr;
            tr.wdata  = trd.wdata;
            @(posedge vif.bvalid);
            tr.wresp  = vif.wresp;
            @(negedge vif.bvalid);
            $display("[MON] : OP : %0b awaddr : %0d wdata : %0d wresp:%0d",tr.op, tr.awaddr, tr.wdata, tr.wresp);
            mbxms.put(tr); 
          end
        else 
          begin
            tr.op = trd.op;
            tr.araddr = trd.araddr;
            @(posedge vif.rvalid);
            tr.rdata = vif.rdata;
            tr.rresp = vif.rresp;
            @(negedge vif.rvalid);
            $display("[MON] : OP : %0b araddr : %0d rdata : %0d rresp:%0d",tr.op, tr.araddr, tr.rdata, tr.rresp);
            mbxms.put(tr); 
          end
    
      end 
  endtask
 
  
  
endclass
 
///////////////////////////////////////
 
 
class scoreboard;
  
  transaction tr,trd;
  event sconext;
 
  
  mailbox #(transaction) mbxms;
 
 
  
  bit [31:0] temp;
  bit [31:0] data[128] = '{default:0};
 
  
 
  
  function new( mailbox #(transaction) mbxms);
    this.mbxms = mbxms;
  endfunction
  
  
  task run();
    
    forever 
      begin  
        
      mbxms.get(tr);
      
        if(tr.op == 1)
              begin
                $display("[SCO] : OP : %0b awaddr : %0d wdata : %0d wresp : %0d",tr.op, tr.awaddr, tr.wdata, tr.wresp);
                if(tr.wresp == 3)
                $display("[SCO] : DEC ERROR");  
                else begin
                data[tr.awaddr] = tr.wdata;
                $display("[SCO] : DATA STORED ADDR :%0d and DATA :%0d", tr.awaddr, tr.wdata);
                end
              end
            else
              begin
                $display("[SCO] : OP : %0b araddr : %0d rdata : %0d rresp : %0d",tr.op, tr.araddr, tr.rdata, tr.rresp);
                temp = data[tr.araddr];
                if(tr.rresp == 3)
                  $display("[SCO] : DEC ERROR");
                else if (tr.rresp == 0 && tr.rdata == temp)
                  $display("[SCO] : DATA MATCHED");
                else
                  $display("[SCO] : DATA MISMATCHED");
              end
        $display("----------------------------------------------------");
        ->sconext;
    end
  endtask
  
  
endclass
 
 
///////////////////////////////////////////////////
 
 module tb;
   
  monitor mon; 
  generator gen;
  driver drv;
  scoreboard sco;
   
   
  event nextgd;
  event nextgm;
  
 
  
   mailbox #(transaction) mbxgd, mbxms, mbxdm;
  
  axi_if vif();
   
  axilite_s dut (vif.clk, vif.resetn, vif.awvalid, vif.awready, vif.awaddr,  vif.wvalid, vif.wready,  vif.wdata,  vif.bvalid, vif.bready,  vif.wresp , vif.arvalid,  vif.arready, vif.araddr, vif.rvalid, vif.rready, vif.rdata, vif.rresp);
 
  initial begin
    vif.clk <= 0;
  end
  
  always #5 vif.clk <= ~vif.clk;
  
  initial begin
 
    mbxgd = new();
    mbxms = new();
    mbxdm = new();
    gen = new(mbxgd);
    drv = new(mbxgd,mbxdm);
    
    mon = new(mbxms,mbxdm);
    sco = new(mbxms);
    
    gen.count = 10;
    drv.vif = vif;
    mon.vif = vif;
 
    
    gen.sconext = nextgm;
    sco.sconext = nextgm;
    
  end
  
  initial begin
    drv.reset();
    fork
      gen.run();
      drv.run();
      mon.run();
      sco.run();
    join_any  
    wait(gen.done.triggered);
    $finish;
  end
   
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;   
  end
 
   
endmodule
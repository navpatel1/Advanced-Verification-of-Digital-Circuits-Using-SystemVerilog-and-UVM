`include "uvm_macros.svh"
 import uvm_pkg::*;
 
 
typedef enum bit [2:0] {wrrdfixed = 0, wrrdincr = 1, wrrdwrap = 2, wrrderrfix = 3,   rstdut = 4 } oper_mode;
 
class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
  
   
 
  function new(string name = "transaction");
    super.new(name);
  endfunction
  
 
  int len = 0;
  rand bit [3:0] id;
  oper_mode op;
  rand bit awvalid;
  bit awready;
  bit [3:0] awid;
  rand bit [3:0] awlen;
  rand bit [2:0] awsize; //4byte =010
  rand bit [31:0] awaddr;
  rand bit [1:0] awburst;
  
  bit wvalid;
  bit wready;
  bit [3:0] wid;
  rand bit [31:0] wdata;
  rand bit [3:0] wstrb;
  bit wlast;
  
  bit bready;
  bit bvalid;
  bit [3:0] bid;
  bit [1:0] bresp;
  
  
  rand bit arvalid;  /// master is sending new address  
  bit arready;  /// slave is ready to accept request
  bit [3:0] arid; ////// unique ID for each transaction
  rand bit [3:0] arlen; ////// burst length AXI3 : 1 to 16, AXI4 : 1 to 256
  bit [2:0] arsize; ////unique transaction size : 1,2,4,8,16 ...128 bytes
  rand bit [31:0] araddr; ////write adress of transaction
  rand bit [1:0] arburst; ////burst type : fixed , INCR , WRAP
  
  /////////// read data channel (r)
  
  bit rvalid; //// master is sending new data
  bit rready; //// slave is ready to accept new data 
  bit [3:0] rid; /// unique id for transaction
  bit [31:0] rdata; //// data 
  bit [3:0] rstrb; //// lane having valid data
  bit rlast; //// last transfer in write burst
  bit [1:0] rresp; ///status of read transfer
  
  //constraint size { awsize == 3'b010; arsize == 3'b010;}
  constraint txid { awid == id; wid == id; bid == id; arid == id; rid == id;  }
  constraint burst {awburst inside {0,1,2}; arburst inside {0,1,2};}
  constraint valid {awvalid != arvalid;}
  constraint length {awlen == arlen;}
 
endclass : transaction
 
 
 
////////////////////////////////////////////////////////////////////////////////
 
class rst_dut extends uvm_sequence#(transaction);
  `uvm_object_utils(rst_dut)
  
  transaction tr;
 
  function new(string name = "rst_dut");
    super.new(name);
  endfunction
 
  
  virtual task body();
    repeat(5)
      begin
        tr = transaction::type_id::create("tr");
         $display("------------------------------");
        `uvm_info("SEQ", "Sending RST Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
        tr.op      = rstdut;
        finish_item(tr);
      end
  endtask
  
 
endclass
 
 
 
 
///////////////////////////////////////////////////////////////////////
 
class valid_wrrd_fixed extends uvm_sequence#(transaction);
  `uvm_object_utils(valid_wrrd_fixed)
  
  transaction tr;
 
  function new(string name = "valid_wrrd_fixed");
    super.new(name);
  endfunction
 
  
  virtual task body();
 
        tr = transaction::type_id::create("tr");
        $display("------------------------------");
        `uvm_info("SEQ", "Sending Fixed mode Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
          tr.op      = wrrdfixed;
          tr.awlen   = 7;
          tr.awburst = 0;
          tr.awsize  = 2;
       
        finish_item(tr);
  endtask
  
 
endclass
////////////////////////////////////////////////////////////
 
class valid_wrrd_incr extends uvm_sequence#(transaction);
  `uvm_object_utils(valid_wrrd_incr)
  
  transaction tr;
 
  function new(string name = "valid_wrrd_incr");
    super.new(name);
  endfunction
 
  
  virtual task body();
        tr = transaction::type_id::create("tr");
        $display("------------------------------");
        `uvm_info("SEQ", "Sending INCR mode Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
          tr.op      = wrrdincr;
          tr.awlen   = 7;
          tr.awburst = 1;
          tr.awsize  = 2;
          
        finish_item(tr);
  endtask
  
 
endclass
 
///////////////////////////////////////////////////////////
 
class valid_wrrd_wrap extends uvm_sequence#(transaction);
  `uvm_object_utils(valid_wrrd_wrap)
  
  transaction tr;
 
  function new(string name = "valid_wrrd_wrap");
    super.new(name);
  endfunction
 
  
  virtual task body();
        tr = transaction::type_id::create("tr");
         $display("------------------------------");
        `uvm_info("SEQ", "Sending WRAP mode Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
          tr.op      = wrrdwrap;
          tr.awlen   = 7;
          tr.awburst = 2;
          tr.awsize  = 2;
          
        finish_item(tr);
  endtask
  
 
endclass
 
/////////////////////////////////////////////////////////////////////////////////
 
class err_wrrd_fix extends uvm_sequence#(transaction);
  `uvm_object_utils(err_wrrd_fix)
  
  transaction tr;
 
  function new(string name = "err_wrrd_fix");
    super.new(name);
  endfunction
 
  
  virtual task body();
        tr = transaction::type_id::create("tr");
        $display("------------------------------");
        `uvm_info("SEQ", "Sending Error Transaction to DRV", UVM_NONE);
        start_item(tr);
        assert(tr.randomize);
          tr.op      = wrrderrfix;
          tr.awlen   = 7;
          tr.awburst = 0;
          tr.awsize  = 2;   
        finish_item(tr);
  endtask
  
 
endclass
 
 
 
 
 
 
 
 
/////////////////////////////////////////////////////////////
class driver extends uvm_driver #(transaction);
  `uvm_component_utils(driver)
  
  virtual axi_if vif;
  transaction tr;
  
  
  function new(input string path = "drv", uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
 virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     tr = transaction::type_id::create("tr");
      
   if(!uvm_config_db#(virtual axi_if)::get(this,"","vif",vif)) 
      `uvm_error("drv","Unable to access Interface");
  endfunction
  
  
  
  task reset_dut(); 
    begin
    `uvm_info("DRV", "System Reset : Start of Simulation", UVM_MEDIUM);
    vif.resetn      <= 1'b0;  ///active high reset
    vif.awvalid     <= 1'b0;
    vif.awid        <= 1'b0;
    vif.awlen       <= 0;
    vif.awsize      <= 0;
    vif.awaddr      <= 0;
    vif.awburst     <= 0;
      
    vif.wvalid      <= 0;
    vif.wid         <= 0;
    vif.wdata       <= 0;
    vif.wstrb       <= 0;
    vif.wlast       <= 0;
      
    vif.bready      <= 0;
    
    vif.arvalid     <= 1'b0;
    vif.arid        <= 1'b0;
    vif.arlen       <= 0;
    vif.arsize      <= 0;
    vif.araddr      <= 0;
    vif.arburst     <= 0; 
      
    vif.rready      <= 0;
     @(posedge vif.clk);
      end
  endtask
  
  
  /////////////////////////write read in fixed mode
  
  task wrrd_fixed_wr();
            `uvm_info("DRV", "Fixed Mode Write Transaction Started", UVM_NONE);
    /////////////////////////write logic
            vif.resetn      <= 1'b1;
            vif.awvalid     <= 1'b1;
            vif.awid        <= tr.id;
            vif.awlen       <= 7;
            vif.awsize      <= 2;
            vif.awaddr      <= 5;
            vif.awburst     <= 0;
     
     
            vif.wvalid      <= 1'b1;
            vif.wid         <= tr.id;
            vif.wdata       <= $urandom_range(0,10);
            vif.wstrb       <= 4'b1111;
            vif.wlast       <= 0;
     
            vif.arvalid     <= 1'b0;  ///turn off read 
            vif.rready      <= 1'b0;
            vif.bready      <= 1'b0;
             @(posedge vif.clk);
            
             @(posedge vif.wready);
             @(posedge vif.clk);
 
     for(int i = 0; i < (vif.awlen); i++)//0 - 6 -> 7
         begin
            vif.wdata       <= $urandom_range(0,10);
            vif.wstrb       <= 4'b1111;
            @(posedge vif.wready);
            @(posedge vif.clk);
         end
         vif.awvalid     <= 1'b0;
         vif.wvalid      <= 1'b0;
         vif.wlast       <= 1'b1;
         vif.bready      <= 1'b1;
         @(negedge vif.bvalid); 
         vif.wlast       <= 1'b0;
         vif.bready      <= 1'b0;  
        /////////////////////////////////////// read logic
   endtask
   
   ///////////////////////////////////////////////////////// read transaction in fixed mode
   
        task  wrrd_fixed_rd(); 
        `uvm_info("DRV", "Fixed Mode Read Transaction Started", UVM_NONE);   
        @(posedge vif.clk);
 
        vif.arid        <= tr.id;
        vif.arlen       <= 7;
        vif.arsize      <= 2;
        vif.araddr      <= 5;
        vif.arburst     <= 0; 
        vif.arvalid     <= 1'b1;  
        vif.rready      <= 1'b1;
       
        
     for(int i = 0; i < (vif.arlen + 1); i++) begin // 0 1  2 3 4 5 6 7
       @(posedge vif.arready);
       @(posedge vif.clk);
      end
      
     @(negedge vif.rlast);      
     vif.arvalid <= 1'b0;
     vif.rready  <= 1'b0; 
 
  endtask
  
 ////////////////////////////////////////////////////////////////////// 
 
  
   task wrrd_incr_wr();
   /////////////////////////write logic
    `uvm_info("DRV", "INCR Mode Write Transaction Started", UVM_NONE);
            vif.resetn      <= 1'b1;
            vif.awvalid     <= 1'b1;
            vif.awid        <= tr.id;
            vif.awlen       <= 7;
            vif.awsize      <= 2;
            vif.awaddr      <= 5;
            vif.awburst     <= 1;
     
     
            vif.wvalid      <= 1'b1;
            vif.wid         <= tr.id;
            vif.wdata       <= $urandom_range(0,10);
            vif.wstrb       <= 4'b1111;
            vif.wlast       <= 0;
     
            vif.arvalid     <= 1'b0;  ///turn off read 
            vif.rready      <= 1'b0;
            vif.bready      <= 1'b0;
            
            
             @(posedge vif.wready);
             @(posedge vif.clk);
 
     for(int i = 0; i < (vif.awlen); i++)
         begin
            vif.wdata       <= $urandom_range(0,10);
            vif.wstrb       <= 4'b1111;
            @(posedge vif.wready);
            @(posedge vif.clk);
         end
     
         vif.wlast       <= 1'b1;
         vif.bready      <= 1'b1;
         vif.awvalid     <= 1'b0;
         vif.wvalid      <= 1'b0;
         @(negedge vif.bvalid);
         vif.bready      <= 1'b0;
          vif.wlast      <= 1'b0; 
           
      endtask   
      
        /////////////////////////////////////// read logic
     task wrrd_incr_rd();  
       `uvm_info("DRV", "INCR Mode Read Transaction Started", UVM_NONE);  
       @(posedge vif.clk);
 
       
 
        vif.arid        <= tr.id;
        vif.arlen       <= 7;
        vif.arsize      <= 2;
        vif.araddr      <= 5;
        vif.arburst     <= 1; 
        vif.arvalid     <= 1'b1;  
        vif.rready      <= 1'b1;
        
     for(int i = 0; i < (vif.arlen + 1); i++) begin // 0 1  2 3 4 5 6 7
       @(posedge vif.arready);
       @(posedge vif.clk);
      end
      
     @(negedge vif.rlast);
     vif.arvalid <= 1'b0;
     vif.rready  <= 1'b0; 
  endtask
 
//////////////////////////////////////////////////////////////////////////////
 
   task wrrd_wrap_wr();
    `uvm_info("DRV", "WRAP Mode Write Transaction Started", UVM_NONE);  
   /////////////////////////write logic
            vif.resetn      <= 1'b1;
            vif.awvalid     <= 1'b1;
            vif.awid        <= tr.id;
            vif.awlen       <= 7;
            vif.awsize      <= 2;
            vif.awaddr      <= 5;
            vif.awburst     <= 2;
     
     
            vif.wvalid      <= 1'b1;
            vif.wid         <= tr.id;
            vif.wdata       <= $urandom_range(0,10);
            vif.wstrb       <= 4'b1111;
            vif.wlast       <= 0;
     
            vif.arvalid     <= 1'b0;  ///turn off read 
            vif.rready      <= 1'b0;
            vif.bready      <= 1'b0;
            
            
             @(posedge vif.wready);
             @(posedge vif.clk);
 
       for(int i = 0; i < (vif.awlen); i++)
         begin
            vif.wdata       <= $urandom_range(0,10);
            vif.wstrb       <= 4'b1111;
            @(posedge vif.wready);
            @(posedge vif.clk);
         end
     
         vif.wlast       <= 1'b1;
         vif.bready      <= 1'b1;
         vif.awvalid     <= 1'b0;
         vif.wvalid      <= 1'b0;
        
         @(negedge vif.bvalid);
         vif.bready      <= 1'b0; 
         vif.wlast       <= 1'b0; 
         
         
        endtask 
         
         
         
        /////////////////////////////////////// read logic
       task wrrd_wrap_rd(); 
      `uvm_info("DRV", "WRAP Mode Read Transaction Started", UVM_NONE);  
       @(posedge vif.clk);
       vif.arvalid     <= 1'b1;  
       vif.rready      <= 1'b1;
  
 
        vif.arid        <= tr.id;
        vif.arlen       <= 7;
        vif.arsize      <= 2;
        vif.araddr      <= 5;
        vif.arburst     <= 2; 
        
     for(int i = 0; i < (vif.arlen + 1); i++) begin // 0 1  2 3 4 5 6 7
       @(posedge vif.arready);
       @(posedge vif.clk);
      end
     
     @(negedge vif.rlast);
     vif.arvalid <= 1'b0; 
     vif.rready  <= 1'b0; 
  endtask
  
  //////////////////////////////////////////////////////////////////////////
  
      task err_wr();
      `uvm_info("DRV", "Error Write Transaction Started", UVM_NONE);
   
   /////////////////////////write logic
            vif.resetn      <= 1'b1;
            vif.awvalid     <= 1'b1;
            vif.awid        <= tr.id;
            vif.awlen       <= 7;
            vif.awsize      <= 2;
            vif.awaddr      <= 128;
            vif.awburst     <= 0;
     
     
            vif.wvalid      <= 1'b1;
            vif.wid         <= tr.id;
            vif.wdata       <= $urandom_range(0,10);
            vif.wstrb       <= 4'b1111;
            vif.wlast       <= 0;
     
            vif.arvalid     <= 1'b0;  ///turn off read 
            vif.rready      <= 1'b0;
            vif.bready      <= 1'b0;
            
            
             @(posedge vif.wready);
             @(posedge vif.clk);
 
     for(int i = 0; i < (vif.awlen); i++)
         begin
            vif.wdata       <= $urandom_range(0,10);
            vif.wstrb       <= 4'b1111;
            @(posedge vif.wready);
            @(posedge vif.clk);
         end
     
         vif.wlast       <= 1'b1;
         vif.bready      <= 1'b1;
         vif.awvalid     <= 1'b0;
         vif.wvalid      <= 1'b0;
         
         @(negedge vif.bvalid);
         vif.bready      <= 1'b0;
         vif.wlast       <= 1'b0;
        endtask
        
           
        /////////////////////////////////////// read logic
       task err_rd();  
        `uvm_info("DRV", "Error Read Transaction Started", UVM_NONE);
       @(posedge vif.clk);
       vif.arvalid     <= 1'b1;  
       vif.rready      <= 1'b1;
       //vif.bready      <= 1'b1;
 
        vif.arid        <= tr.id;
        vif.arlen       <= 7;
        vif.arsize      <= 2;
        vif.araddr      <= 128;
        vif.arburst     <= 0; 
        
     for(int i = 0; i < (vif.arlen + 1); i++) begin // 0 1  2 3 4 5 6 7
       @(posedge vif.arready);
       @(posedge vif.clk);
      end
     
     @(negedge vif.rlast);
     vif.arvalid <= 1'b0; 
     vif.rready  <= 1'b0; 
  
    endtask
  ////////////////////////////////////////////////////////////////////////
 
 
  virtual task run_phase(uvm_phase phase);
       forever begin
     
         seq_item_port.get_next_item(tr);
            if(tr.op == rstdut)
             reset_dut();
           else if (tr.op == wrrdfixed)
             begin
            `uvm_info("DRV", $sformatf("Fixed Mode Write -> Read WLEN:%0d WSIZE:%0d",tr.awlen+1,tr.awsize), UVM_MEDIUM);
             wrrd_fixed_wr();
             wrrd_fixed_rd();
             end
           else if (tr.op == wrrdincr)
             begin
            `uvm_info("DRV", $sformatf("INCR Mode Write -> Read WLEN:%0d WSIZE:%0d",tr.awlen+1,tr.awsize), UVM_MEDIUM);
             wrrd_incr_wr();
             wrrd_incr_rd();
             end   
           else if (tr.op == wrrdwrap)
             begin
            `uvm_info("DRV", $sformatf("WRAP Mode Write -> Read WLEN:%0d WSIZE:%0d",tr.awlen+1,tr.awsize), UVM_MEDIUM);
             wrrd_wrap_wr();
             wrrd_wrap_rd();
             end   
           else if (tr.op == wrrderrfix)
             begin
            `uvm_info("DRV", $sformatf("Error Transaction Mode WLEN:%0d WSIZE:%0d",tr.awlen+1,tr.awsize), UVM_MEDIUM);
             err_wr();
             err_rd();
             end 
 
         seq_item_port.item_done();
        end
  endtask
 
  
endclass
///////////////////////////////////////////////////////////////////////
 
 
 
class mon extends uvm_monitor;
`uvm_component_utils(mon)
 
transaction tr;
virtual axi_if vif;
  
  logic [31:0] arr[128];
    
  logic [1:0] rdresp;
  logic [1:0] wrresp;
  
  logic       resp;
  
  int err = 0;
 
    function new(input string inst = "mon", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = transaction::type_id::create("tr");
      if(!uvm_config_db#(virtual axi_if)::get(this,"","vif",vif))//uvm_test_top.env.agent.drv.aif
        `uvm_error("MON","Unable to access Interface");
    endfunction
  
  
  /////////////////////////////////////////////////////////////////////////
  
  task compare();
    if(err == 0 && rdresp == 0 && wrresp == 0 )
         begin
           `uvm_info("MON", $sformatf("Test Passed err :%0d wrresp :%0d rdresp :%0d ", err, rdresp, wrresp), UVM_MEDIUM); 
           err = 0;
         end
    else
        begin
          `uvm_info("MON", $sformatf("Test Failed err :%0d wrresp :%0d rdresp :%0d ", err, rdresp, wrresp), UVM_MEDIUM);
          err = 0; 
        end
  endtask
  
    
  ///////////////////////////////////////////////////////////////////////  
    virtual task run_phase(uvm_phase phase);
    forever begin
    
      @(posedge vif.clk);
      if(!vif.resetn)
        begin 
          `uvm_info("MON", "System Reset Detected", UVM_MEDIUM); 
        end
      
      else if(vif.resetn && vif.awaddr < 128)
        begin
       
          wait(vif.awvalid == 1'b1);
          
          for(int i =0; i < (vif.awlen + 1); i++) begin
          @(posedge vif.wready);
          arr[vif.next_addrwr] = vif.wdata;
          end
          
         // @(negedge vif.wlast);
          @(posedge vif.bvalid);
          wrresp = vif.bresp;///0
  //////////////////////////////////////////////////////        
          wait(vif.arvalid == 1'b1);
          
          for(int i =0; i < (vif.arlen + 1); i++) begin
            @(posedge vif.rvalid);
            if(vif.rdata != arr[vif.next_addrrd])
               begin
               err++;
               end
          end
          
          @(posedge vif.rlast);
          rdresp = vif.rresp;
          
          compare();
           $display("------------------------------");
          end
          
          else if (vif.resetn && vif.awaddr >= 128)
          begin
          wait(vif.awvalid == 1'b1);
          
          for(int i =0; i < (vif.awlen + 1); i++) begin
          @(negedge vif.wready);
          end
          
          @(posedge vif.bvalid);
          wrresp = vif.bresp;
          
          wait(vif.arvalid == 1'b1);
          
          for(int i =0; i < (vif.arlen + 1); i++) begin
            @(posedge vif.arready);
            if(vif.rresp != 2'b00)
               begin
               err++;
               end
          end
          
          @(posedge vif.rlast);
           rdresp = vif.rresp;  
              
              compare();   
           $display("------------------------------");   
         end
      
 end      
endtask 
 
endclass
 
 
 
 
 
 
 
 
 
 
///////////////////////////////////////////////////////////
class agent extends uvm_agent;
`uvm_component_utils(agent)
  
 
 
function new(input string inst = "agent", uvm_component parent = null);
super.new(inst,parent);
endfunction
 
 driver d;
 uvm_sequencer#(transaction) seqr;
 mon m;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
   m = mon::type_id::create("m",this); 
   d = driver::type_id::create("d",this);
   seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this);
  
  
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
    d.seq_item_port.connect(seqr.seq_item_export);
endfunction
 
endclass
 
////////////////////////////////////////////////////////////////////////////////
 
class env extends uvm_env;
`uvm_component_utils(env)
 
function new(input string inst = "env", uvm_component c);
super.new(inst,c);
endfunction
 
agent a;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  a = agent::type_id::create("a",this);
 
endfunction
 
 
endclass
 
//////////////////////////////////////////////////
class test extends uvm_test;
`uvm_component_utils(test)
 
function new(input string inst = "test", uvm_component c);
super.new(inst,c);
endfunction
 
 
env e;
valid_wrrd_fixed vwrrdfx;
valid_wrrd_incr  vwrrdincr;
valid_wrrd_wrap  vwrrdwrap;
err_wrrd_fix     errwrrdfix;
rst_dut rdut; 
  
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
   e       = env::type_id::create("env",this);
  vwrrdfx = valid_wrrd_fixed::type_id::create("vwrrdfx");
  vwrrdincr = valid_wrrd_incr::type_id::create("vwrrdincr");
  vwrrdwrap = valid_wrrd_wrap::type_id::create("vwrrdwrap");
  errwrrdfix = err_wrrd_fix::type_id::create("errwrrdfix");
  rdut       = rst_dut::type_id::create("rdut");
endfunction
 
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
//rdut.start(e.a.seqr);
//#20;
//vwrrdfx.start(e.a.seqr);
//#20;
//vwrrdincr.start(e.a.seqr);
//#20;
//vwrrdwrap.start(e.a.seqr);
//#20;
errwrrdfix.start(e.a.seqr);
#20;
 
phase.drop_objection(this);
endtask
endclass
 
/////////////////////////////////////////////////////////////////////
 
module tb;
 
 axi_if vif();
 axi_slave dut (vif.clk, vif.resetn, vif.awvalid, vif.awready,  vif.awid, vif.awlen, vif.awsize, vif.awaddr,  vif.awburst, vif.wvalid, vif.wready, vif.wid, vif.wdata, vif.wstrb, vif.wlast, vif.bready, vif.bvalid, vif.bid, vif.bresp , vif.arready, vif.arid, vif.araddr, vif.arlen, vif.arsize, vif.arburst, vif.arvalid, vif.rid, vif.rdata, vif.rresp,vif.rlast,  vif.rvalid, vif.rready);
 
  initial begin
    vif.clk <= 0;
  end
  
  always #5 vif.clk <= ~vif.clk;
  
    initial begin
    uvm_config_db#(virtual axi_if)::set(null, "*", "vif", vif);
    run_test("test");
   end
  
  
  
  
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars;   
  end
  
  assign vif.next_addrwr = dut.nextaddr;
  assign vif.next_addrrd = dut.rdnextaddr;
  
endmodule
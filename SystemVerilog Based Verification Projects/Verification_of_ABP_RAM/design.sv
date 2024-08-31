module apb_s
(
    input  pclk,
    input  presetn,
    input [31:0] paddr,
    input psel,
    input penable,
    input [7:0] pwdata,
    input pwrite,
    
    output reg [7:0] prdata,
    output reg pready,
    output     pslverr
);
 
 
 
 
  localparam [1:0] idle = 0, write = 1, read = 2;
  reg [7:0] mem[16];
  
  reg [1:0] state, nstate;
  
  bit  addr_err , addv_err, data_err;
  ////////// setup - correct apb cycles
  /////////  addr_range - should be less than 16
  /////////   addr_val - be greater than or equal to 0
  /////////   data_val - be greater than or equal to 0  
/*
Transactions that receive an error, might or might not have changed the state of the peripheral. 
This is peripheral-specific and either is acceptable. 
When a write transaction receives an error this does not mean that the register within the peripheral 
has not been updated. Read transactions that receive an error can return invalid data.
 There is no requirement for the peripheral to drive the data bus to all 0s for a read error.
*/
  ///// reset decoder
  always@(posedge pclk, negedge presetn)
    begin
      if(presetn == 1'b0)
          state <= idle;
      else
          state <= nstate;
    end
    
    ///next state , output decoder
  always@(*)
    begin
    case(state)
     idle:
     begin
        prdata    = 8'h00;
        pready    = 1'b0;
        
            if(psel == 1'b1 && pwrite == 1'b1)  
                nstate = write;
            else if (psel == 1'b1 && pwrite == 1'b0)
                nstate = read;
            else
                nstate = idle; 
            
           
                
            
      end   
           
     
     write:
     begin
        if(psel == 1'b1 && penable == 1'b1)
        begin 
                 if(!addr_err && !addv_err && !data_err )
                    begin
                    pready = 1'b1;
                    mem[paddr]  = pwdata;
                    nstate      = idle;
                    end
                else
                     begin
                     nstate = idle;
                     pready = 1'b1;
                     end     
                 
     
        end
    end
     
    read:
     begin
        if(psel == 1'b1 && penable == 1'b1 )
        begin
            if(!addr_err && !addv_err && !data_err )
                 begin
                 pready = 1'b1;
                 prdata = mem[paddr];
                 nstate      = idle;
                 end
            else
                begin
                pready = 1'b1;
                prdata = 8'h00;
                nstate      = idle;
                end
        end
    end
     
    default : 
    begin
        nstate = idle; 
        prdata    = 8'h00;
        pready    = 1'b0;
     end
    endcase
    end
 
///////////////// checking valid values of address
reg av_t = 0;
always@(*)
begin
if(paddr >= 0)
  av_t = 1'b0;
else
  av_t = 1'b1;
end
 
///////////////// checking valid values of address
reg dv_t = 0;
always@(*)
begin
if(pwdata >= 0)
  dv_t = 1'b0;
else
  dv_t = 1'b1;
end
 
 
assign addr_err = ((nstate == write || read) && (paddr > 15)) ? 1'b1 : 1'b0;
assign addv_err = (nstate == write || read) ? av_t : 1'b0;
assign data_err = (nstate == write || read) ? dv_t : 1'b0;
 
assign pslverr  = (psel == 1'b1 && penable == 1'b1) ? ( addv_err || addr_err || data_err) : 1'b0;
 
endmodule
module mul(
  input [3:0] a,b,
  output [7:0] y
);
   
assign y = a * b;
  
endmodule
 
 
///////////////////////////////////////////
 
interface mul_if;
  logic [3:0] a;
  logic [3:0] b;
  logic [7:0] y;
  
endinterface
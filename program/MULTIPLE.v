
module MULTIPLE( dataOut, dataA, dataB, clk, reset, signal ) ;
input [31:0] dataA, dataB ;
input clk, reset  ;
input [3:0] signal ; 
output [63:0] dataOut ;
reg [63:0] multiplicant ;  // dataA
reg [31:0] multiplier ;  // dataB
reg [63:0] product ;

parameter MUL = 1'b0 ;
parameter DONE = 1'b1 ;

always @( reset )
begin
  if ( reset ) 
  begin
    product = 0 ;
    multiplicant = dataA ;
    multiplier = dataB ;
  end

end

always @( posedge clk  )
begin
  if ( signal == MUL ) begin
    if ( multiplier[0] == 1'b1 )
      product = product + multiplicant ;

    multiplier = multiplier >> 1 ;
    multiplicant = multiplicant << 1 ;    
  end
  else if ( signal == DONE ) ;
  
end

assign dataOut = product ;

endmodule
module HiLoReg( clk,signal,hi,lo,dataout) ;
input clk ;
input [3:0] signal ;
input [31:0] hi , lo ;
output [31:0] dataout ;
reg[31:0] dataout ;
    parameter ALU_and = 4'b0000;
    parameter ALU_or  = 4'b0001;
    parameter ALU_add = 4'b0010;
    parameter ALU_sll  = 4'b0011;
    parameter ALU_srl = 4'b0100;
    parameter ALU_mfhi  = 4'b0101;
    parameter ALU_sub = 4'b0110;
    parameter ALU_slt = 4'b0111;
    parameter ALU_mflo = 4'b1000;
	always@(posedge clk) begin
	  if ( signal == ALU_mfhi )
	    dataout = hi ;
	  if ( signal == ALU_mflo )
	    dataout = lo ;
	end
endmodule

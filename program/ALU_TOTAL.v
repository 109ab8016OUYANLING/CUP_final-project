module ALU_TOTAL( clk,signal, dataA, dataB, dataOut, zero , bgtz) ;
input [31:0] dataA, dataB ;
input [3:0] signal ;
input clk ;
output [31:0] dataOut ;
output zero ,bgtz;

parameter ALU_and = 4'b0000;
parameter ALU_or  = 4'b0001;
parameter ALU_add = 4'b0010;
parameter ALU_sll  = 4'b0011;
parameter ALU_srl = 4'b0100;
parameter ALU_mfhi  = 4'b0101;
parameter ALU_sub = 4'b0110;
parameter ALU_slt = 4'b0111;
parameter ALU_mflo = 4'b1000;


wire mux_signal,mux_hilo ;
wire [31:0] wdata , aluOut , shiftOut , hiloOut ;
wire [63:0]multout ;
assign mux_signal = ( signal == ALU_sll || signal == ALU_srl )?1:0 ;
assign mux_hilo = ( signal == ALU_mfhi || signal == ALU_mflo )?1:0 ;
ALU_32 alu_32( .dataOut( aluOut ), .dataA( dataA ), .dataB( dataB ), .signal( signal), .zero(zero) ,.bgtz(bgtz) ) ;
MULTIPLE mult( .dataOut(multout), .dataA(dataA), .dataB(dataB), .clk(clk), .reset(1'b0), .signal(signal) ) ;

SHIFT shift( .dataOut( shiftOut ), .dataA( dataA ), .dataB( dataB ), .signal( signal ) ) ;

HiLoReg hilo( .clk(clk),.signal(signal),.hi(multout[63:32]),.lo(multout[31:0]),.dataout(hiloOut) ) ;

mux2 #(32) ALUMUX( .sel(mux_signal), .a(aluOut), .b(shiftOut), .y(wdata) );
mux2 #(32) ALUMUX1( .sel(mux_hilo), .a(wdata), .b(hiloOut), .y(dataOut) );

endmodule
module SHIFT( dataOut, dataA, dataB, signal ) ;
input [31:0] dataA, dataB ;
input [3:0]signal ;
output [31:0] dataOut ;

    parameter SLL  = 4'b0011;
    parameter SRL = 4'b0100;

wire [31:0] tempSRL, tempSLL ;
SLL sll( .dataOut( tempSLL ), .dataA( dataA ), .s( dataB[4:0] ) ) ;
SRL srl( .dataOut( tempSRL ), .dataA( dataA ), .s( dataB[4:0] ) ) ;
assign dataOut = ( signal == SLL )? tempSLL : tempSRL ;

endmodule
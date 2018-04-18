
module ALU( dataOut, cOut, dataA, dataB, cIn, signal );
input dataA, dataB, cIn ;
input [3:0] signal ;
output dataOut, cOut ;

wire tempDataOut, tempB, tempCout ;
//   Signal ( 6-bits)?
//   AND  : 36  000 ->0
//   OR   : 37  001 -> 1
//   ADD  : 32  010->2
//   SUB  : 34  110 -> 6
//   SLT  : 42  111->7

parameter AND = 3'd0;
parameter OR  = 3'd1;
parameter ADD = 3'd2;
parameter SUB = 3'd6;
parameter SLT = 3'd7;
 
assign tempB = ( signal == SUB || 
                 signal == SLT ) ? ~dataB : dataB ;  // make sure if need invert

FULL_ADDER adder ( .cOut( tempCout ), .sum( tempDataOut ) , .dataA( dataA ),
                   .dataB( tempB ), .cIn( cIn )  ) ;

assign cOut = tempCout ;
assign dataOut = ( signal == AND ) ? ( dataA & dataB ) :
                 ( signal == OR ) ? ( dataA | dataB ) :
                 tempDataOut ;


endmodule
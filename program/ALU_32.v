
module ALU_32( dataOut, zero, dataA, dataB, signal,bgtz );
input [31:0] dataA, dataB ;
input [3:0] signal ;
output [31:0] dataOut ;
output zero,bgtz ;
wire [31:0] cOut, temp ;
//   Signal ( 6-bits)?
//   AND  : 36
//   OR   : 37
//   ADD  : 32
//   SUB  : 34
//   SLT  : 42

parameter AND = 4'd0;
parameter OR  = 4'd1;
parameter ADD = 4'd2;
parameter SUB = 4'd6;
parameter SLT = 4'd7;

wire firstCin ;
assign firstCin = ( signal == SUB || signal == SLT )? 1'b1 : 1'b0 ;
ALU alu1( .dataOut( temp[0] ), .cOut( cOut[0] ), .dataA( dataA[0] ),
          .dataB( dataB[0] ), .cIn( firstCin ), .signal( signal ) ) ;

ALU alu2( .dataOut( temp[1] ), .cOut( cOut[1] ), .dataA( dataA[1] ),
          .dataB( dataB[1] ), .cIn( cOut[0] ), .signal( signal ) ) ;

ALU alu3( .dataOut( temp[2] ), .cOut( cOut[2] ), .dataA( dataA[2] ),
          .dataB( dataB[2] ), .cIn( cOut[1] ), .signal( signal ) ) ;

ALU alu4( .dataOut( temp[3] ), .cOut( cOut[3] ), .dataA( dataA[3] ),
          .dataB( dataB[3] ), .cIn( cOut[2] ), .signal( signal ) ) ;

ALU alu5( .dataOut( temp[4] ), .cOut( cOut[4] ), .dataA( dataA[4] ),
          .dataB( dataB[4] ), .cIn( cOut[3] ), .signal( signal ) ) ;

ALU alu6( .dataOut( temp[5] ), .cOut( cOut[5] ), .dataA( dataA[5] ),
          .dataB( dataB[5] ), .cIn( cOut[4] ), .signal( signal ) ) ;

ALU alu7( .dataOut( temp[6] ), .cOut( cOut[6] ), .dataA( dataA[6] ),
          .dataB( dataB[6] ), .cIn( cOut[5] ), .signal( signal ) ) ;

ALU alu8( .dataOut( temp[7] ), .cOut( cOut[7] ), .dataA( dataA[7] ),
          .dataB( dataB[7] ), .cIn( cOut[6] ), .signal( signal ) ) ;

ALU alu9( .dataOut( temp[8] ), .cOut( cOut[8] ), .dataA( dataA[8] ),
          .dataB( dataB[8] ), .cIn( cOut[7] ), .signal( signal ) ) ;

ALU alu10( .dataOut( temp[9] ), .cOut( cOut[9] ), .dataA( dataA[9] ),
          .dataB( dataB[9] ), .cIn( cOut[8] ), .signal( signal ) ) ;

ALU alu11( .dataOut( temp[10] ), .cOut( cOut[10] ), .dataA( dataA[10] ),
           .dataB( dataB[10] ), .cIn( cOut[9] ), .signal( signal ) ) ;

ALU alu12( .dataOut( temp[11] ), .cOut( cOut[11] ), .dataA( dataA[11] ),
           .dataB( dataB[11] ), .cIn( cOut[10] ), .signal( signal ) ) ;

ALU alu13( .dataOut( temp[12] ), .cOut( cOut[12] ), .dataA( dataA[12] ),
           .dataB( dataB[12] ), .cIn( cOut[11] ), .signal( signal ) ) ;

ALU alu14( .dataOut( temp[13] ), .cOut( cOut[13] ), .dataA( dataA[13] ),
           .dataB( dataB[13] ), .cIn( cOut[12] ), .signal( signal ) ) ;

ALU alu15( .dataOut( temp[14] ), .cOut( cOut[14] ), .dataA( dataA[14] ),
           .dataB( dataB[14] ), .cIn( cOut[13] ), .signal( signal ) ) ;

ALU alu16( .dataOut( temp[15] ), .cOut( cOut[15] ), .dataA( dataA[15] ),
           .dataB( dataB[15] ), .cIn( cOut[14] ), .signal( signal ) ) ;

ALU alu17( .dataOut( temp[16] ), .cOut( cOut[16] ), .dataA( dataA[16] ),
           .dataB( dataB[16] ), .cIn( cOut[15] ), .signal( signal ) ) ;

ALU alu18( .dataOut( temp[17] ), .cOut( cOut[17] ), .dataA( dataA[17] ),
           .dataB( dataB[17] ), .cIn( cOut[16] ), .signal( signal ) ) ;

ALU alu19( .dataOut( temp[18] ), .cOut( cOut[18] ), .dataA( dataA[18] ),
           .dataB( dataB[18] ), .cIn( cOut[17] ), .signal( signal ) ) ;

ALU alu20( .dataOut( temp[19] ), .cOut( cOut[19] ), .dataA( dataA[19] ),
           .dataB( dataB[19] ), .cIn( cOut[18] ), .signal( signal ) ) ;

ALU alu21( .dataOut( temp[20] ), .cOut( cOut[20] ), .dataA( dataA[20] ),
           .dataB( dataB[20] ), .cIn( cOut[19] ), .signal( signal ) ) ;

ALU alu22( .dataOut( temp[21] ), .cOut( cOut[21] ), .dataA( dataA[21] ),
           .dataB( dataB[21] ), .cIn( cOut[20] ), .signal( signal ) ) ;

ALU alu23( .dataOut( temp[22] ), .cOut( cOut[22] ), .dataA( dataA[22] ),
           .dataB( dataB[22] ), .cIn( cOut[21] ), .signal( signal ) ) ;

ALU alu24( .dataOut( temp[23] ), .cOut( cOut[23] ), .dataA( dataA[23] ),
           .dataB( dataB[23] ), .cIn( cOut[22] ), .signal( signal ) ) ;

ALU alu25( .dataOut( temp[24] ), .cOut( cOut[24] ), .dataA( dataA[24] ),
           .dataB( dataB[24] ), .cIn( cOut[23] ), .signal( signal ) ) ;

ALU alu26( .dataOut( temp[25] ), .cOut( cOut[25] ), .dataA( dataA[25] ),
           .dataB( dataB[25] ), .cIn( cOut[24] ), .signal( signal ) ) ;

ALU alu27( .dataOut( temp[26] ), .cOut( cOut[26] ), .dataA( dataA[26] ),
           .dataB( dataB[26] ), .cIn( cOut[25] ), .signal( signal ) ) ;

ALU alu28( .dataOut( temp[27] ), .cOut( cOut[27] ), .dataA( dataA[27] ),
           .dataB( dataB[27] ), .cIn( cOut[26] ), .signal( signal ) ) ;

ALU alu29( .dataOut( temp[28] ), .cOut( cOut[28] ), .dataA( dataA[28] ),
           .dataB( dataB[28] ), .cIn( cOut[27] ), .signal( signal ) ) ;

ALU alu30( .dataOut( temp[29] ), .cOut( cOut[29] ), .dataA( dataA[29] ),
           .dataB( dataB[29] ), .cIn( cOut[28] ), .signal( signal ) ) ;

ALU alu31( .dataOut( temp[30] ), .cOut( cOut[30] ), .dataA( dataA[30] ),
           .dataB( dataB[30] ), .cIn( cOut[29] ), .signal( signal ) ) ;

ALU alu32( .dataOut( temp[31] ), .cOut( cOut[31] ), .dataA( dataA[31] ),
           .dataB( dataB[31] ), .cIn( cOut[30] ), .signal( signal ) ) ;

assign dataOut = ( signal ==  SLT ) ? 
                 ( temp[31] == 1'b1 ? 32'd1 : 32'd0 ) : temp ;
assign zero = (dataOut == 32'b0 ) ? 1 : 0  ;
assign bgtz = (dataOut > 32'b0 )? 1:0 ;
endmodule
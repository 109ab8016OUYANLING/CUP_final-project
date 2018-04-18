
module SLL( dataOut, dataA, s ) ;
input [31:0] dataA ;
input [4:0] s ;      //  the low five of dataB
output [31:0] dataOut ;

wire [31:0] temp1, temp2, temp3, temp4;
assign temp1 = ( s[0] == 1'b1 )? { dataA[30:0], 1'b0 } : dataA ;
assign temp2 = ( s[1] == 1'b1 )? { temp1[29:0], 2'b00 } : temp1 ;
assign temp3 = ( s[2] == 1'b1 )? { temp2[27:0], 4'b0000 } : temp2 ;
assign temp4 = ( s[3] == 1'b1 )? { temp3[23:0], 8'b00000000 } : temp3 ;
assign dataOut = ( s[4] == 1'b1 )? { temp4[15:0], 16'b0000000000000000 } : temp4 ;

endmodule
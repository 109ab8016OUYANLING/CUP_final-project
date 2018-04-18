
module SRL( dataOut, dataA, s ) ;
input [31:0] dataA ;
input [4:0] s ;      //  the low five of dataB
output [31:0] dataOut ;

wire [31:0] temp1, temp2, temp3, temp4;
assign temp1 = ( s[0] == 1'b1 )? { 1'b0, dataA[31:1] } : dataA ;
assign temp2 = ( s[1] == 1'b1 )? { 2'b00, temp1[31:2] } : temp1 ;
assign temp3 = ( s[2] == 1'b1 )? { 4'b0000, temp2[31:4] } : temp2 ;
assign temp4 = ( s[3] == 1'b1 )? { 8'b00000000, temp3[31:8] } : temp3 ;
assign dataOut = ( s[4] == 1'b1 )? { 16'b0000000000000000, temp4[31:16] } : temp4 ;

endmodule
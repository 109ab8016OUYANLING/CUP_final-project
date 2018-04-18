
module FULL_ADDER( cOut, sum, dataA, dataB, cIn ) ;
  input dataA, dataB, cIn ;
  output cOut, sum ;

  assign sum = ( ( dataA ^ dataB ) ^ cIn ) ;
  assign cOut = ( ( ( dataA | dataB ) & cIn ) | ( dataA & dataB ) ) ;

endmodule
/*
	Title: 32-Bit Register with Synchronous Reset
	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
	
	Input Port
		1. clk
		2. rst: 重置訊號
		3. en_reg: 控制暫存器是否可寫入
		4. d_in: 欲寫入的暫存器資料
	Output Port
		1. d_out: 所讀取的暫存器資料
*/
module reg_if( clk, rst, en_reg, pc_incr, instrc, funct, out_pc_incr, out_instrc, out_funct ) ;
  input clk, rst, en_reg ;
  input [5:0] funct ;
  input [31:0] pc_incr, instrc ;
  
  output [31:0] out_pc_incr, out_instrc ;
  output [5:0] out_funct ;
  reg [31:0] out_pc_incr, out_instrc ;
  reg [5:0] out_funct ;
  
  always @( posedge clk ) begin
        if ( rst ) begin
		    out_pc_incr <= 32'b0;
			out_instrc <= 32'b0 ;
			out_funct <= 6'bx ;
		end
        else if ( en_reg ) begin
			out_pc_incr <= pc_incr;
			out_instrc <= instrc ;
			out_funct <= funct ;
		end
    end

endmodule
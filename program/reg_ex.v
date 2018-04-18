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
module reg_ex( clk, rst, en_reg, MemtoReg, RegWrite, 
			   MemRead, MemWrite, Branch, Beq, b_tgt, zero, bgtz, alu_out, RD2, rfile_wn,
			   out_MemtoReg, out_RegWrite, out_MemRead,
			   out_MemWrite, out_Branch, out_Beq, out_b_tgt,
               out_zero, out_bgtz, out_alu_out, out_RD2, out_rfile_wn ) ;
  input clk, rst, en_reg ;
  input MemtoReg, RegWrite, MemRead, MemWrite, Branch, Beq, zero, bgtz ;
  input [31:0]  b_tgt, alu_out, RD2;
  input [4:0] rfile_wn ;
  
  output out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite, out_Branch, out_Beq, out_zero, out_bgtz ;
  output [31:0]  out_b_tgt, out_alu_out, out_RD2  ;
  output [4:0] out_rfile_wn ;
  
  reg out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite, out_Branch, out_Beq, out_zero, out_bgtz ;
  reg [31:0]  out_b_tgt, out_alu_out, out_RD2 ;
  reg [4:0] out_rfile_wn ;
  
  always @( posedge clk ) begin
        if ( rst ) begin
			out_MemtoReg <= 1'bx ;  
			out_RegWrite <= 1'bx ;  
			out_MemRead <= 1'bx ; 
			out_MemWrite <= 1'bx ;  
			out_Branch <= 1'bx ; 
			out_Beq <= 1'bx ; 
			out_zero <= 1'bx ; 
			out_bgtz <= 1'bx ; 
			out_b_tgt <= 32'bx ; 
			out_alu_out <= 32'bx ; 
			 out_RD2 <= 32'bx ;
			out_rfile_wn <= 32'bx ; 
		end
        else if ( en_reg ) begin
			out_MemtoReg <= MemtoReg ;  
			out_RegWrite <= RegWrite ;  
			out_MemRead <= MemRead ; 
			out_MemWrite <= MemWrite ;  
			out_Branch <= Branch ; 
			out_Beq <= Beq ;  
			out_zero <= zero ; 
			out_bgtz <= bgtz ; 
			out_b_tgt <= b_tgt ; 
			out_alu_out <= alu_out ; 
			out_RD2 <= RD2 ;
			out_rfile_wn <= rfile_wn ; 
		end
    end

endmodule
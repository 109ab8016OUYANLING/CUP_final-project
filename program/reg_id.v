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
module reg_id( clk, rst, en_reg, RegDst, ALUSrc, MemtoReg, RegWrite, 
			   MemRead, MemWrite, Branch, ALUOp, Beq, pc_incr, rfile_rd1,
               rfile_rd2, extend_immed, rt, rd, funct,
			   out_RegDst, out_ALUSrc, out_MemtoReg,
			   out_RegWrite, out_MemRead, out_MemWrite, out_Branch, 
			   out_ALUOp, out_Beq, out_pc_incr, out_rfile_rd1,
               out_rfile_rd2, out_extend_immed, out_rt, out_rd , out_funct ) ;
  input clk, rst, en_reg ;
  input RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Beq;
  input [1:0] ALUOp;
  input [31:0] pc_incr, rfile_rd1, rfile_rd2, extend_immed ;
  input [4:0] rt, rd ;
  input [5:0] funct ;
  
  output out_RegDst, out_ALUSrc, out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite,  out_Branch, out_Beq;
  output [1:0] out_ALUOp;
  output [31:0] out_pc_incr, out_rfile_rd1, out_rfile_rd2, out_extend_immed ;
  output [4:0]  out_rt, out_rd ;
  output [5:0] out_funct ;
  
  reg out_RegDst, out_ALUSrc, out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite,  out_Branch, out_Beq;
  reg [1:0] out_ALUOp;
  reg [31:0] out_pc_incr, out_rfile_rd1, out_rfile_rd2, out_extend_immed ;
  reg [4:0]  out_rt, out_rd ;
  reg [5:0] out_funct ;
  
  always @( posedge clk ) begin
        if ( rst ) begin
			out_RegDst <= 1'bx ;
			out_ALUSrc <= 1'bx ; 
			out_MemtoReg <= 1'bx ;  
			out_RegWrite <= 1'bx ;  
			out_MemRead <= 1'bx ; 
			out_MemWrite <= 1'bx ;  
			out_Branch <= 1'bx ; 
			out_Beq <= 1'bx ; 
			out_ALUOp  <= 2'bx ; 
			out_pc_incr  <= 32'bx ; 
			out_rfile_rd1  <= 32'bx ; 
			out_rfile_rd2  <= 32'bx ;  
			out_extend_immed <= 32'bx ;  
			out_rt <= 5'bx ; 
			out_rd <= 5'bx ; 
			out_funct <= 6'bx ;
		end
        else if ( en_reg ) begin
			out_RegDst <= RegDst ;
			out_ALUSrc <= ALUSrc ; 
			out_MemtoReg <= MemtoReg ;  
			out_RegWrite <= RegWrite ;  
			out_MemRead <= MemRead ; 
			out_MemWrite <= MemWrite ;  
			out_Branch <= Branch ; 
			out_Beq <= Beq ; 
			out_ALUOp  <= ALUOp ; 
			out_pc_incr  <= pc_incr ; 
			out_rfile_rd1  <= rfile_rd1 ; 
			out_rfile_rd2  <= rfile_rd2 ;  
			out_extend_immed <= extend_immed ;  
			out_rt <= rt; 
			out_rd <= rd ;
            out_funct <=  funct;			
		end
    end

endmodule
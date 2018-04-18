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
module reg_mem( clk, rst, en_reg, MemtoReg, RegWrite, dmem_rdata, alu_out, rfile_wn,
			   out_MemtoReg, out_RegWrite, out_dmem_rdata, out_alu_out, out_rfile_wn  ) ;
  input clk, rst, en_reg ;
  input MemtoReg, RegWrite ;
  input [31:0] alu_out, dmem_rdata ;
  input [4:0] rfile_wn ;
  
  output out_MemtoReg, out_RegWrite ;
  output [31:0] out_alu_out, out_dmem_rdata ;
  output [4:0] out_rfile_wn ;
  
  reg out_MemtoReg, out_RegWrite ;
  reg [31:0] out_alu_out, out_dmem_rdata ;
  reg [4:0] out_rfile_wn ;
  always @( posedge clk ) begin
        if ( rst ) begin
			out_MemtoReg <= 1'bx ;  
			out_RegWrite <= 1'bx ;  
			out_alu_out <= 32'bx ; 
			out_dmem_rdata <= 32'bx ;
			out_rfile_wn <= 32'bx ; 
		end
        else if ( en_reg ) begin
			out_MemtoReg <= MemtoReg ;  
			out_RegWrite <= RegWrite ;  
			out_alu_out <= alu_out ; 
			out_dmem_rdata <= dmem_rdata ;
			out_rfile_wn <= rfile_wn ; 
		end
    end

endmodule
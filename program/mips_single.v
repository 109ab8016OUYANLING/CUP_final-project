//	Title: MIPS Single-Cycle Processor
//	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
module mips_single( clk, rst );
	input clk, rst;
	
	// instruction bus
	wire[31:0] instr;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset;
	wire [31:0] sign_extend_immed, unsign_extend_immed ;
    wire [25:0] jumpoffset;
	
	// datapath signals
    wire [4:0] rfile_wn;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out, b_tgt, pc_next,
                pc, pc_incr, dmem_rdata, jump_addr, branch_addr;

	// control signals
    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Zero,Bgtz, Jump,Beq,ZeroSrc,BgtzSrc, Extend;
    wire [1:0] ALUOp;
    wire [3:0] Operation;
	
	
	//  for IF
	wire [31:0] out_pc_incr, out_instrc ;
	// for ID
	wire out_RegDst, out_ALUSrc, out_MemtoReg, out_RegWrite, out_MemRead, out_MemWrite,  out_Branch, out_Beq;
    wire [1:0] out_ALUOp;
    wire [31:0] out_out_pc_incr, out_rfile_rd1, out_rfile_rd2, out_extend_immed ;
    wire [4:0]  out_rt, out_rd ;
	wire [5:0] out_funct ;
	// for EX
	wire out_out_MemtoReg, out_out_RegWrite, out_out_MemRead, out_out_MemWrite, out_out_Branch, out_out_Beq, out_Zero, out_Bgtz ;
    wire [31:0]  out_b_tgt, out_alu_out, out_out_rfile_rd2 ;
	wire [4:0] out_rfile_wn ;
	// for MEM
	wire out_out_out_MemtoReg, out_out_out_RegWrite ;
    wire [31:0] out_out_alu_out, out_dmem_rdata  ;
	wire [4:0] out_out_rfile_wn ;
	
	
    assign opcode = out_instrc[31:26];
    assign rs = out_instrc[25:21];
    assign rt = out_instrc[20:16];
    assign rd = out_instrc[15:11];
    assign shamt = out_instrc[10:6];
    assign funct = out_instrc[5:0];
    assign immed = out_instrc[15:0];
    assign jumpoffset = out_instrc[25:0];
	
	// branch offset shifter
    assign b_offset = out_extend_immed << 2;
	
	// jump offset shifter & concatenation
	assign jump_addr = { out_pc_incr[31:28], jumpoffset <<2 };

	// module instantiations
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc) );
	// sign-extender
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(sign_extend_immed) );
	unsign_extend UnsignExt( .immed_in(immed), .ext_immed_out(unsign_extend_immed) ) ;
	
	mux2 #(32) EXTENDMUX( .sel(Extend), .a(sign_extend_immed), .b(unsign_extend_immed), .y(extend_immed) );
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) );

    add32 BRADD( .a(out_out_pc_incr), .b(b_offset), .result(b_tgt) );
	
    ALU_TOTAL ALU( .clk(clk),.signal(Operation), .dataA(out_rfile_rd1), .dataB(alu_b), .dataOut(alu_out), .zero(Zero) , .bgtz(Bgtz));
    //alu ALU( .ctl(Operation), .a(rfile_rd1), .b(alu_b), .result(alu_out), .zero(Zero) );

    and Zero_AND(ZeroSrc, out_out_Branch, out_Zero);
	and Bgtz_AND(BgtzSrc, out_out_Branch, out_Bgtz);
	
    mux2 #(1) BEQ( .sel(out_out_Beq), .b(ZeroSrc), .a(BgtzSrc), .y(PCSrc) );
	
    mux2 #(5) RFMUX( .sel(out_RegDst), .a(out_rt), .b(out_rd), .y(rfile_wn) );

    mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(out_b_tgt), .y(branch_addr) );
	
	mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) );
	
    mux2 #(32) ALUMUX( .sel(out_ALUSrc), .a(out_rfile_rd2), .b(out_extend_immed), .y(alu_b) );

    mux2 #(32) WRMUX( .sel(out_out_out_MemtoReg), .a(out_out_alu_out), .b(out_dmem_rdata), .y(rfile_wd) );
	
	reg_if InstrcFecch( .clk(clk), .rst(rst), .en_reg(1'b1), .pc_incr(pc_incr), .instrc(instr),
                    	.out_pc_incr( out_pc_incr), .out_instrc(out_instrc) ) ;
	
	
  
	reg_id InstrcDecode( .clk(clk), .rst(rst), .en_reg(1'b1), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), 
			   .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp(ALUOp), .Beq(Beq), .pc_incr(out_pc_incr), .rfile_rd1(rfile_rd1),
               .rfile_rd2(rfile_rd2), .extend_immed(extend_immed), .rt(rt), .rd(rd), .funct( funct ),
			   .out_RegDst(out_RegDst), .out_ALUSrc(out_ALUSrc), .out_MemtoReg(out_MemtoReg),
			   .out_RegWrite(out_RegWrite), .out_MemRead(out_MemRead), .out_MemWrite(out_MemWrite), .out_Branch(out_Branch), 
			   .out_ALUOp(out_ALUOp), .out_Beq(out_Beq), .out_pc_incr(out_out_pc_incr), .out_rfile_rd1(out_rfile_rd1),
               .out_rfile_rd2(out_rfile_rd2), .out_extend_immed(out_extend_immed), .out_rt(out_rt), .out_rd(out_rd), .out_funct(out_funct) ) ;
			   
			   
	
	reg_ex Excute( .clk(clk), .rst(rst), .en_reg(1'b1), .MemtoReg(out_MemtoReg), .RegWrite(out_RegWrite), 
			       .MemRead(out_MemRead), .MemWrite(out_MemWrite), .Branch(out_Branch), .Beq(out_Beq), .b_tgt(b_tgt), .zero(Zero),
				   .bgtz(Bgtz), .alu_out(alu_out), .RD2(out_rfile_rd2), .rfile_wn(rfile_wn),
			       .out_MemtoReg(out_out_MemtoReg), .out_RegWrite(out_out_RegWrite), .out_MemRead(out_out_MemRead),
			       .out_MemWrite(out_out_MemWrite), .out_Branch(out_out_Branch), .out_Beq(out_out_Beq), .out_b_tgt(out_b_tgt),
                   .out_zero(out_Zero), .out_bgtz(out_Bgtz), .out_alu_out(out_alu_out), .out_RD2(out_out_rfile_rd2), .out_rfile_wn(out_rfile_wn) ) ;
				   
				   
	
	reg_mem Memory( .clk(clk), .rst(rst), .en_reg(1'b1), .MemtoReg(out_out_MemtoReg), .RegWrite(out_out_RegWrite), .dmem_rdata(dmem_rdata),
                	.alu_out(out_alu_out), .rfile_wn(out_rfile_wn),
			        .out_MemtoReg(out_out_out_MemtoReg), .out_RegWrite(out_out_out_RegWrite),
					.out_dmem_rdata(out_dmem_rdata), .out_alu_out(out_out_alu_out), .out_rfile_wn(out_out_rfile_wn) ) ;
	
    control_single CTL(.opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp),.Beq(Beq),.Extend(Extend) );

					   
    alu_ctl ALUCTL( .ALUOp(out_ALUOp), .Funct(out_funct), .ALUOperation(Operation) );
	

	reg_file RegFile( .clk(clk), .RegWrite( out_out_out_RegWrite), .RN1(rs), .RN2(rt), .WN(out_out_rfile_wn), 
					  .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );

	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) );

	memory DatMem( .clk(clk), .MemRead(out_out_MemRead), .MemWrite(out_out_MemWrite), .wd(out_out_rfile_rd2), 
				   .addr(out_alu_out), .rd(dmem_rdata) );	   
				   
endmodule

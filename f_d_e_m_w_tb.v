module f_d_e_m_w_tb();
reg clk = 0;
integer i;
processor d0 (.clk(clk));

always 
	#10 clk = ~clk;

initial
begin
	for(i=0; i <= 5'd31; i=i+1'b1)
		d0.d3.d1.Rmem [i] = (i*2);
end

initial
begin
	for(i=0; i <= 10'd1023; i=i+1'b1)
		d0.d7.Dmem [i] = (i*3);
end

initial
begin 
	d0.d1.Imem[0] = 32'b0100_0000_0001_0001_1000_0001_0011_0011;
	d0.d1.Imem[1] = 32'b0000_0000_0101_0001_0111_0110_0011_0011;
	d0.d1.Imem[2] = 32'b0000_0000_0010_0011_0110_0110_1011_0011;
	d0.d1.Imem[3] = 32'b0000_0000_0010_0001_0111_0111_0011_0011;
	d0.d1.Imem[4] = 32'b0000_0000_1111_0001_0000_0000_1010_0011;
end


initial
begin
#1600
if (d0.d3.d1.Rmem[2] == 64'd4)
	$display("true");
else
	$display("false");

if (d0.d3.d1.Rmem[12] == 64'd0)
	$display("true");
else
	$display("false");

if (d0.d3.d1.Rmem[13] == 64'd12)
	$display("true");
else
	$display("false");

if (d0.d3.d1.Rmem[14] == 64'd4)
	$display("true");
else
	$display("false");

if (d0.d7.Dmem[5] == 64'd30)
	$display("true");
else
	$display("false");
end
endmodule








//////////////////test conditions/////////////////////////////

/*  Forwarding Output 
if (d3.d1.Rmem[2] == 64'd4)
	$display("true");
else
	$display("false");

if (d3.d1.Rmem[12] == 64'd0)
	$display("true");
else
	$display("false");

if (d3.d1.Rmem[13] == 64'd12)
	$display("true");
else
	$display("false");

if (d3.d1.Rmem[14] == 64'd4)
	$display("true");
else
	$display("false");

if (d7.Dmem[5] == 64'd30)
	$display("true");
else
	$display("false");
*/

/*
// All Instructions
if (d3.d1.Rmem[1] == 64'd10)
	$display("true");
else
	$display("false");

if (d3.d1.Rmem[4] == 64'd720)
	$display("true");
else
	$display("false");

if (d7.Dmem[23] == 64'd18)
	$display("true");
else
	$display("false");

if (d3.d1.Rmem[13] == 64'd4)
	$display("true");
else
	$display("false");

if (d3.d1.Rmem[17] == 64'd6)
	$display("true");
else
	$display("false");

if (d3.d1.Rmem[14] == 64'd2)
	$display("true");
else
	$display("false");
*/


/////////////////instruction set////////////////////////////////////


/*	All Instructions
	d1.Imem[0] = 32'b0000_0000_0011_0001_0000_0000_1011_0011;	//add rs1 2 rs2 3 wr 1  
	d1.Imem[1] = 32'b0000_1110_0110_0010_1111_0010_0000_0011;	//ld rs1 5 rs2 6 wr 4
	d1.Imem[2] = 32'b0000_0000_1001_0100_0000_0011_1010_0011;	//sd rs1 8 rs2 9 wr 7
	d1.Imem[3] = 32'b0000_0000_0010_0001_1111_0110_1011_0011;	//add rs1 15 rs2 14 wr 13
	d1.Imem[4] = 32'b0000_0000_0010_0001_1110_1000_1011_0011;
	d1.Imem[5] = 32'b0100_0000_1110_0111_1000_0111_0011_0011;
	d1.Imem[6] = 32'b0100_0000_1100_0110_0000_0101_0110_0011;	//beq rs1 11 rs2 12 wr 10
*/


/*	
	Forwarding Inst	
	d1.Imem[0] = 32'b0100_0000_0001_0001_1000_0001_0011_0011;
	d1.Imem[1] = 32'b0000_0000_0101_0001_0111_0110_0011_0011;
	d1.Imem[2] = 32'b0000_0000_0010_0011_0110_0110_1011_0011;
	d1.Imem[3] = 32'b0000_0000_0010_0001_0111_0111_0011_0011;
	d1.Imem[4] = 32'b0000_0000_1111_0001_0000_0000_1010_0011;

*/
/* 
	Hazard Detection Inst
	d1.Imem[0] = 32'b0000_0000_0000_0000_1000_0001_0000_0011;
	d1.Imem[1] = 32'b0000_0000_0101_0001_0111_0010_0011_0011;
	d1.Imem[2] = 32'b0000_0000_0110_0001_0110_0100_0011_0011; 
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////
/*
// o/p of fetch
wire [31:0] f_inst;
wire [11:0] f_pc;
wire [4:0] f_rs1;
wire [4:0] f_rs2;


// o/p of f-d reg
wire [31:0] fd_inst;
wire [11:0] fd_pc;

wire d_regwr;
wire [5:0] d_wr_reg;

// o/p of decode
wire [63:0] d_read_data1; 
wire [63:0] d_read_data2; 
wire d_alusrc; 
wire d_mem2reg; 
wire d_ctrl_regwr; 
wire d_memrd; 
wire d_memwr; 
wire d_branch;
wire [63:0] d_inst_out;
wire [3:0] d_alu_ctrl;
wire d_aluop1;
wire d_aluop2;
wire [5:0] d_wr_reg_o;
wire [4:0] d_rs1;
wire [4:0] d_rs2;

// o/p of d-e reg
wire [63:0] de_read_data1; 
wire [63:0] de_read_data2;  
wire de_alusrc; 
wire de_mem2reg; 
wire de_ctrl_regwr; 
wire de_memrd; 
wire de_memwr; 
wire de_branch;
wire [63:0] de_inst_out;
wire [3:0] de_alu_ctrl;
wire [5:0] de_wr_reg;
wire de_aluop1;
wire de_aluop2;
wire [11:0] de_pc;
wire [4:0] de_rs1;
wire [4:0] de_rs2;

// o/p of execute

wire e_zero;
wire [63:0] e_alu_out;
wire [11:0] e_pc_out;

// o/p of e-m reg

wire [63:0] em_read_data2; 
wire em_mem2reg;
wire em_ctrl_regwr;
wire em_memrd;
wire em_memwr;
wire em_branch;
wire [11:0] em_pc_out;
wire em_zero;
wire [63:0] em_alu_out;
wire [5:0] em_wr_reg;

// o/p of data_mem

wire [11:0] m_pc_out;
wire m_pcsrc;
wire [63:0] m_read_data;

// o/p mem_wb reg

wire [63:0] mw_read_data; 
wire mw_mem2reg;
wire mw_ctrl_regwr;
wire [5:0] mw_wr_reg;
wire [63:0] mw_alu_out;

// o/p of write_back 

wire [63:0] w_write_data;
wire [5:0] w_wrreg_o;
wire w_ctrl_regwr_o;

wire [1:0] esfsrs1;
wire [1:0] esfsrs2;

wire hdu_stall;
wire hdu_pcwr;

integer i;

fetch       d1  (.clk(clk), .f_pcsrc(m_pcsrc), .f_pcwr(hdu_pcwr), .f_pc_in(m_pc_out), .f_inst(f_inst), .f_pc(f_pc), .f_rs1(f_rs1), .f_rs2(f_rs2));
fet_dec     d2  (.clk(clk), .f_inst(f_inst), .f_pc(f_pc), .fd_inst(fd_inst), .fd_pc(fd_pc));
decode_main d3  (.clk(clk), .d_rs1(d_rs1), .d_rs2(d_rs2), .d_inst(fd_inst), .d_regwr(w_ctrl_regwr_o), .d_wr_reg(w_wrreg_o), .d_write_data(w_write_data), .d_read_data1(d_read_data1), .d_read_data2(d_read_data2), .d_alusrc(d_alusrc), .d_mem2reg(d_mem2reg), .d_ctrl_regwr(d_ctrl_regwr), .d_memrd(d_memrd), .d_memwr(d_memwr), .d_branch(d_branch), .d_aluop1(d_aluop1), .d_aluop2(d_aluop2), .d_inst_out(d_inst_out), .d_alu_ctrl(d_alu_ctrl), .d_wr_reg_o(d_wr_reg_o));
dec_exe     d4  (.clk(clk), .d_stall(hdu_stall), .d_rs1(d_rs1), .d_rs2(d_rs2), .de_rs1(de_rs1), .de_rs2(de_rs2), .d_inst_out(d_inst_out), .d_alu_ctrl(d_alu_ctrl), .d_wr_reg_o(d_wr_reg_o), .d_read_data1(d_read_data1), .d_read_data2(d_read_data2), .d_alusrc(d_alusrc), .d_mem2reg(d_mem2reg), .d_ctrl_regwr(d_ctrl_regwr), .d_memrd(d_memrd), .d_memwr(d_memwr), .d_branch(d_branch), .d_aluop1(d_aluop1), .d_aluop2(d_aluop2), .d_pc(fd_pc), .de_pc(de_pc), .de_read_data1(de_read_data1), .de_read_data2(de_read_data2), .de_alusrc(de_alusrc), .de_mem2reg(de_mem2reg), .de_ctrl_regwr(de_ctrl_regwr), .de_memrd(de_memrd), .de_memwr(de_memwr), .de_branch(de_branch), .de_aluop1(de_aluop1), .de_aluop2(de_aluop2),.de_wr_reg(de_wr_reg), .de_alu_ctrl(de_alu_ctrl), .de_inst_out(de_inst_out));
exe_main    d5  (.clk(clk), .e_read_data1_de(de_read_data1), .e_read_data2_de(de_read_data2), .e_read_data1_em(em_alu_out), .e_read_data2_em(em_alu_out), .e_read_data1_mw(w_write_data/*mw_read_data), .e_read_data2_mw(/*mw_read_dataw_write_data), .e_s1(esfsrs1), .e_s2(esfsrs2), .e_alusrc(de_alusrc), .e_inst_out(de_inst_out), .e_aluop1(de_aluop1), .e_aluop2(de_aluop2), .e_alu_ctrl(de_alu_ctrl), .e_pc(de_pc), .e_zero(e_zero), .e_alu_out(e_alu_out), .e_pc_out(e_pc_out));
exe_mem     d6  (.clk(clk), .e_mem2reg(de_mem2reg), .e_ctrl_regwr(de_ctrl_regwr), .e_memrd(de_memrd), .e_memwr(de_memwr), .e_branch(de_branch), .e_pc_out(e_pc_out), .e_zero(e_zero), .e_alu_out(e_alu_out), .e_read_data2(de_read_data2), .e_wr_reg(de_wr_reg), .em_read_data2(em_read_data2), .em_mem2reg(em_mem2reg), .em_ctrl_regwr(em_ctrl_regwr), .em_memrd(em_memrd), .em_memwr(em_memwr), .em_branch(em_branch), .em_pc_out(em_pc_out), .em_zero(em_zero), .em_wr_reg(em_wr_reg), .em_alu_out(em_alu_out));
data_memory d7  (.clk(clk), .m_branch(em_branch), .m_zero(em_zero), .m_addr(em_alu_out), .m_memwr(em_memwr), .m_memrd(em_memrd), .m_write_data(em_read_data2), .m_pc_in(em_pc_out), .m_pc_out(m_pc_out), .m_pcsrc(m_pcsrc), .m_read_data(m_read_data));
mem_wb      d8  (.clk(clk), .m_read_data(m_read_data), .m_mem2reg(em_mem2reg), .m_ctrl_regwr(em_ctrl_regwr), .m_alu_out(em_alu_out), .m_wr_reg(em_wr_reg), .mw_read_data(mw_read_data), .mw_mem2reg(mw_mem2reg), .mw_ctrl_regwr(mw_ctrl_regwr), .mw_wr_reg(mw_wr_reg), .mw_alu_out(mw_alu_out));
write_back  d9  (.clk(clk), .w_wrreg(mw_wr_reg), .w_ctrl_regwr(mw_ctrl_regwr), .w_ctrl_regwr_o(w_ctrl_regwr_o), .w_wrreg_o(w_wrreg_o), .w_read_data(mw_read_data), .w_alu_out(mw_alu_out), .w_mem2reg(mw_mem2reg), .w_write_data(w_write_data));
fu          d10 (.clk(clk), .em_ctrl_regwr(em_ctrl_regwr), .em_wr_reg(em_wr_reg), .mw_ctrl_regwr(mw_ctrl_regwr), .mw_wr_reg(mw_wr_reg), .de_rs1(de_rs1),  .de_rs2(de_rs2), .esfsrs1(esfsrs1), .esfsrs2(esfsrs2));
hdu         d11 (.clk(clk), .de_memrd(de_memrd), .de_wr_reg(de_wr_reg), .f_rs1(f_rs1), .f_rs2(f_rs2), .hdu_stall(hdu_stall), .hdu_pcwr(hdu_pcwr));
*/
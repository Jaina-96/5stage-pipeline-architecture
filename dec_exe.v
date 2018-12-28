module dec_exe (
input clk,
input [63:0] d_read_data1,
input [63:0] d_read_data2, 
input d_alusrc,
input d_mem2reg,
input d_ctrl_regwr,   //from ctrl block
input d_memrd,
input d_memwr,
input d_branch,
input d_aluop1,
input d_aluop2,
input [11:0] d_pc,
input [63:0] d_inst_out,
input [5:0] d_wr_reg_o,
input [3:0] d_alu_ctrl,
input [4:0] d_rs1,
input [4:0] d_rs2,
input  d_stall,
output [11:0] de_pc,
output [63:0] de_read_data1,
output [63:0] de_read_data2,
output [63:0] de_read_data_1,
output [63:0] de_read_data_2, 
output de_alusrc,
output de_mem2reg,
output de_ctrl_regwr,
output de_memrd,
output de_memwr,
output de_branch,
output de_aluop1,
output de_aluop2,
output [63:0] de_inst_out,
output [5:0] de_wr_reg,
output [3:0] de_alu_ctrl,
output [4:0] de_rs1,
output [4:0] de_rs2
);


reg [63:0] dec_exe_regmem [20:0];

always @(*)
begin
	if(d_stall == 1'b0)
 	begin
		dec_exe_regmem[0] <= d_alusrc;  
		dec_exe_regmem[1] <= d_mem2reg;
		dec_exe_regmem[2] <= d_ctrl_regwr;
		dec_exe_regmem[3] <= d_memrd;
		dec_exe_regmem[4] <= d_memwr;
		dec_exe_regmem[5] <= d_branch;
		dec_exe_regmem[6] <= d_aluop1;
		dec_exe_regmem[7] <= d_aluop2;
	end
	else if(d_stall == 1'b1)
	begin
 		dec_exe_regmem[0] <= 64'dx;  
 		dec_exe_regmem[1] <= 64'dx;  
 		dec_exe_regmem[2] <= 64'dx;  
 		dec_exe_regmem[3] <= 64'dx;  
 		dec_exe_regmem[4] <= 64'dx;  
 		dec_exe_regmem[5] <= 64'dx;  
 		dec_exe_regmem[6] <= 64'dx;  
 		dec_exe_regmem[7] <= 64'dx;  
	end
	dec_exe_regmem[8]  <= d_read_data1;
	dec_exe_regmem[9]  <= d_read_data2;
	dec_exe_regmem[10] <= d_inst_out;
	dec_exe_regmem[11] <= d_wr_reg_o;
	dec_exe_regmem[12] <= d_alu_ctrl;
	dec_exe_regmem[14] <= d_rs1;
	dec_exe_regmem[15] <= d_rs2;
	
end

always @(posedge clk)
begin
	dec_exe_regmem[13] <= d_pc;
end

assign de_alusrc      = dec_exe_regmem[0];
assign de_mem2reg     = dec_exe_regmem[1]; 
assign de_ctrl_regwr  = dec_exe_regmem[2];
assign de_memrd       = dec_exe_regmem[3];
assign de_memwr       = dec_exe_regmem[4];
assign de_branch      = dec_exe_regmem[5];
assign de_aluop1      = dec_exe_regmem[6];
assign de_aluop2      = dec_exe_regmem[7];
assign de_read_data1  = dec_exe_regmem[8];
assign de_read_data2  = dec_exe_regmem[9];
assign de_read_data_1 = dec_exe_regmem[8];
assign de_read_data_2 = dec_exe_regmem[9];
assign de_inst_out    = dec_exe_regmem[10];
assign de_wr_reg      = dec_exe_regmem[11];
assign de_alu_ctrl    = dec_exe_regmem[12];
assign de_pc          = dec_exe_regmem[13];
assign de_rs1         = dec_exe_regmem[14];
assign de_rs2         = dec_exe_regmem[15];
endmodule
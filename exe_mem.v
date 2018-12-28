module exe_mem (
input clk,
input e_mem2reg,
input e_ctrl_regwr,
input e_memrd,
input e_memwr,
input e_branch,
input [11:0] e_pc_out,
input e_zero,
input [63:0] e_alu_out,
input [63:0] e_read_data2,
input [5:0] e_wr_reg,

output [63:0] em_read_data2, 
output em_mem2reg,
output em_ctrl_regwr,
output em_memrd,
output em_memwr,
output em_branch,
output [11:0] em_pc_out,
output em_zero,
output [5:0] em_wr_reg,
output [63:0] em_alu_out);


reg [63:0] exe_mem_regmem [9:0];

always @(*)
begin
	exe_mem_regmem[5]  <= e_zero;
	exe_mem_regmem[6]  <= e_alu_out;
	exe_mem_regmem[8]  <= e_pc_out;	
end

always @(posedge clk)
begin
 	exe_mem_regmem[0]  <= e_mem2reg;
	exe_mem_regmem[1]  <= e_ctrl_regwr;
	exe_mem_regmem[2]  <= e_memrd;
	exe_mem_regmem[3]  <= e_memwr;
	exe_mem_regmem[4]  <= e_branch;
	exe_mem_regmem[7]  <= e_read_data2;
	exe_mem_regmem[9]  <= e_wr_reg;
end

assign em_mem2reg    = exe_mem_regmem[0]; 
assign em_ctrl_regwr = exe_mem_regmem[1];
assign em_memrd      = exe_mem_regmem[2];
assign em_memwr      = exe_mem_regmem[3];
assign em_branch     = exe_mem_regmem[4];
assign em_zero       = exe_mem_regmem[5];
assign em_alu_out    = exe_mem_regmem[6];
assign em_read_data2 = exe_mem_regmem[7];
assign em_pc_out     = exe_mem_regmem[8];
assign em_wr_reg     = exe_mem_regmem[9];
endmodule

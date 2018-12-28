module decode_main (
input  clk,
input  [31:0] d_inst, 
input  d_regwr,
input  [63:0] d_write_data, 
input  [5:0] d_wr_reg,
output [63:0] d_read_data1, 
output [63:0] d_read_data2, 
output d_alusrc, 
output d_mem2reg, 
output d_ctrl_regwr, 
output d_memrd, 
output d_memwr, 
output d_branch, 
output d_aluop1, 
output d_aluop2,
output [63:0] d_inst_out,
output [3:0] d_alu_ctrl,
output [5:0] d_wr_reg_o,
output [4:0] d_rs1,
output [4:0] d_rs2
);

wire [63:0] w1,w2,w3;

decode d1 (.clk(clk), .rs1(d_rs1), .rs2(d_rs2), .inst(d_inst), .read_data1(d_read_data1), .read_data2(d_read_data2), .write_data(d_write_data), .wr_reg(d_wr_reg), .alu_ctrl(d_alu_ctrl), .wr_reg_o(d_wr_reg_o), .regwr(d_regwr));
control_blk d2(.clk(clk), .inst(d_inst), .alusrc(d_alusrc), .mem2reg(d_mem2reg), .regwr(d_ctrl_regwr), .memrd(d_memrd), .memwr(d_memwr), .branch(d_branch), .aluop1(d_aluop1), .aluop2(d_aluop2));
imm_gen d3(.clk(clk), .inst(d_inst), .inst_out(d_inst_out));
endmodule 
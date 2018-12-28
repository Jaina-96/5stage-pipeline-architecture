module mem_wb (
input clk,
input [63:0] m_read_data, 
input m_mem2reg,
input m_ctrl_regwr,
input [63:0] m_alu_out,
input [5:0] m_wr_reg,

output [63:0] mw_read_data, 
output mw_mem2reg,
output mw_ctrl_regwr,
output [5:0] mw_wr_reg,
output [63:0] mw_alu_out
);


reg [63:0] mem_wb_regmem [4:0];
always @(*)
begin
	mem_wb_regmem[3]  <= m_read_data;
end


always @(posedge clk)
begin
 	mem_wb_regmem[0]  <= m_mem2reg;
	mem_wb_regmem[1]  <= m_ctrl_regwr;
	mem_wb_regmem[2]  <= m_alu_out;
	mem_wb_regmem[4]  <= m_wr_reg;
end

assign mw_mem2reg    = mem_wb_regmem[0]; 
assign mw_ctrl_regwr = mem_wb_regmem[1];
assign mw_alu_out    = mem_wb_regmem[2];
assign mw_read_data  = mem_wb_regmem[3];
assign mw_wr_reg     = mem_wb_regmem[4];
endmodule

module write_back (
input clk,
input [63:0] w_read_data,
input [63:0] w_alu_out,
input w_mem2reg,
input [5:0] w_wrreg,
input w_ctrl_regwr,
output w_ctrl_regwr_o,
output [63:0] w_write_data,
output [5:0] w_wrreg_o 
);

reg [63:0] wd;
reg [5:0] wr_reg;
reg cwr;

always @(posedge clk)
begin
	wr_reg = w_wrreg;
	cwr = w_ctrl_regwr;
end
always @(negedge clk)
begin

	if(w_mem2reg == 1'b1)
		wd = w_read_data;
	else
		wd = w_alu_out;
end

assign w_ctrl_regwr_o = cwr;
assign w_wrreg_o = wr_reg;
assign w_write_data = wd;
endmodule


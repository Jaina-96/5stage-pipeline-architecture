module exe_addsum (clk, pc, inst_out, pc_out);
input  clk;
input  [11:0] pc;
input  [63:0] inst_out;
output [11:0] pc_out;
reg    [11:0] pc_o;

wire [11:0] io;
assign io = inst_out[11:0];

always @(posedge clk)
	pc_o <= pc + (io << 1);
 
assign pc_out = pc_o;
endmodule 

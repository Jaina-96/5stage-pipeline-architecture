module fet_dec (clk, f_inst, f_pc, fd_inst, fd_pc);

input clk;
input [31:0] f_inst;
input [11:0] f_pc;
output [11:0] fd_pc;
output [31:0] fd_inst;

reg [31:0] fet_dec [1:0];

always @(*)
begin
	fet_dec[0] <= f_inst;
	fet_dec[1] <= f_pc;
end
/*
always @(f_pc)
begin
	fet_dec[1] <= f_pc;
end
*/

assign fd_inst = fet_dec[0];
assign fd_pc = fet_dec[1];

endmodule

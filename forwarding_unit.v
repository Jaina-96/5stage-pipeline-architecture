module fu(
input clk,
input em_ctrl_regwr,
input [5:0] em_wr_reg,
input mw_ctrl_regwr,
input [5:0] mw_wr_reg,
input [4:0] de_rs1,
input [4:0] de_rs2,

output [1:0] esfsrs1,
output [1:0] esfsrs2
);


reg [1:0] s1 = 2'd0;
reg [1:0] s2 = 2'd0;

always @(*)
begin
	if((em_ctrl_regwr == 1'b1) && (em_wr_reg != 6'd0) && (em_wr_reg[4:0] == de_rs1))
 		s1 <= 2'b10;
	else 
		s1 <= 2'b00;
	if((em_ctrl_regwr == 1'b1) && (em_wr_reg != 6'd0) && (em_wr_reg[4:0] == de_rs2))
 		s2 <= 2'b10;
	else 
		s2 <= 2'b00;
	if((mw_ctrl_regwr == 1'b1) && (mw_wr_reg != 6'd0) && (mw_wr_reg[4:0] == de_rs1))
 		s1 <= 2'b01;
	else 
		s1 <= 2'b00;
	if((mw_ctrl_regwr == 1'b1) && (mw_wr_reg != 6'd0) && (mw_wr_reg[4:0] == de_rs2))
 		s2 <= 2'b01;
	else 
		s2 <= 2'b00;	
end

assign esfsrs1 = s1;
assign esfsrs2 = s2;

endmodule 
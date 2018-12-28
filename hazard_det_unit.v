module hdu(
input clk,
input de_memrd,
input [5:0] de_wr_reg,
input [4:0] f_rs1,
input [4:0] f_rs2,
output hdu_stall,
output hdu_pcwr
);

reg s1 = 1'b0;
reg s2 = 1'b0;

always @(posedge clk)
begin 
	if((de_memrd == 1'b1) && ((de_wr_reg[4:0] == f_rs1) || (de_wr_reg[4:0] == f_rs2)))
	begin
		s1 <= 1'b1;
		s2 <= 1'b1;
	end
	else
	begin
		s1 <= 1'b0;
		s2 <= 1'b0;
	end 
end/*
initial 
begin
hdu_stall <= 1'b0;
hdu_pcwr <= 1'b0;
end*/
assign hdu_stall = s1;//((de_memrd == 1'b1) && ((de_wr_reg[4:0] == f_rs1) || (de_wr_reg[4:0] == f_rs2))) ? 1'b1 : s1;
assign hdu_pcwr = s2;//((de_memrd == 1'b1) && ((de_wr_reg[4:0] == f_rs1) || (de_wr_reg[4:0] == f_rs2))) ? 1'b1 : s2;
endmodule 
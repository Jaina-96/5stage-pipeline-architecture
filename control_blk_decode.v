module control_blk (clk, inst, alusrc, mem2reg, regwr, memrd, memwr, branch, aluop1, aluop2);
input clk;
input [31:0] inst;
output alusrc;
output mem2reg;
output regwr;
output memrd;
output memwr;
output branch;
output aluop1;
output aluop2;

reg w1,w2,w3,w4,w5,w6,w7,w8;

always @(posedge clk)  
case (inst[6:0])
7'b0110011 : 	
	begin
		 w1 <= 1'b0;
		 w2 <= 1'b0;
		 w3 <= 1'b1;
		 w4 <= 1'b0;
		 w5 <= 1'b0;
		 w6 <= 1'b0;
		 w7 <= 1'b1;
		 w8 <= 1'b0;
	end
7'b0000011 : 
	begin
		 w1 <= 1'b1;
		 w2 <= 1'b1;
		 w3 <= 1'b1;
		 w4 <= 1'b1;
		 w5 <= 1'b0;
		 w6 <= 1'b0;
		 w7 <= 1'b0;
		 w8 <= 1'b0;
	end
7'b0100011 : 
	begin
		 w1 <= 1'b1;
		 w2 <= 1'bx;
		 w3 <= 1'b0;
		 w4 <= 1'b0;
		 w5 <= 1'b1;
		 w6 <= 1'b0;
		 w7 <= 1'b0;
		 w8 <= 1'b0;
	end
7'b1100011 : 
	begin
		 w1 <= 1'b0;
		 w2 <= 1'bx;
		 w3 <= 1'b0;
		 w4 <= 1'b0;
		 w5 <= 1'b0;
		 w6 <= 1'b1;
		 w7 <= 1'b0;
		 w8 <= 1'b1;
	end

default : 
	begin
		 w1 <= 1'bz;
		 w2 <= 1'bz;
		 w3 <= 1'bz;
		 w4 <= 1'bz;
		 w5 <= 1'bz;
		 w6 <= 1'bz;
		 w7 <= 1'bz;
		 w8 <= 1'bz;
	end
endcase

assign alusrc  = w1;
assign mem2reg = w2;
assign regwr   = w3;
assign memrd   = w4;
assign memwr   = w5;
assign branch  = w6;
assign aluop1  = w7;
assign aluop2  = w8;

endmodule

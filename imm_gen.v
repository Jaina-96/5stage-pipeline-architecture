module imm_gen (clk, inst, inst_out);
input clk; 
input [31:0] inst;
output [63:0] inst_out;

wire [63:0] data1;
wire [63:0] data2;
wire [63:0] data3;
reg [63:0] data;

assign	data1 = {52'd0,inst[31:20]}; //load
assign	data2 = {52'd0,inst[31:25],inst[11:7]}; // store
assign	data3 = {52'd0,inst[31],inst[7],inst[30:25],inst[11:6]}; // branch

always@ (posedge clk)
begin
	
	
	if (inst[6:0] == 7'b0000011)
		data <= data1;
 	else if (inst[6:0] == 7'b0100011)
		data <= data2;
	else if (inst[6:0] == 7'b1100011)
		data <= data3;
	else
		data <= 64'd0;
end
assign inst_out = data;
endmodule 



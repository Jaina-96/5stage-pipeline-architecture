module exe_main 
(
input clk,
input [63:0] e_read_data1_de,
input [63:0] e_read_data2_de,
input [63:0] e_read_data1_mw,
input [63:0] e_read_data2_mw,
input [63:0] e_read_data1_em,
input [63:0] e_read_data2_em,
input [1:0] e_s1,
input [1:0] e_s2,
input e_alusrc,
input [63:0] e_inst_out,
input e_aluop1,
input e_aluop2,
input [3:0] e_alu_ctrl,
input [11:0] e_pc,
output e_zero,
output [63:0] e_alu_out,
output [11:0] e_pc_out
);


reg [63:0] alu_o;
reg alu_z; 
wire [63:0] data2;
reg zero;
reg b;
wire [5:0] a1;

wire [63:0] e_read_data1;
wire [63:0] e_read_data2;

exe_addsum e2 (.clk(clk), .pc(e_pc), .inst_out(e_inst_out), .pc_out(e_pc_out));
exe_mux e1 (.read_data1_de(e_read_data1_de), .read_data2_de(e_read_data2_de), .read_data1_em(e_read_data1_em), .read_data2_em(e_read_data2_em), .read_data1_mw(e_read_data1_mw), .read_data2_mw(e_read_data2_mw), .read_data1(e_read_data1), .read_data2(e_read_data2), .s1(e_s1), .s2(e_s2));

assign a1 = {e_alu_ctrl[3:0], e_aluop1, e_aluop2};
assign data2 = e_alusrc ? e_inst_out : e_read_data2;
	
always @(posedge clk)
begin 	
	if(a1[1:0] == 2'b00)
		alu_o <= e_read_data1 + data2;
	else if (a1[1:0] == 2'b01)
		alu_o <= e_read_data1 - data2;
	else if (a1 == 6'b000010)
		alu_o <= e_read_data1 + data2;
	else if (a1 == 6'b100010)
		alu_o <= e_read_data1 - data2;
	else if (a1 == 6'b011110)
		alu_o <= e_read_data1 & data2;
	else if (a1 == 6'b011010)
		alu_o <= e_read_data1 | data2;
        else 
                alu_o <= 64'd0;
	zero <= (e_read_data1 - data2) ? 1'b0 : 1'b1;
end

assign e_zero = zero;
assign e_alu_out = alu_o;
endmodule



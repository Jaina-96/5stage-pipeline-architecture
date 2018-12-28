module exe_mux (
input [63:0] read_data1_de,
input [63:0] read_data2_de,
input [63:0] read_data1_mw,
input [63:0] read_data2_mw,
input [63:0] read_data1_em,
input [63:0] read_data2_em,
input [1:0] s1,
input [1:0] s2,
output [63:0] read_data1,
output [63:0] read_data2);

reg [63:0] rd1;
reg [63:0] rd2;

always @(*)
begin
	case(s1) 
	2'b00: rd1 = read_data1_de; 
	2'b10: rd1 = read_data1_em; 
	2'b01: rd1 = read_data1_mw;
	endcase
	
	case(s2) 
	2'b00: rd2 = read_data2_de; 
	2'b10: rd2 = read_data2_em; 
	2'b01: rd2 = read_data2_mw;
	endcase
end

assign read_data1 = rd1; 
assign read_data2 = rd2;

endmodule 
module decode(clk, rs1, rs2, inst, read_data1, read_data2, write_data, wr_reg, alu_ctrl, regwr, wr_reg_o);

input  clk;
input  [31:0] inst; 
input  [63:0] write_data;
input  [5:0] wr_reg;
input  regwr;
output [63:0] read_data1; 
output [63:0] read_data2;
output [3:0] alu_ctrl;
output [5:0] wr_reg_o;
output [4:0] rs1;
output [4:0] rs2;


reg [4:0] rs_1;
reg [4:0] rs_2;
reg [5:0] wr_o;
reg [3:0] aluctrl;
reg [63:0] wd;
reg [63:0] Rmem [31:0]; 

always @(posedge clk)
begin 
	rs_1  <= inst[19:15];
	rs_2  <= inst[24:20];
	wr_o <= {1'b0,inst[11:7]};
	aluctrl <= {inst[30],inst[14:12]}; 
end
always @(negedge clk)
begin 
	if(regwr == 1'b1)	
		begin
		Rmem[wr_reg] <= write_data;
		end
end

assign rs1 = rs_1;
assign rs2 = rs_2;
assign wr_reg_o = wr_o;
assign read_data1 = Rmem[rs1]; 
assign read_data2 = Rmem[rs2]; 
assign alu_ctrl = aluctrl;

endmodule

module fetch (clk, f_pcwr, f_pc_in, f_pcsrc, f_inst, f_pc, f_rs1, f_rs2);

input clk;
input f_pcsrc;
input f_pcwr;
input [11:0] f_pc_in;
output [31:0] f_inst;
output [11:0] f_pc;
output [4:0] f_rs1;
output [4:0] f_rs2;

reg [31:0] Imem [0:4095];
reg [31:0] d_inst;  
reg [11:0] addr;


initial 
begin
addr = 0;
end 

reg [4:0] rs1;
reg [4:0] rs2;

/*always @(f_pcwr)
begin
	if (f_pcwr == 1'b1)
	begin
	
	rs1  <= Imem[addr - 12'd2][19:15];
	rs2  <= Imem[addr - 12'd2][24:20];
	d_inst <= Imem[addr - 12'd2];
	
	end
end

	*/
always@(posedge clk)
begin 
	if(f_pcsrc == 1'b1)
	begin
	addr <= f_pc_in;
	rs1 <= Imem[addr][19:15];
	rs2 <= Imem[addr][24:20];
	d_inst <= Imem[addr];
	end
	
	else if((f_pcwr != 1'b1) && (f_pcsrc == 1'b0))
	begin
	addr <= addr + 12'd1;
	rs1 <= Imem[addr][19:15];
	rs2 <= Imem[addr][24:20];
	d_inst <= Imem[addr];
	end
end	

assign f_rs1 = (f_pcwr == 1'b1) ? Imem[addr - 12'd2][19:15] : rs1;
assign f_rs2 = (f_pcwr == 1'b1) ? Imem[addr - 12'd2][24:20] : rs2;
assign f_pc = (f_pcwr == 1'b1)? (addr-12'd1) : addr;
assign f_inst =(f_pcwr == 1'b1)? Imem[addr - 12'd2] : d_inst;

endmodule


  


/*

if(f_pcsrc == 1'b1)
	begin
	addr <= f_pc_in;  // jump by imm value
	rs1 <= Imem[addr][19:15];
	rs2 <= Imem[addr][24:20];
	d_inst <= Imem[addr];
	end
	else if ((f_pcwr == 1'b0) && (f_pcsrc == 1'b0))
	begin
	addr <= addr + 1'b1;


	rs1 <= Imem[addr][19:15];
	rs2 <= Imem[addr][24:20];
	d_inst <= Imem[addr];
	end
	else if (f_pcwr == 1'b1)
	begin
	addr <= addr - 1'b1;
	rs1 = Imem[addr][19:15];
	rs2 = Imem[addr][24:20];
	d_inst = Imem[addr];
	end
*/
module data_memory(
input clk,
input  m_branch,
input  m_zero,
input  [63:0] m_addr, 				//aluout
input  m_memwr,
input  m_memrd,
input  [63:0] m_write_data, 			//readdata2
input  [11:0] m_pc_in,                         //pc for branch
output [11:0] m_pc_out,
output  m_pcsrc,
output [63:0] m_read_data
);

reg [63:0] Dmem [1023:0];
reg [63:0] r_data;
reg pcsrc = 1'b0;
reg [11:0] pc_out;

always @(posedge clk)
begin
 pc_out <= m_pc_in;	
 
  if((m_branch & m_zero) == 1'b1)
	pcsrc <= 1'b1;
  else
	pcsrc <= 1'b0;

if(m_memrd == 1'b1)
	begin 
		r_data <= Dmem[m_addr];
	end

end

always @(negedge clk)
begin
 
  if(m_memwr == 1'b1)
	begin
		Dmem[m_addr] <= m_write_data;
		r_data <= 64'd0; 
	end

end

assign m_read_data = r_data;  
assign m_pcsrc = pcsrc;
assign m_pc_out = pc_out;
endmodule 
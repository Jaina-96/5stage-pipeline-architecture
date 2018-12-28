module processor(input clk);

// o/p of fetch
wire [31:0] f_inst;
wire [11:0] f_pc;
reg f_pcsrc;

// o/p of f-d reg
wire [31:0] fd_inst;
wire [11:0] fd_pc;


//reg  [63:0] write_data; 
wire d_regwr;
wire [4:0] d_wr_reg;

// o/p of decode
wire [63:0] d_read_data1; 
wire [63:0] d_read_data2; 
wire d_alusrc; 
wire d_mem2reg; 
wire d_ctrl_regwr; 
wire d_memrd; 
wire d_memwr; 
wire d_branch;
wire [11:0] d_inst_out;
wire [3:0] d_alu_ctrl;
wire d_aluop1;
wire d_aluop2;

// o/p of d-e reg
wire [63:0] de_read_data1; 
wire [63:0] de_read_data2; 
wire de_alusrc; 
wire de_mem2reg; 
wire de_ctrl_regwr; 
wire de_memrd; 
wire de_memwr; 
wire de_branch;
wire [11:0] de_inst_out;
wire [3:0] de_alu_ctrl;
wire [4:0] de_wr_reg;
wire de_aluop1;
wire de_aluop2;
wire [11:0] de_pc;

// o/p of execute

wire e_zero;
wire [63:0] e_alu_out;
wire [11:0] e_pc_out;

// o/p of e-m reg

wire [63:0] em_read_data2; 
wire em_mem2reg;
wire em_ctrl_regwr;
wire em_memrd;
wire em_memwr;
wire em_branch;
wire [11:0] em_pc_out;
wire em_zero;
wire [63:0] em_alu_out;
wire [4:0] em_wr_reg;

// o/p of data_mem

wire [11:0] m_pc_out;
wire m_pcsrc;
wire [63:0] m_read_data;

// o/p mem_wb reg

wire [63:0] mw_read_data; 
wire mw_mem2reg;
wire mw_ctrl_regwr;
wire [4:0] mw_wr_reg;
wire [63:0] mw_alu_out;
//wire mw_pcsrc;

// o/p of write_back 

wire [63:0] w_write_data;

fetch       d1 (.clk(clk), .f_pcsrc(mw_pcsrc), .f_pc_in(m_pc_out), .f_inst(f_inst), .f_pc(f_pc));
fet_dec     d2 (.clk(clk), .f_inst(f_inst), .f_pc(f_pc), .fd_inst(fd_inst), .fd_pc(fd_pc));
decode_main d3 (.clk(clk), .d_inst(fd_inst), .d_regwr(mw_ctrl_regwr), .d_wr_reg(mw_wr_reg), .d_write_data(w_write_data), .d_read_data1(d_read_data1), .d_read_data2(d_read_data2), .d_alusrc(d_alusrc), .d_mem2reg(d_mem2reg), .d_ctrl_regwr(d_ctrl_regwr), .d_memrd(d_memrd), .d_memwr(d_memwr), .d_branch(d_branch), .d_aluop1(d_aluop1), .d_aluop2(d_aluop2), .d_inst_out(d_inst_out), .d_alu_ctrl(d_alu_ctrl));
dec_exe     d4 (.clk(clk), .d_inst(fd_inst), .d_read_data1(d_read_data1), .d_read_data2(d_read_data2), .d_alusrc(d_alusrc), .d_mem2reg(d_mem2reg), .d_ctrl_regwr(d_ctrl_regwr), .d_memrd(d_memrd), .d_memwr(d_memwr), .d_branch(d_branch), .d_aluop1(d_aluop1), .d_aluop2(d_aluop2), .d_pc(fd_pc), .de_pc(de_pc), .de_read_data1(de_read_data1), .de_read_data2(de_read_data2), .de_alusrc(de_alusrc), .de_mem2reg(de_mem2reg), .de_ctrl_regwr(de_ctrl_regwr), .de_memrd(de_memrd), .de_memwr(de_memwr), .de_branch(de_branch), .de_aluop1(de_aluop1), .de_aluop2(de_aluop2),.de_wr_reg(de_wr_reg), .de_alu_ctrl(de_alu_ctrl), .de_inst_out(de_inst_out));
exe_main    d5 (.clk(clk), .e_read_data1(de_read_data1), .e_read_data2(de_read_data2), .e_alusrc(de_alusrc), .e_inst_out(de_inst_out), .e_aluop1(de_aluop1), .e_aluop2(de_aluop2), .e_alu_ctrl(de_alu_ctrl), .e_pc(de_pc), .e_zero(e_zero), .e_alu_out(e_alu_out), .e_pc_out(e_pc_out));
exe_mem     d6 (.clk(clk), .e_mem2reg(de_mem2reg), .e_ctrl_regwr(de_ctrl_regwr), .e_memrd(de_memrd), .e_memwr(de_memwr), .e_branch(de_branch), .e_pc_out(e_pc_out), .e_zero(e_zero), .e_alu_out(e_alu_out), .e_read_data2(de_read_data2), .e_wr_reg(de_wr_reg), .em_read_data2(em_read_data2), .em_mem2reg(em_mem2reg), .em_ctrl_regwr(em_ctrl_regwr), .em_memrd(em_memrd), .em_memwr(em_memwr), .em_branch(em_branch), .em_pc_out(em_pc_out), .em_zero(em_zero), .em_wr_reg(em_wr_reg), .em_alu_out(em_alu_out));
data_memory d7 (.clk(clk), .m_branch(em_branch), .m_zero(em_zero), .m_addr(em_alu_out), .m_memwr(em_memwr), .m_memrd(em_memrd), .m_write_data(em_read_data2), .m_pc_in(em_pc_out), .m_pc_out(m_pc_out), .m_pcsrc(m_pcsrc), .m_read_data(m_read_data));
mem_wb      d8 (.clk(clk), .m_pcsrc(m_pcsrc), .m_read_data(m_read_data), .m_mem2reg(em_mem2reg), .m_ctrl_regwr(em_ctrl_regwr), .m_alu_out(em_alu_out), .m_wr_reg(em_wr_reg), .mw_pcsrc(mw_pcsrc), .mw_read_data(mw_read_data), .mw_mem2reg(mw_mem2reg), .mw_ctrl_regwr(mw_ctrl_regwr), .mw_wr_reg(mw_wr_reg), .mw_alu_out(mw_alu_out));
write_back  d9 (.clk(clk), .w_read_data(mw_read_data), .w_alu_out(mw_alu_out), .w_mem2reg(mw_mem2reg), .w_write_data(w_write_data));

endmodule 
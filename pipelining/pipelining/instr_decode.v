`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:13 11/02/2019 
// Design Name: 
// Module Name:    instr_decode 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module instr_decode( input clk,input [31:0]indata,input we_rf,input reg[63:0] reg_if_id, 
output reg[149:0] reg_id_ex);

wire [31:0] instr,pc;
wire [31:0] rv1,rv2; 
reg [4:0] rs1,rs2,rd;
reg [5:0] opcode;
reg [31:0] imm;
reg ctrl_we;

assign pc = reg_if_id[31:0];
assign instr = reg_if_id[63:32];

rf_file rf(.clk(clk),.rs1(rs1),.rs2(rs2),.rd(rd),
                       .we(we_rf),.indata(indata),.rv1(rv1),.rv2(rv2));

always @(*)
begin
	
	//Write enable signal for present instruction 
	if (instr[6:0] == 7'b1100011 || instr[6:0] == 7'b0100011) begin ctrl_we<= 1'b0; end	
	else begin ctrl_we<=1'b1; end
	
	rs2 <= instr[24:20];
	rs1 <= instr[19:15];
	rd <= instr[11:7];
	imm<=0;
	opcode<=0;
		case (instr[6:0])
			7'b0110111 : begin imm <= instr & 32'hfffff000;opcode <=0;end//LUI
			7'b0010111 : begin imm <= instr & 32'hfffff000;opcode <=1;end//AUIPC
			7'b1101111 : begin imm <= {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};opcode<=2;end//JAL
			7'b1100111 : begin if(instr[14:12]==3'b0) begin imm <= {{20{instr[31]}},instr[31:20]};opcode<=3;end else begin imm<=0;opcode<=0;end end//JALR
			7'b1100011 : begin imm <= {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0}; 
								case(instr[14:12]) 
									3'b000 : opcode<=4;//BEQ
									3'b001 : opcode<=5;//BNE 
									3'b100 : opcode<=6;//BLT
									3'b101 : opcode<=7;//BGE
									3'b110 : opcode<=8;//BLTU
									3'b111 : opcode<=9;//BGEU
								endcase
							 end	
			7'b0000011 : begin imm <= {{20{instr[31]}},instr[31:20]};
								case(instr[14:12])  
									3'b000 : opcode <=10;//LB
									3'b001 : opcode <=11;//LH
									3'b010 : opcode <=12;//LW
									3'b100 : opcode <=13;//LBU
									3'b101 : opcode <=14;//LHU
								endcase
							 end	
			7'b0100011 : begin imm <= {{20{instr[31]}},instr[31:25],instr[11:7]};
								case(instr[14:12]) 
									3'b000 : opcode <=15;//SB
									3'b001 : opcode <=16;//SH
									3'b010 : opcode <=17;//SW
								endcase	
							 end		
			7'b0010011 : begin imm <= {{20{instr[31]}},instr[31:20]};
								case(instr[14:12]) 
									3'b000 : opcode<=18;//ADDI
									3'b010 : opcode<=19;//SLTI
									3'b011 : begin imm<= {{20'b0},instr[31:20]};opcode<=20;end//SLTIU
									3'b100 : begin imm<= {{20'b0},instr[31:20]};opcode<=21;end//XORI
									3'b110 : begin imm<= {{20'b0},instr[31:20]};opcode<=22;end//ORI
									3'b111 : begin imm<= {{20'b0},instr[31:20]};opcode<=23;end//ANDI
								endcase
							 end	
			7'b0010011 : begin imm <= {27'b0,instr[24:20]};
								case(instr[14:12]) 
									3'b001 : opcode<=24;//SLLI
									3'b101 : begin case(instr[31:25])
															7'b0000000 : opcode <=25;//SLRI
															7'b0100000 : opcode <=26;//SRAI
														endcase
												end			
								endcase
							 end
			7'b0110011 : begin imm<=32'b0;
								case(instr[14:12])
									3'b000 : begin case(instr[31:25])  
															7'b0000000 : opcode<=27;//ADD
															7'b0100000 : opcode<=28;//SUB
														endcase
												end
									3'b001 : opcode<=29;//SLL
									3'b010 : opcode<=30;//SLT
									3'b011 : opcode<=31;//SLTU
									3'b100 : opcode<=32;//XOR	
									3'b101 : begin case(instr[31:25])  
															7'b0000000 : opcode<=33;//SRL
															7'b0100000 : opcode<=34;//SRA
														endcase
												end
									3'b110 : opcode<=35;//OR
									3'b111 : opcode<=36;//AND
								endcase		
							 end	
		endcase
end

always @(posedge clk)
	begin 
		reg_id_ex[31:0]<= pc;//output
		reg_id_ex[63:32]<=imm;
		reg_id_ex[69:64]<=opcode;
		reg_id_ex[74:70]<=rs1;
		reg_id_ex[79:75]<=rs2;
		reg_id_ex[84:80]<=rd;
		reg_id_ex[116:85]<=rv1;
		reg_id_ex[148:117]<=rv2;
		reg_id_ex[149]<=ctrl_we;
	end
endmodule

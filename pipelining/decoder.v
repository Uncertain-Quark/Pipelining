`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:47 10/07/2019 
// Design Name: 
// Module Name:    decoder 
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
module decoder(input wire[31:0]instr, output reg[5:0] opcode, output reg[4:0] rs1,output reg[4:0]rs2,output reg[31:0]imm,
output reg[4:0] rd );
always @(*)
begin

if (instr[6:0]== 7'b0110111 ) //LUI
begin 
	rd<=instr[11:7];rs1<=5'b0;rs2<=5'b0;
	imm <= instr & 32'hfffff000;
	opcode<= 6'b000000;
end
else if (instr[6:0]== 7'b0010111 ) //AUIPC
begin 
	rd<=instr[11:7];rs1<=5'b0;rs2<=5'b0;
	imm <= instr & 32'hfffff000;
	opcode<= 6'b000001;
end
else if (instr[6:0]== 7'b1101111 ) //JAL
begin 
	rd<=instr[11:7];rs1<=5'b0;rs2<=5'b0;
	imm <= {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};
	opcode<= 6'b000010;
end
else if (instr[6:0]== 7'b1100111 && instr[14:12]==3'b000) //JALR
begin 
	rd<=instr[11:7]; rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20{instr[31]}},instr[31:20]};
	opcode<= 6'b000011;
end
else if (instr[6:0]== 7'b1100011 && instr[14:12]==3'b000 ) //BEQ
begin 
	rs2<=instr[24:20];rs1<=instr[19:15];rd<=5'b0;
	imm <= {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
	opcode<= 6'b000100;
end
else if (instr[6:0]== 7'b1100011 && instr[14:12]==3'b001 ) //BNE
begin 
	rs2<=instr[24:20];rs1<=instr[19:15];rd<=5'b0;
	imm <= {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
	opcode<= 6'b000101;
end
else if (instr[6:0]== 7'b1100011 && instr[14:12]==3'b100 ) //BLT
begin 
	rs2<=instr[24:20];rs1<=instr[19:15];rd<=5'b0;
	imm <= {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
	opcode<= 6'b000110;
end
else if (instr[6:0]== 7'b1100011 && instr[14:12]==3'b101 ) //BGE
begin 
	rs2<=instr[24:20];rs1<=instr[19:15];rd<=5'b0;
	imm <= {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
	opcode<= 6'b000111;
end
else if (instr[6:0]== 7'b1100011 && instr[14:12]==3'b110 ) //BLTU
begin 
	rs2<=instr[24:20];rs1<=instr[19:15];rd<=5'b0;
	imm <= {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
	opcode<= 6'b001000;
end
else if (instr[6:0]== 7'b1100011 && instr[14:12]==3'b111 ) //BGEU
begin 
	rs2<=instr[24:20];rs1<=instr[19:15];rd<=5'b0;
	imm <= {{20{instr[31]}},instr[7],instr[30:25],instr[11:8],1'b0};
	opcode<= 6'b001001;
end
else if (instr[6:0]== 7'b0000011 && instr[14:12]==3'b000 ) //LB
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20{instr[31]}},instr[31:20]};
	opcode<= 6'b001010;
end
else if (instr[6:0]== 7'b0000011 && instr[14:12]==3'b001 ) //LH
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20{instr[31]}},instr[31:20]};
	opcode<= 6'b001011;
end
else if (instr[6:0]== 7'b0000011 && instr[14:12]==3'b010 ) //LW
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20{instr[31]}},instr[31:20]};
	opcode<= 6'b001100;
end
else if (instr[6:0]== 7'b0000011 && instr[14:12]==3'b100 ) //LBU
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20{instr[31]}},instr[31:20]};
	opcode<= 6'b001101;
end
else if (instr[6:0]== 7'b0000011 && instr[14:12]==3'b101 ) //LHU
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20{instr[31]}},instr[31:20]};
	opcode<= 6'b001110;
end
else if (instr[6:0]== 7'b0100011 && instr[14:12]==3'b000 ) //SB
begin 
	rs2<=instr[24:20];rs1<=instr[19:15];rd<=5'b0;
	imm <= {{20{instr[31]}},instr[31:25],instr[11:7]};
	opcode<= 6'b001111;
end
else if (instr[6:0]== 7'b0100011 && instr[14:12]==3'b001 ) //SH
begin 
	rs2<=instr[24:20];rs1<=instr[19:15];rd<=5'b0;
	imm <= {{20{instr[31]}},instr[31:25],instr[11:7]};
	opcode<= 6'b010000;
end
else if (instr[6:0]== 7'b0100011 && instr[14:12]==3'b010 ) //SW(17)
begin 
	rs2<=instr[24:20];rs1<=instr[19:15];rd<=5'b0;
	imm <= {{20{instr[31]}},instr[31:25],instr[11:7]};
	opcode<= 6'b010001;
end
else if (instr[6:0]== 7'b0010011 && instr[14:12]==3'b000 ) //ADDI
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20{instr[31]}},instr[31:20]};
	opcode<= 6'b010010;
end
else if (instr[6:0]== 7'b0010011 && instr[14:12]==3'b010 ) //SLTI
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20{instr[31]}},instr[31:20]};
	opcode<= 6'b010011;
end
else if (instr[6:0]== 7'b0010011 && instr[14:12]==3'b011 ) //SLTIU
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20'b0},instr[31:20]};
	opcode<= 6'b010100;
end
else if (instr[6:0]== 7'b0010011 && instr[14:12]==3'b100 ) //XORI
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20'b0},instr[31:20]};
	opcode<= 6'b010101;
end
else if (instr[6:0]== 7'b0010011 && instr[14:12]==3'b110 ) //ORI
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20'b0},instr[31:20]};
	opcode<= 6'b010110;
end
else if (instr[6:0]== 7'b0010011 && instr[14:12]==3'b111 ) //ANDI(23)
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {{20'b0},instr[31:20]};
	opcode<= 6'b010111;
end
else if (instr[6:0]== 7'b0010011 && instr[14:12]==3'b001 ) //SLLI
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {27'b0,instr[24:20]};
	opcode<= 6'b011000;
end
else if (instr[6:0]== 7'b0010011 && instr[14:12]==3'b101 && instr[31:25]==7'b0000000 ) //SRLI
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {27'b0,instr[24:20]};
	opcode<= 6'b011001;
end
else if (instr[6:0]== 7'b0010011 && instr[14:12]==3'b101 && instr[31:25]==7'b0100000 ) //SRAI
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2<=5'b0;
	imm <= {27'b0,instr[24:20]};
	opcode<= 6'b011010;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b000 && instr[31:25]==7'b0000000 ) //ADD
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b011011;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b000 && instr[31:25]==7'b0100000 ) //SUB
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b011100;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b001 && instr[31:25]==7'b0000000 ) //SLL
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b011101;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b010 && instr[31:25]==7'b0000000 ) //SLT
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b011110;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b011 && instr[31:25]==7'b0000000 ) //SLTU(31)
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b011111;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b100 && instr[31:25]==7'b0000000 ) //XOR
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b100000;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b101 && instr[31:25]==7'b0000000 ) //SRL
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b100001;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b101 && instr[31:25]==7'b0100000 ) //SRA
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b100010;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b110 && instr[31:25]==7'b0000000 ) //OR
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b100011;
end
else if (instr[6:0]== 7'b0110011 && instr[14:12]==3'b111 && instr[31:25]==7'b0000000 ) //SRA
begin 
	rd<=instr[11:7];rs1<=instr[19:15];rs2 <= instr[24:20];imm<=32'b0;
	opcode<= 6'b100100;
end
else begin rd<=5'b0;rs1<=5'b0;rs2<=5'b0;opcode<=6'b111111;imm<=32'b0;end
end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:01 10/05/2019 
// Design Name: 
// Module Name:    ALU 
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
module ALU( input wire [31:0] in1,input [31:0] in2 , output reg [31:0] out, input wire [5:0] opcode
    );
always@(in1 or in2 or opcode)
begin
	case (opcode)
		6'b000000: out<=in2; //Load upper immediate
		6'b000100: if (in1 == in2)begin out <= 32'b1;end else begin out<= 32'b0; end//BEQ
		6'b000101: if ($signed(in1) != $signed(in2))begin out <= 32'b1;end else begin out<= 32'b0; end//BNE
		6'b000110: if ($signed(in1) < $signed(in2))begin out <= 32'b1;end else begin out<= 32'b0; end//BLT
		6'b000111: if ($signed(in1) >= $signed(in2))begin out <= 32'b1;end else begin out<= 32'b0; end//BGE
		6'b001000: if (in1 < in2)begin out <= 32'b1;end else begin out<= 32'b0; end//BLTU
		6'b001001: if (in1 >= in2)begin out <= 32'b1;end else begin out<= 32'b0; end//BGEU
		6'b001010: out<= in1+in2;//LB
		6'b001011: out<= in1+in2;//LH
		6'b001100: out<= in1+in2;//LW
		6'b001101: out<= in1+in2;//LBU
		6'b001110: out<= in1+in2;//LHU
		6'b001111: out<= in1+in2;//SB
		6'b010000: out<= in1+in2;//SH
		6'b010001: out<= in1+in2;//SW
		6'b010010: out<= in1+in2;//ADDI
		6'b010011: out<= $signed(in1)<$signed(in2);//SLTI
		6'b010100: out<= in1<in2;//SLTIU
		6'b010101: out<= in1^in2;//XORI
		6'b010110: out<= in1|in2;//ORI
		6'b010111: out<= in1&in2;//ANDI
		6'b011000: out<= in1<<in2;//SLLI	
		6'b011001: out<= in1>>in2;//SRLI
		6'b011010: out<= $signed(in1) >>> in2;//SRAI
		6'b011011: out<= in1+in2;//ADD
		6'b011100: out<= in1-in2;//SUB
		6'b011101: out<= in1<<in2;//SLL
		6'b011110: out<= $signed(in1)<$signed(in2);//SLT
		6'b011111: out<= in1<in2;//SLTU
		6'b100000: out<= in1^in2;//XOR
		6'b100001: out<= in1>>in2;//SRL
		6'b100010: out<= $signed(in1) >>> in2;//SRA
		6'b100011: out<= in1|in2;//OR
		6'b100100: out<= in1&in2;//AND
		default out<=0;
	endcase
end
endmodule

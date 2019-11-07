`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:07:20 11/06/2019 
// Design Name: 
// Module Name:    Execute 
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
module Execute(input clk,input reg [149:0] reg_id_ex,output reg [148:0]reg_ex_mem
    );

wire[31:0] alu_out;reg [31:0] alu_rv2;reg [3:0] we;wire[5:0] opcode;
assign opcode = reg_id_ex[69:64]; 	 

ALU a1(.in1(reg_id_ex[116:85]),.in2(alu_rv2),.opcode(opcode),.out(alu_out)); 

always @(*)
	begin 
		//generate alu_rv2
		if ((opcode>=4 && opcode <=9) || (opcode>=27) ) 
			  begin alu_rv2<=reg_id_ex[148:117];end
		else begin alu_rv2<=reg_id_ex[63:32];end
		
		case (opcode)
				//WE for store byte
				6'b001111 : case(alu_out[1:0])
									2'b00 : we<=4'b0001;
									2'b01 : we<=4'b0010;
									2'b10 : we<=4'b0100;
									2'b11 : we<=4'b1000;
								endcase	
				//WE for store half word				
				6'b010000 : case(alu_out[1:0])
									2'b00 : we<=4'b0011;
									2'b10 : we<=4'b1100;
									default : we<=4'b0000;
								endcase	
				//We for store word
				6'b010001 : we<= 4'b1111; 				
				default : we <= 4'b0000;
		endcase

	end
	
always @(posedge clk)
	begin 
		reg_ex_mem[31:0] <=reg_id_ex[31:0];//pc
		reg_ex_mem[63:32]<=alu_out;
		reg_ex_mem[95:64]<=reg_id_ex[148:117];//rv2
		reg_ex_mem[100:96]<=reg_id_ex[74:70];//rs1
		reg_ex_mem[105:101]<=reg_id_ex[79:75];//rs2
		reg_ex_mem[109:106]<=we;
		reg_ex_mem[141:110]<=reg_id_ex[63:32];//imm
		reg_ex_mem[147:142]<=opcode;
		reg_ex_mem[148]<= reg_id_ex[149];//ctrl_we
	end
endmodule

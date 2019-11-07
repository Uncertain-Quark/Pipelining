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
module Execute(input clk,input reg [148:0] reg_id_ex,output reg reg_ex_mem
    );

wire[31:0] alu_out;reg [31:0] alu_rv2;reg [3:0] we; 	 

ALU a1(.in1(reg_id_ex[116:85]),.in2(alu_rv2),.opcode(reg_id_ex[69:64]),.out(alu_out)); 

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
		//reg_ex_mem
	end
endmodule

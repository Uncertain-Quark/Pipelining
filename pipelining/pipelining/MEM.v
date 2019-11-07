`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:53:44 11/07/2019 
// Design Name: 
// Module Name:    MEM 
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
module MEM(input clk, input [148:0] reg_ex_mem , input wire [31:0]drdata,
	output reg[31:0] daddr,output reg [31:0] dwdata,output reg [3:0] we,output reg [166:0]reg_mem_we );

wire [31:0] rv2;
assign rv2= reg_ex_mem[95:64];

always @(*)
	begin 
		daddr <= reg_ex_mem[63:32];
		we<=reg_ex_mem[109:106];
		case(reg_ex_mem[109:106]) //Generates the write data for DMEM comparing with the we signal
			4'b0001 : dwdata <= {24'b0,rv2[7:0]};
			4'b0010 : dwdata  <= {16'b0,rv2[7:0],8'b0};
			4'b0100 : dwdata  <= {8'b0,rv2[7:0],16'b0};
			4'b1000 : dwdata  <= {rv2[7:0],24'b0};
			4'b0011 : dwdata  <= {16'b0,rv2[15:0]};
			4'b1100 : dwdata  <= {rv2[15:0],16'b0};
			4'b1111 : dwdata  <= rv2 ;
			default : dwdata <= 32'b0;
		endcase
	end	

always @(posedge clk)
	begin 
		reg_mem_wb[31:0]<=reg_ex_mem[31:0];//pc
		reg_mem_wb[63:32]<=reg_ex_mem[141:110];//imm
		reg_mem_wb[95:64]<=drdata;
		reg_mem_wb[127:96]<=reg_ex_mem[63:32];//alu_out
		reg_mem_wb[133:128]<=reg_ex_mem[147:142];//opcode
		reg_mem_wb[165:134]<=reg_ex_mem[95:64];//rv2,daddr
		reg_mem_wb[166]<=reg_ex_mem[148];
	end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:19:22 11/07/2019 
// Design Name: 
// Module Name:    WB 
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
module WB(input clk,input [166:0] reg_mem_wb,output reg [31:0] indata,
									output reg we_rf    );
									
reg we_wire_rf;reg [31:0] rf_win;wire daddr;wire [31:0] drdata,pc,daddr,alu_out;
assign alu_out = reg_mem_wb[127:96];
assign daddr = reg_mem_wb[165:134];
assign pc = reg_mem_wb[31:0];
assign drdata = reg_mem_wb[95:64];

always @(*)
	begin 
	//Generate write data for register file
		case(opcode)
			6'b000001 : rf_win <= pc + reg_mem_wb[63:32];
			6'b000010 : rf_win <= pc + 4;	
			6'b000011 : rf_win <= pc + 4;
			6'b001010 : if (daddr[1:0]==2'b00)rf_win <= {{24{drdata[7]}},drdata[7:0]} ;
							else if (daddr[1:0]==2'b01)rf_win <= {{24{drdata[15]}},drdata[15:8]} ;
							else if (daddr[1:0]==2'b10)rf_win <= {{24{drdata[23]}},drdata[23:16]} ;
							else if (daddr[1:0]==2'b11)rf_win <= {{24{drdata[31]}},drdata[31:24]} ;
			6'b001011 :	if (daddr[1:0]==2'b00)rf_win <= {{16{drdata[15]}},drdata[15:0]} ;
							else if (daddr[1:0]==2'b10)rf_win <= {{16{drdata[31]}},drdata[31:16]} ;
			6'b001100 : rf_win<= drdata;	
			6'b001101 : if (daddr[1:0]==2'b00)rf_win <= {24'b0,drdata[7:0]} ;
							else if (daddr[1:0]==2'b01)rf_win <= {24'b0,drdata[15:8]} ;
							else if (daddr[1:0]==2'b10)rf_win <= {24'b0,drdata[23:16]} ;
							else if (daddr[1:0]==2'b11)rf_win <= {24'b0,drdata[31:24]} ;
			6'b001110 :	if (daddr[1:0]==2'b00)rf_win <= {16'b0,drdata[15:0]} ;
							else if (daddr[1:0]==2'b10)rf_win <= {16'b0,drdata[31:16]} ;		
			default : rf_win <= alu_out;			
		endcase
	end
	
always @(posedge clk)
		begin 
			we_rf<=reg_mem_wb[166];
			indata<=rf_win;
		end

endmodule

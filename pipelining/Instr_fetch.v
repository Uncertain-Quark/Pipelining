`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:00:58 11/02/2019 
// Design Name: 
// Module Name:    Instr_fetch 
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
module Instr_fetch(input clk,input wire [32:0]reg_we_if,input reg [31:0] idata,
output reg[31:0]iaddr,output reg [63:0] reg_if_id
    );
	 
reg [31:0] pc,instr;
assign instr = idata;
assign iaddr = pc;

always @(posedge clk)
begin 
	reg_if_id[31:0] <= instr;
	reg_if_id[63:32] <= pc; 	
	case (reg_we_if[32])
		1'b0 : pc <= pc+4;
		1'b1 : pc <= reg_we_if[31:0];
	endcase	
end

endmodule
//reg_if_id = {instr,pc} reg_we_if ={pc+imm,pc_select}
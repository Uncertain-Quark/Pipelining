`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:15:09 08/31/2019 
// Design Name: 
// Module Name:    rf_file 
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
module rf_file(input clk,input wire [4:0] rs1,input wire [4:0] rs2,input wire [4:0] rd,input we,
input wire [31:0] indata,output wire [31:0] x31,rv1,rv2);

reg [31:0] rfmem[31:0];//declaring the required memory
integer i;

initial begin for (i=0;i<32;i=i+1)
begin rfmem[i] =0; end end //forcing the first register to zero

assign rv1 = rfmem[rs1];
assign rv2 = rfmem[rs2];
assign x31 = rfmem[31];

always @(posedge clk) //synchronous write
	begin 
	if (we && (rd != 0))
		begin 
			rfmem[rd]<= indata;
		end
	end
endmodule

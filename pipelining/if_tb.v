`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:14:03 11/02/2019
// Design Name:   Instr_fetch
// Module Name:   /home/kommi/Downloads/pipelining/if_tb.v
// Project Name:  pipelining
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Instr_fetch
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module if_tb;

	// Inputs
	reg [31:0] reg_we_if;
	reg clk;
	// Outputs
	wire [63:0] reg_if_id;

	// Instantiate the Unit Under Test (UUT)
	Instr_fetch uut (
		.clk(clk),
		.reg_we_if(reg_we_if), 
		.reg_if_id(reg_if_id)
	);
	
always 
begin 
clk = 0;
forever #5 clk = ~clk;
end
	initial begin
		// Initialize Inputs
		reg_we_if = 32'h00000005;
		// Wait 100 ns for global reset to finish
		#10;
		reg_we_if = 32'h00000009;
		#10;
		reg_we_if = 32'h0000000d;
        
		// Add stimulus here

	end
      
endmodule


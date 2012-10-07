//Author: Leonard Robinson
`timescale 1ns/1ns

module top;
	//clock generator
  	bit clk = 1;
	always #5 clk = ~clk;

	//command to generate the VCD dump file that you open with DVE
	initial $vcdpluson;

	iffc IFFC(clk);
	flipflop dut (IFFC.dut);
	tb bench (IFFC.bench);

endmodule	
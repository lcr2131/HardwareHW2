// Author: Donald Pomeroy
// Module: ThirtyTwoByThirtyTwoMux.sv
// Date Created: September 30, 2012
// Date Modified: October 2, 2012

typedef logic [31:0] ThirtyTwoInput;

module ThirtyTwoByThirtyTwoMux(cam_interface.dut_thirtyTwoByThirtyTwo d);
   
   generate
      for(genvar iter=0;iter<32;iter++)begin
	 ThirtyTwoToOneMux muxArray(
				    .input_lines(
						 {d.thirtyTwoByThirtyTwo_input_lines[31][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[30][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[29][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[28][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[27][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[26][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[25][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[24][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[23][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[22][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[21][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[20][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[19][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[18][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[17][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[16][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[15][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[14][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[13][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[12][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[11][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[10][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 9][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 8][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 7][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 6][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 5][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 4][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 3][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 2][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 1][iter],
						  d.thirtyTwoByThirtyTwo_input_lines[ 0][iter]
	                                          }),
				    .selector_bits(d.thirtyTwoByThirtyTwo_selector_bits),
				    .output_line(d.thirtyTwoByThirtyTwo_output_line[iter]));
      end
   endgenerate

endmodule	 

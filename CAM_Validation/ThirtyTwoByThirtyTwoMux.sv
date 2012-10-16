// Author: Donald Pomeroy
// Module: ThirtyTwoByThirtyTwoMux.sv
// Date Created: September 30, 2012
// Date Modified: October 2, 2012

typedef logic [31:0] ThirtyTwoInput;

module ThirtyTwoByThirtyTwoMux(input ThirtyTwoInput [31:0] data_i, 
	input [4:0] selector_bits,
	output logic[31:0] data_o);

	generate
	   for(genvar iter=0;iter<32;iter++)begin
	      ThirtyTwoToOneMux muxArray(
					 .input_lines(
	{data_i[31][iter], data_i[30][iter], data_i[29][iter], data_i[28][iter],
	 data_i[27][iter], data_i[26][iter], data_i[25][iter], data_i[24][iter],
	 data_i[23][iter], data_i[22][iter], data_i[21][iter], data_i[20][iter],
	 data_i[19][iter], data_i[18][iter], data_i[17][iter], data_i[16][iter],
	 data_i[15][iter], data_i[14][iter], data_i[13][iter], data_i[12][iter],
	 data_i[11][iter], data_i[10][iter], data_i[ 9][iter], data_i[ 8][iter],
	 data_i[ 7][iter], data_i[ 6][iter], data_i[ 5][iter], data_i[ 4][iter],
	 data_i[ 3][iter], data_i[ 2][iter], data_i[ 1][iter], data_i[ 0][iter]
	                                               }),
					 .selector_bits(selector_bits),
					 .output_line(data_o[iter]));
	   end
	endgenerate

endmodule	 

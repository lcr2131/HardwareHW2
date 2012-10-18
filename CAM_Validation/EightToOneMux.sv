// Author: Donald Pomeroy
// Module: EightToOneMux.sv
// Date Created: September 28, 2012
// Date Modified: October 2, 2012


module EightToOneMux(
		     input [7:0]  input_lines,
		     input [2:0]  selector_bits,
		     output logic output_line);
   logic 			  muxZeroOut;
   logic 			  muxOneOut;

   FourToOneMux mux0(
		     .input_lines(input_lines[3:0]),
		     .selector_bits(selector_bits[1:0]),
		     .output_line(muxZeroOut));

   FourToOneMux mux1(
		     .input_lines(input_lines[7:4]),
		     .selector_bits(selector_bits[1:0]),
		     .output_line(muxOneOut));

   always_comb begin
      output_line =  
		     (muxOneOut & selector_bits[2])
	|
		     (muxZeroOut & (~selector_bits[2]));
   end
endmodule





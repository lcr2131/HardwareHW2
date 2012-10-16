// Author: Donald Pomeroy
// Module: EightToOneMux.sv
// Date Created: September 28, 2012
// Date Modified: October 2, 2012


module EightToOneMux(cam_interface.dut_eightToOne d);
   
   
   logic muxZeroOut;
   logic muxOneOut;

   FourToOneMux mux0(
		     .input_lines(d.eightToOne_input_lines[3:0]),
		     .selector_bits(d.eightToOne_selector_bits[1:0]),
		     .output_line(muxZeroOut));

   FourToOneMux mux1(
		     .input_lines(d.eightToOne_input_lines[7:4]),
		     .selector_bits(d.eightToOne_selector_bits[1:0]),
		     .output_line(muxOneOut));

   always_comb begin
      d.eightToOne_output_line =  
				  (muxOneOut & d.eightToOne_selector_bits[2])
	|
				  (muxZeroOut & (~d.eightToOne_selector_bits[2]));
   end
endmodule





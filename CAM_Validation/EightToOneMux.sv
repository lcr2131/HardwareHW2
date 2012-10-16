// Author: Donald Pomeroy
// Module: EightToOneMux.sv
// Date Created: September 28, 2012
// Date Modified: October 2, 2012


module EightToOneMux(cam_interface.dut_eightToOne d);
   
   
   logic muxZeroOut;
   logic muxOneOut;

   cam_interface.dut_fourToOne m0(.fourToOne_inputLines(d.eightToOne_input_lines[3:0]),
				  .fourToOne_selector_bits(d.eightToOne_selector_bits[1:0]),
				  .fourToOne_output_line(muxZeroOut));
   cam_interface.dut_fourToOne m1(.fourToOne_inputLines(d.eightToOne_input_lines[7:4]),
				  .fourToOne_selector_bits(d.eightToOne_selector_bits[1:0]),
				  .fourToOne_output_line(muxOneOut));
   
   
   FourToOneMux mux0(m0);

   FourToOneMux mux1(m1);

   always_comb begin
      d.eightToOne_output_line =  
				  (muxOneOut & d.eightToOne_selector_bits[2])
	|
				  (muxZeroOut & (~d.eightToOne_selector_bits[2]));
   end
endmodule





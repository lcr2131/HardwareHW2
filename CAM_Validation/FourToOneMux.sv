// Author: Donald Pomeroy
// Module: FourToOneMux.sv
// Date Created: September 28, 2012
// Date Modified: October 14, 2012

module FourToOneMux(cam_interface.dut_fourToOne d);
	
   always_comb begin
      case (d.FourToOne_selector_bits)
	2'b00: d.fourToOne_output_line = d.fourToOne_input_lines[0];
	2'b01: d.fourToOne_output_line = d.fourToOne_input_lines[1];
	2'b10: d.fourToOne_output_line = d.fourToOne_input_lines[2];
	2'b11: d.fourToOne_output_line = d.fourToOne_input_lines[3];  
      endcase
   end
endmodule
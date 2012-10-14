// Author: Leonard Robinson
// Module: cam.sv
// Date Created: September 26, 2012
// Date Modified: October 2, 2012


module cam_decoder #(parameter WIDTH = 32,
		     parameter ADDR_WIDTH = 5,
	             parameter DEPTH = (1<<ADDR_WIDTH)
		    )
   //End Parameter Defs
   (cam_interface.dut_decoder d);

   logic [DEPTH -1 : 0] 	en_addr_write;//Enabled Address Write
   
   always_comb begin      
	for(int iter = 0; iter < DEPTH; iter++) begin
		en_addr_write[iter] = (iter == d.write_index_i);
		d.write_enable_o[iter] = en_addr_write[iter] & d.write_enable_i;
	end // end for
 
   end // always_comb begin
      
endmodule // cam_decoder

// Author: Leonard Robinson
// Module: cam.sv
// Date Created: September 26, 2012
// Date Modified: October 2, 2012


module cam_decoder (    input 			write_enable_i,
			input [4: 0] 	      write_index_i,
			output logic [31 :0 ] write_enable_o
    );

   logic [31: 0] 	en_addr_write;//Enabled Address Write
   
   always_comb begin      
	for(int iter = 0; iter < 32; iter++) begin
		en_addr_write[iter] = (iter == write_index_i);
		write_enable_o[iter] = en_addr_write[iter] & write_enable_i;
	end // end for
 
   end // always_comb begin
      
endmodule // cam_decoder

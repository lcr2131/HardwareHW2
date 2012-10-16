// Author: Leonard Robinson
// Module: cam.sv
// Date Created: September 25, 2012
// Date Modified: October 2, 2012

module cam  (cam_interface.dut_cam d);   
   //Put inputs on wires inside of the CAM
   wire [4 : 0 ] 	read_index;
   wire [4 : 0] 	dec_write_enable;
   
   typedef logic [31:0] ThirtyTwoInput;
   ThirtyTwoInput [WIDTH - 1 : 0] row_out_into_mux;
   
   wire [4 : 0 ] 	selector_bits;
   wire [31 : 0] 	input_line;
   
   logic [31 : 0] 	match;   
   logic [31 : 0] 	readlogic;
   
   //Decoder
   cam_decoder decoder(.*,.d.write_enable_o(dec_write_enable));//Not sure if I can d.*?
   
   //Memory Generation
   generate 
      for (genvar j = 0; j < WIDTH; j++) begin
         row		 membit(.clk(d.clk_i),
				.reset(d.rst_i),
				.data_i(d.write_data_i),//Connect All Input Bits to All Row bits
				.write_enable_i(dec_write_enable[j]),
				.search_enable_i(d.search_enable_i),
				.search_data_i(d.search_data_i),//Connect All the Data Ports!
				.data_o(row_out_into_mux[j]),//output read line
				.match_o(match[j]),
				.read_valid_o(readlogic[j])
				);
      end                
   endgenerate

   always_comb begin
      d.read_valid_o = readlogic[read_index_i];
   end

   ThirtyTwoByThirtyTwoMux mux(.data_i(row_out_into_mux),.selector_bits(read_index_i),.data_o(read_value_o) );
   
   
   //Search Functionality - P.E.
   priority_encoder priority_en(.data_i(match),.data_o(d.search_index_o),.valid_o(d.search_valid_o));
   
endmodule // cam

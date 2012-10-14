interface cam_interface(input bit clk);
   logic 			clk_i;
   logic 			rst_i;
   logic 			read_enable_i;
   logic [4 : 0 ] 		read_index_i;
   logic 			write_enable_i;
   logic [4 : 0 ] 		write_index_i;
   logic [31 : 0 ] 		write_data_i;
   logic 			search_enable_i;
   logic [31 : 0 ] 		search_data_i;
   logic 			read_valid_o;
   logic [31 : 0] 		read_value_o;
   logic 			search_valid_o;
   logic [4 : 0 ] 		search_index_o;
   
   clocking ()begin

   end clocking

   
modport dut_cam 
   //End Parameter Defs
  (
  
   ); // End Input Defs


   modport bench();

endinterface // cam_interface

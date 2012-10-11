interface cam_interface(input bit clk);
	input 			clk_i, 
	input 			rst_i,
	input 			read_enable_i, 
	input [4 : 0 ] 		read_index_i,
	input 			write_enable_i,
	input [4 : 0 ] 		write_index_i,
	input [31 : 0 ] 	write_data_i,
   	input 			search_enable_i, 
	input [31 : 0 ] 	search_data_i,   
	output logic		read_valid_o,
	output [31 : 0] 	read_value_o,
	output 			search_valid_o,
	output [4 : 0 ] 	search_index_o

modport dut_cam 
   //End Parameter Defs
  (
  
   ); // End Input Defs

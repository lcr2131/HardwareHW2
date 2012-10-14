interface cam_interface(input bit clk);

	logic 			clk_i; 
	logic 			rst_i;
	logic 			read_enable_i; 
	logic [4 : 0 ] 		read_index_i;
	logic 			write_enable_i;
	logic [4 : 0 ] 		write_index_i;
	logic [31 : 0 ] 	write_data_i;
   	logic 			search_enable_i; 
	logic [31 : 0 ] 	search_data_i;   
	logic			read_valid_o;
	logic [31 : 0] 	read_value_o;
	logic 			search_valid_o;
	logic [4 : 0 ] 	search_index_o;

	clocking cb (@posedge clk)
		output 			clk_i; 
		output 			rst_i;
		output 			read_enable_i; 
		output [4 : 0 ] 	read_index_i;
		output 			write_enable_i;
		output [4 : 0 ] 		write_index_i;
		output [31 : 0 ] 	write_data_i;
   		output 			search_enable_i; 
		output [31 : 0 ] 	search_data_i;  
 
		input logic		read_valid_o;
		input [31 : 0] 	read_value_o;
		input 			search_valid_o;
		input [4 : 0 ] 	search_index_o;

	endclocking

 

	modport dut_cam    	
  	(
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
   	); 

   modport dut_decoder(input write_enable_i, input [31:0] write_index_i, output logic [] write_enable_o);
   
   
	modport bench_cam(clocking cb);

endinterface

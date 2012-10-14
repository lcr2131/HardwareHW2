interface cam_interface(input bit clk);

	//full cam
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
	logic [31 : 0] 		read_value_o;
	logic 			search_valid_o;
	logic [4 : 0 ] 		search_index_o;

	//decoder
	logic 		decoder_write_enable_i;
	logic[31:0] 	decoder_write_index_i;
	logic[31:0]	decoder_write_enable_o;

	//8-to-1
	logic [7:0]	eightToOne_input_lines;
	logic [2:0]	eightToOne_selector_bits;
	logic 		eightToOne_output_line;

	//priority encoder
	logic[31:0] 	priorityEnc_data_i;
	logic[4:0] 	priorityEnc_data_o;
	logic 		priorityEnc_valid_o;

	//4-to-1
	logic [3:0]  	fourToOne_input_lines;
	logic [1:0]  	fourToOne_selector_bits;
	logic 		fourToOne_output_line;

	//32-to-1
	logic[31:0] 	thirtyTwoToOne_input_lines;
	logic[4:0]  	thirtyTwoToOne_selector_bits;
	logic 		thirtyTwoToOne_output_line;

	//32 x 32 
	logic [31:0] 	thirtyTwoByThirtyTwo_input_lines;
	logic [4:0]  	thirtyTwoByThirtyTwo_selector_bits;
	logic 		thirtyTwoByThirtyTwo_output_line;

	//flip flop	
	//dont forget the clk
    	logic 	 	ff_reset; 
    	logic 	 	ff_data_i;
    	logic 	 	ff_write_enable_i;
    	logic 	 	ff_search_enable_i;
    	logic 	 	ff_search_i;
    	reg	 	ff_data_o;
    	logic 		ff_match_o;

	//row
	//dont forget the clk	
 	logic		row_reset; 
 	logic [31:0] 	row_data_i;
 	logic 		row_write_enable_i;
 	logic 		row_search_enable_i;
 	logic [31:0] 	row_search_data_i;
 	reg   [31:0] 	row_data_o;
 	logic 		row_match_o;
 	reg	 	row_read_valid_o; 	


	

	clocking cb @(posedge clk);
		output 			clk_i,
		 			rst_i,
		 			read_enable_i, 
					read_index_i,
					write_enable_i,
					write_index_i,
		 			write_data_i,
   		 			search_enable_i, 
				 	search_data_i,
					decoder_write_enable_i,
					decoder_write_index_i,
					eightToOne_input_lines,
					eightToOne_selector_bits,
					fourToOne_input_lines,
					fourToOne_selector_bits,
					thirtyTwoToOne_input_lines,								
					thirtyTwoToOne_selector_bits,
					thirtyTwoByThirtyTwo_input_lines,				
					thirtyTwoByThirtyTwo_selector_bits,
					ff_reset,
					ff_data_i,
					ff_write_enable_i,
					ff_search_enable_i,
					ff_search_i,
					row_reset,
					row_data_i,
					row_write_enable_i,
					row_search_enable_i,
					row_search_data_i;								  
 
		input 			read_valid_o,
		 		 	read_value_o,
					search_valid_o,
		 		 	search_index_o,
					decoder_write_enable_o,
					eightToOne_output_line,
					fourToOne_output_line,
					thirtyTwoToOne_output_line,
					thirtyTwoByThirtyTwo_output_line,
					ff_data_o,
					ff_match_o,
					row_data_o,
					row_match_o,
					row_read_valid_o;		

	endclocking

 

	modport dut_cam    	
  	(
		input 			clk_i, 
		input 			rst_i,
		input 			read_enable_i, 
		input 			read_index_i,
		input 			write_enable_i,
		input 	 		write_index_i,
		input  		 	write_data_i,
   		input 			search_enable_i, 
		input 		 	search_data_i,   
		output			read_valid_o,
		output 		 	read_value_o,
		output 			search_valid_o,
		output 			search_index_o  
   	); 

	
	

   	modport dut_decoder(input decoder_write_enable_i, input decoder_write_index_i, output decoder_write_enable_o);
   
	modport dut_eightToOne(input eightToOne_input_lines, input eightToOne_selector_bits, output eightToOne_output_line);
   
	modport dut_priorityEncoder(input priorityEnc_data_i, output priorityEnc_data_o, output priorityEnc_valid_o);
   
	modport dut_fourToOne(input fourToOne_input_lines, input fourToOne_selector_bits, output fourToOne_output_line);
   
	modport dut_thirtyTwoToOne(input thirtyTwoToOne_input_lines, input thirtyTwoToOne_selector_bits, output thirtyTwoToOne_output_line);
   
	modport dut_thirtTwoByThirtyTwo(input thirtyTwoByThirtyTwo_input_lines, input thirtyTwoByThirtyTwo_selector_bits, output thirtyTwoByThirtyTwo_output_line);
   	
	modport dut_flipflop(
		input 		clk_i,
		input 	 	ff_reset, 
    		input 	 	ff_data_i,
    		input 	 	ff_write_enable_i,
    		input 	 	ff_search_enable_i,
    		input 	 	ff_search_i,
    		output   	ff_data_o,
    		output   	ff_match_o
	);

   	modport dut_row(
		input 		clk_i,
		input		row_reset, 
 		input 	 	row_data_i,
 		input 		row_write_enable_i,
 		input 		row_search_enable_i,
 		input 		row_search_data_i,
 		output	 	row_data_o,
 		output 		row_match_o,
 		output	 	row_read_valid_o 
	
	);

   
   
   
	modport bench_cam(clocking cb);

endinterface


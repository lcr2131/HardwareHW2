interface cam_interface(input bit clk);

   //full cam
   // logic 			clk_i; 
   logic 			rst_i;
   logic 			read_enable_i; 
   logic [4 : 0 ] 		read_index_i;
   logic 			write_enable_i;
   logic [4 : 0 ] 		write_index_i;
   logic [31 : 0 ] 		write_data_i;
   logic 			search_enable_i; 
   logic [31 : 0 ] 		search_data_i;   
   logic			read_valid_o;
   logic [31 : 0] 		read_value_o;
   logic 			search_valid_o;
   logic [4 : 0 ] 		search_index_o;

   

   clocking cb @(posedge clk);
      //output 			clk,
      output		 	rst_i,
		 		read_enable_i, 
				read_index_i,
				write_enable_i,
				write_index_i,
		 		write_data_i,
   		 		search_enable_i, 
				search_data_i;								  
      
      input 			read_valid_o,
		 		read_value_o,
				search_valid_o,
		 		search_index_o;		

   endclocking

   

   modport dut    	
     (
      input  clk, 
      input  rst_i,
      input  read_enable_i, 
      input  read_index_i,
      input  write_enable_i,
      input  write_index_i,
      input  write_data_i,
      input  search_enable_i, 
      input  search_data_i, 
      output read_valid_o,
      output read_value_o,
      output search_valid_o,
      output search_index_o  
      ); 

   
   
   modport bench(clocking cb);

endinterface


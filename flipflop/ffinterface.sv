//Author: Leonard Robinson
interface iffc(input bit clk);
   logic	 reset; 
   logic 	 data_i;
   logic 	 write_enable_i;
   logic 	 search_enable_i;
   logic 	 search_i;
   reg 		 data_o;
   logic 	 match_o;	
   
   clocking cb @(posedge clk);
      output 	 reset, data_i, write_enable_i, search_enable_i, search_i;
      input 	 data_o;
      input 	 match_o;
   endclocking

   modport dut (input clk, input reset, input data_i, input write_enable_i, input search_enable_i, input search_i, output data_o, output  match_o);
   modport bench (clocking cb);
endinterface // iffc

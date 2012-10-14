//Author: Leonard Robinson
interface iffc(input bit clk);
   logic 	 clk;
   logic	 reset; 
   logic 	 data_i;
   logic 	 write_enable_i;
   logic 	 search_enable_i;
   logic 	 search_i;
   reg 		 data_o;
   logic 	 match_o;	
   
   clocking cb @(posedge clk);
      output 	 clk, reset, data_i, write_enable_i, search_enable_i, search_i;
      input reg  data_o;
      input logic match_o;
   endclocking

   modport dut (input reset, data_i, write_enable_i, search_enable_i, search_i, output reg data_o, output logic match_o);
   modport bench (clocking cb);
endinterface
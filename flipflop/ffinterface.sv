//Author: Leonard Robinson
interface iffc(input bit clk);
   logic	 reset; 
   logic [31:0]  data_i;
   reg [31:0] 	 data_o;
   
   clocking cb @(posedge clk);
      output 	 reset;
      output 	 data_i;
      input 	 data_o;
   endclocking

   modport dut (input clk, input reset, input data_i,output data_o);
   modport bench (clocking cb);
endinterface // iffc

// Author: Corey Stappenbeck
// Module: row.sv
// Date Created: September 28, 2012
// Date Modified: September 30, 2012

module row #(parameter WIDTH=32)
(
 input 			clk,
 input 			reset, 
 input [WIDTH-1:0] 	data_i,
 input 			write_enable_i,
 input 			search_enable_i,
 input [WIDTH-1:0] 	search_data_i,
 output reg [WIDTH-1:0] data_o,
 output 		match_o,
 output reg 		read_valid_o 		
);

   logic [WIDTH-1:0]      match;

   always_ff @(posedge clk) begin
      if (reset) read_valid_o <= '0;
      else if (write_enable_i) read_valid_o <= '1;
   end
   
   generate 
      for (genvar j = 0; j < WIDTH; j++) begin : genblock_bits
         flipflop membit(.clk,
			 .reset,
                         .data_i(data_i[j]),
                         .write_enable_i,
                         .search_enable_i,
                         .search_i(search_data_i[j]),
                         .data_o(data_o[j]),
                         .match_o(match[j])
                        );
      end                
   endgenerate

   logic combined;
   always_comb begin
      // combined is true when all bits of match are true
      combined = &match;
   end
   assign match_o = combined;
    
endmodule


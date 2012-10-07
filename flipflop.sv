// Enabled flip-flop with comparator logic
module flipflop
(
    input 	 clk,
    input 	 reset, 
    input 	 data_i,
    input 	 write_enable_i,
    input 	 search_enable_i,
    input 	 search_i,
    output reg 	 data_o,
    output logic match_o
);

   always_ff @(posedge clk) begin
      if (reset) data_o <= '0;
      else if (write_enable_i) data_o <= data_i;
   end

   always_comb begin
      match_o = search_enable_i & (search_i == data_o);
   end
  
endmodule


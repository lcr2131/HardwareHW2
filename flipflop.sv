// Enabled flip-flop with comparator logic
module flipflop(iffc.dut d);

   always_ff @(posedge d.clk) begin
      if (d.reset) d.data_o <= '0;
      else if (write_enable_i) d.data_o <= d.data_i;
   end

   always_comb begin
      d.match_o = d.search_enable_i & (d.search_i == d.data_o);
   end
  
endmodule


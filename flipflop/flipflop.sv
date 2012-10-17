// Enabled flip-flop with comparator logic
module flipflop(iffc.dut d);

   always_ff @(posedge d.clk) begin
      if (d.reset) d.data_o <= '0;
      else d.data_o <= d.data_i;
   end
   
   
endmodule


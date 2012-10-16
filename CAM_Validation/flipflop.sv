// Author: Corey Stappenbeck
// Module: flipflop.sv
// Date Created: September 25, 2012
// Date Modified: October 15, 2012

module flipflop (cam_interface.dut_flipflop d);

   always_ff @(posedge d.clk_i) begin
      if (d.ff_reset) d.ff_data_o <= '0;
      else if (d.ff_write_enable_i) d.ff_data_o <= d.ff_data_i;
   end

   always_comb begin
      d.ff_match_o = d.ff_search_enable_i & (d.ff_search_i == d.ff_data_o);
   end
   
endmodule


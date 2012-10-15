//Author:
//Name: top.sv
//Date Created: October 15, 2012
//Date Modified: October 15, 2012

`timescale 1ns/1ns

module top();
   bit clk_i = 0;
   always #5 clk_i = ~clk_i;

   initial $vcdpluson;

   cam_interface IFC(clk_i); // instantiate the interface file
   cam_module dut(IFC.dut);
   tb bench(IFC.bench);
   



endmodule // top

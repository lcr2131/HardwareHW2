//Author:
//Name: top.sv
//Date Created: October 15, 2012
//Date Modified: October 15, 2012

`timescale 1ns/1ns

module top();
   bit clk = 0;
   always #5 clk = ~clk;

   initial $vcdpluson;

   cam_interface IFC(clk); // instantiate the interface file
   cam dut(IFC.dut);
   testbench bench(IFC.bench);
   



endmodule // top

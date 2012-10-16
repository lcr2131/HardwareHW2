// Author: Donald Pomeroy
// Module: priority_encoder.sv
// Date Created: September 28, 2012
// Date Modified: October 15, 2012

module priority_encoder(cam_interface.dut_priorityEncoder d);
	always_comb begin
		casex(d.priorityEnc_data_i)
		  32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx1: d.priorityEnc_data_o= 5'b00000;
		  32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx10: d.priorityEnc_data_o= 5'b00001; 
		  32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxx100: d.priorityEnc_data_o= 5'b00010; 
		  32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxx1000: d.priorityEnc_data_o= 5'b00011; 
		  32'bxxxxxxxxxxxxxxxxxxxxxxxxxxx10000: d.priorityEnc_data_o= 5'b00100; 
		  32'bxxxxxxxxxxxxxxxxxxxxxxxxxx100000: d.priorityEnc_data_o= 5'b00101; 
		  32'bxxxxxxxxxxxxxxxxxxxxxxxxx1000000: d.priorityEnc_data_o= 5'b00110; 
		  32'bxxxxxxxxxxxxxxxxxxxxxxxx10000000: d.priorityEnc_data_o= 5'b00111; 
		  32'bxxxxxxxxxxxxxxxxxxxxxxx100000000: d.priorityEnc_data_o= 5'b01000; 
		  32'bxxxxxxxxxxxxxxxxxxxxxx1000000000: d.priorityEnc_data_o= 5'b01001; 
		  32'bxxxxxxxxxxxxxxxxxxxxx10000000000: d.priorityEnc_data_o= 5'b01010; 
		  32'bxxxxxxxxxxxxxxxxxxxx100000000000: d.priorityEnc_data_o= 5'b01011; 
		  32'bxxxxxxxxxxxxxxxxxxx1000000000000: d.priorityEnc_data_o= 5'b01100; 
		  32'bxxxxxxxxxxxxxxxxxx10000000000000: d.priorityEnc_data_o= 5'b01101; 
		  32'bxxxxxxxxxxxxxxxxx100000000000000: d.priorityEnc_data_o= 5'b01110; 
		  32'bxxxxxxxxxxxxxxxx1000000000000000: d.priorityEnc_data_o= 5'b01111; 
		  32'bxxxxxxxxxxxxxxx10000000000000000: d.priorityEnc_data_o= 5'b10000; 
		  32'bxxxxxxxxxxxxxx100000000000000000: d.priorityEnc_data_o= 5'b10001; 
		  32'bxxxxxxxxxxxxx1000000000000000000: d.priorityEnc_data_o= 5'b10010; 
		  32'bxxxxxxxxxxxx10000000000000000000: d.priorityEnc_data_o= 5'b10011; 
		  32'bxxxxxxxxxxx100000000000000000000: d.priorityEnc_data_o= 5'b10100; 
		  32'bxxxxxxxxxx1000000000000000000000: d.priorityEnc_data_o= 5'b10101; 
		  32'bxxxxxxxxx10000000000000000000000: d.priorityEnc_data_o= 5'b10110; 
		  32'bxxxxxxxx100000000000000000000000: d.priorityEnc_data_o= 5'b10111; 
		  32'bxxxxxxx1000000000000000000000000: d.priorityEnc_data_o= 5'b11000; 
		  32'bxxxxxx10000000000000000000000000: d.priorityEnc_data_o= 5'b11001; 
		  32'bxxxxx100000000000000000000000000: d.priorityEnc_data_o= 5'b11010; 
		  32'bxxxx1000000000000000000000000000: d.priorityEnc_data_o= 5'b11011; 
		  32'bxxx10000000000000000000000000000: d.priorityEnc_data_o= 5'b11100; 
		  32'bxx100000000000000000000000000000: d.priorityEnc_data_o= 5'b11101; 
		  32'bx1000000000000000000000000000000: d.priorityEnc_data_o= 5'b11110; 
		  default: d.priorityEnc_data_o= 5'b11111; 
		endcase // casex (d.priorityEnc_data_i)
	   if(d.priorityEnc_data_i == '0) d.priorityEnc_valid_o = '0;
	   else d.priorityEnc_valid_o = '1;
	end // always_comb
endmodule


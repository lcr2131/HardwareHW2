//Author: Leonard Robinson
class flip_flop_in;
   rand bit rst;
   rand int write_data_i;
   rand int search_data_i;
   rand bit search_enable_i;
   rand bit write_enable_i;
endclass

class flip_flop_test;
   bit rst;
   bit write_enable_i
   int write_data__i;
   bit search_enable_i;
   int search_data_o;

   function void golden_result;
      out = value;	   
    
   endfunction
endclass


class flip_flip_check;
   function bit check_result(int x);

      $display("%t : %s \n", $realtime, "Computing Golden Result");
      
      return (x == out);
   endfunction
endclass


class flip_flop_env; //Flip Flop parameter environment

   function configure(string filename);
      
      int file, value, seed, chars_returned;
      string param;
      file = $fopen(filename,"r")
	while(!feof(file)) begin
	   chars_returned = $fscanf(file, "%s %d", param, value);
	   if begin
	   end
	   else begin
	   end
	   
	end //End While
   endfunction

endclass

program tb (iffc.bench x); //iffc is the interface of the flip flop class
   flip_flop_in packet;
   flip_flop_test test;
   flip_flop_check check;
   flip_flop_env env;
   int cycle;//DVE Parameter
   
    initial begin
      repeat (10000) begin

	 f = new();
	 f.randomize();
	 // Drive Inputs for Next Cycle
	 $display();
	 @(x.cb);
	 f.golden_result();
	 
	 $display();
	 
      end //end repeat
   end //end initial
   

endprogram //
   
   

//Author: Leonard Robinson
class flip_flop_in;
	rand bit rst;
	rand int write_data_i;
   rand bit search_data_i;
   rand int search_enable_i;
   rand bit write_enable_i;
endclass

class flip_flop_test;
   int value;
   
	int data_o;

   function void golden_result;
      out = value;	   
      $display("%t : %s \n", $realtime, "Computing Golden Result");
   endfunction
endclass


class flip_flip_check;
   function bit check_result(int x);
      return (x == out);
   endfunction
endclass


class flip_flop_env; //Flip Flop parameter environment
	
	

	function

	endfunction

endclass

program tb (iffc.bench x); //iffc is the interface of the flip flop class
  flippy f;
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
   
   

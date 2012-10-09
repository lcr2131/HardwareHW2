//Author: Leonard Robinson
class flippy;
   rand int a;
   rand int b;
   int out;

	function void golden_result;
	  
	   $display();
	endfunction

	function bit check_result(int x);
		return (x == output);
	endfunction
end class

program (iffc.bench x) //iffc is the interface of the flip flop class
  flippy f;
	initial begin
	 repeat (10000) begin

	    f = new();
	    f.randomize();
	    // Drive Inputs for Next Cycle
	    $display()P;
	    @(x.cb);
	    f.golden_result();
	    
	    $display();
	    
	 end //end repeat
	end //end initial
	

endprogram //
   
   
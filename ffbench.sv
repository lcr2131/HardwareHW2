//Author: Leonard Robinson
class flippy;
   rand int value;
   int out;

	function void golden_result;
	   out = value;	   
	   $display("%t : %s \n", $realtime, "Computing Golden Result");
	endfunction

	function bit check_result(int x);
		return (x == out);
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
   
   
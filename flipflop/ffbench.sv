//Author: Leonard Robinson
class flip_flop_in;
   rand bit rst;
   rand int data_i;
endclass // flip_flop_in


class flip_flop_test;
   bit rst;
   int data_i;
   int data_o;
   int stored_data;
   
   function void golden_result;
      data_o = stored_data;	   
      if(rst) stored_data = 0;
      else stored_data = data_i;
      
   endfunction
endclass // flip_flop_test

class flip_flop_check;
   function bit check_result(int dut_value, int bench_value);

      bit passed = (dut_value == bench_value);
      if(passed) begin
	 $display("%t : %s \n", $realtime, "Computing Golden Result");
      end
      else begin
	 $display("%t : fail \n", $realtime);
	 $display("dut value: %d", dut_value);
	 $display("bench value: %d", bench_value);
	 $exit();
      end
      return passed;
   endfunction
endclass // flip_flip_check

class flip_flop_env; //Flip Flop parameter environment
   int cycle = 0;
   int max_transactions = 1;
   int warmup_time = 2;
   bit verbose = 0;
   
   
   function configure(string filename);
      
      int file, value, seed, chars_returned;
      string param;
      file = $fopen(filename,"r");
      
      while(!$feof(file)) begin
	 chars_returned = $fscanf(file, "%s %d", param, value);
	 if("RANDOM_SEED" == param) begin
	    seed = value;
	    $srandom(seed);    
	 end
	 else if("TRANSACTIONS"== param)begin
	    max_transactions = value;	      
	 end
	 else begin
	    $display("Never heard of a : %s", param);
	    $exit();
	 end
	 
      end //End While
   endfunction

endclass // flip_flop_env

program tb (iffc.bench x); //iffc is the interface of the flip flop class
   flip_flop_in packet;
   flip_flop_test test;
   flip_flop_check check;
   flip_flop_env env;
   int cycle;//DVE Parameter

   task do_cycle;
      env.cycle++;
      packet = new();
      packet.randomize();
      test.data_i <= packet.data_i;
      //Golden Test
      test.rst <= packet.rst;
      x.cb.data_i<= packet.data_i;
      x.cb.reset <= packet.rst;
      @(x.cb);
      test.golden_result();
   endtask // do_cycle
   
   
   initial begin
      test = new();
      check = new();
      packet = new();
      env = new();
      env.configure("config.txt");
      
      //warmup
      repeat (2) begin
	 do_cycle();
      end
      //testing
      repeat(env.max_transactions) begin
	 do_cycle();
	 check.check_result(x.cb.data_o, test.data_o);
	 
      end //end repeat
   end //end initial
   
   
endprogram // tb
   
   
   

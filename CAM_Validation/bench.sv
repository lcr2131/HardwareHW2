//Author:
//Name:
//Date Created:Saturday October 13, 2012
//Date Modified:

class cam_transaction;
	rand bit reset;
	rand bit search_enable;
	rand int search_data;
	rand bit write_enable;
	rand int write_data;
	rand int write_address;
	rand bit read_enable;
	rand int read_address;

	bit read_valid;
   	int read_value;
   	bit search_valid;
   	int search_index;
   

endclass // cam_transaction

class cam_test;
	bit reset;
	bit search_enable;
	int search_data;
	bit write_enable;
	int write_data;
	int write_address;
	bit read_enable;
	int read_address;	

	bit read_valid;
   	int read_value;
   	bit search_valid;
   	int search_index;

	int map[31:0];	

	function void reset_golden_result;
		if(reset == 1)
			for(i=0;i<32;i=i+1)
				map[i]=0;
			end
		end
	endfunction;

	function void rw_golden_result;
		if(read_enable==1)
			if((read_address < 32) & (read_address>-1))
				read_value = map[read_address];
				read_valid = 1;
			else
				read_valid==0;	
		end

		if(write_enable==1)
			if((write_address < 32) & (write_address>-1))
				map[write_address] = write_data;							
			end
		end
	endfunction

	function void search_golden_result;
		search_valid = 0;		
		if(search_enable==1)
			for(i=0;i<32;i=i+1)
				if(map[i]==search_data)
					search_valid = 1;
					search_index = i;					
				break;
			end
		end
	endfunction
endclass // cam_test


class cam_env;

   int cycle = 0;
   int max_transactions;
   int warmup_time;
   float reset_density;
   float search_density;
   float write_density;
   float read_density;
   bit verbose;
   
   
   function configure(string filename);
      int file, value, seed, chars_returned;
      string param;
      file = $fopen(filename, "r");
      while(!$feof(file)) begin
	 chars_returned = $fscanf(file, "%s %d", param, value);
	 //If Conditionals To Set Stuff
         //End Ifs
      end // End While
   endfunction // configure  

endclass // cam_env



class cam_checker;
 	function bit int_check_result (int dut_value, int bench_value, bit verbose); 
        	bit passed = (dut_value == bench_value);
        	if(verbose) $display("dut_value: %d", dut_value);
       		if(passed) begin
            		if(verbose) $display("%t : pass \n", $realtime);
        	end
        	else begin
            		$display("%t : fail \n", $realtime);
            		$display("dut value: %d", dut_value);
            		$display("bench value: %d", bench_value);
            		$exit();
        	end
        	return passed;
	endfunction

	function bit bit_check_result(bit dut_value, bit bench_value, bit verbose);
		bit passed = (dut_value == bench_value);
        	if(verbose) $display("dut_value: %d", dut_value);
       		if(passed) begin
            		if(verbose) $display("%t : pass \n", $realtime);
        	end
        	else begin
            		$display("%t : fail \n", $realtime);
            		$display("dut value: %d", dut_value);
            		$display("bench value: %d", bench_value);
            		$exit();
        	end
        	return passed;
	endfunction
endclass 


program testbench (cam_interface.bench_cam cam_tb);
   
   cam_transaction t;
   reset;
   rw;
   search;


	initial begin
      		repeat(10000) begin //MAX_TRANSACTIONS
			t = new();
     			t.randomize();

			// drive inputs for next cycle
			$display("%t : %s \n", $realtime, "Driving New Values");  

		 	cam_tb.cb.rst_i <= t.reset;
		 	cam_tb.cb.read_enable_i <= t.read_enable; 
			cam_tb.cb.read_index_i <= t.read_address;
			cam_tb.cb.write_enable_i <= t.write_enable;
			cam_tb.cb.write_index_i <= t.write_address;
		 	cam_tb.cb.write_data_i <= t.write_data;
   		 	cam_tb.cb.search_enable_i <= t.search_enable;
			cam_tb.cb.search_data_i <= t.;								  
      			
			@(cam_tb.cb);
      				

		end // end repeat
	end // end initial
   
   
endprogram 
   
   
   
   

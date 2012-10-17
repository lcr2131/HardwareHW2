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
		if(reset == 1) begin
			for(i=0;i<32;i=i+1) begin
				map[i]=0;
			end
		end
	endfunction;

	function void rw_golden_result;
		if(read_enable==1) begin
			if((read_address < 32) & (read_address>-1)) begin
				read_value = map[read_address];
				read_valid = 1;
			else begin
				read_valid==0;	
			end
		end

		if(write_enable==1) begin
			if((write_address < 32) & (write_address>-1)) begin
				map[write_address] = write_data;							
			end
		end
	endfunction

	function void search_golden_result;
		search_valid = 0;		
		if(search_enable==1) begin
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
   
	cam_transaction packet;
  	cam_test test;
	cam_checker check;
	cam_env env;
	int cycle;

	task do_cycle
		env.cycle++;
		cycle = env.cycle;
		cycle = env.cycle;
       		packet = new();
        	packet.randomize();
		cam_tb.cb.rst_i <= packet.reset;
		cam_tb.cb.read_enable_i <= packet.read_enable; 
		cam_tb.cb.read_index_i <= packet.read_address;
		cam_tb.cb.write_enable_i <= packet.write_enable;
		cam_tb.cb.write_index_i <= packet.write_address;
		cam_tb.cb.write_data_i <= packet.write_data;
   		cam_tb.cb.search_enable_i <= packet.search_enable;
		cam_tb.cb.search_data_i <= packet.search_data;	
		@(cam_tb.cb);
		test.reset_golden_result();
		test.rw_golden_result();
		test.search_golden_result();
	endtask

  	initial begin
        	test = new();
        	check = new();
        	packet = new();
        	env = new();
        	env.configure("config.txt");

        	// warm up
        	repeat (env.warmup_time) begin
            		do_cycle();
        	end

        	// testing
        	repeat (env.max_transactions) begin
            		do_cycle();

            		if(checker.bit_check_result(ds.cb.read_valid_o,test.read_valid,env.verbose)==1) begin
				checker.int_check_result(ds.cb.read_value_o, test.read_value, env.verbose);
			end

			if(checker.bit_check_result(ds.cb.search_valid_o,test.search_valid,env.verbose)==1) begin
				checker.int_check_result(ds.cb.search_index_o, test.search_index, env.verbose);
			end			
        	end
	end
   
   
endprogram 
   
   
   
   

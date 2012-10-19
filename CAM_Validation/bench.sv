//Author:Donald Pomeroy
//Name: bench.sv
//Date Created:Saturday October 13, 2012
//Date Modified:

class cam_transaction;
   bit reset;
   bit search_enable;
   rand int search_data;
   bit write_enable;

   rand int write_data;
   rand int write_address;
   bit read_enable;
   rand int read_address;

   constraint zeroToThirtyOne{
	write_address>=0;
	write_address<32;
	read_address>=0;
	read_address<32;	
   }

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
   bit validity_map[31:0];

   function void reset_golden_result;
      if(reset == 1) begin
	 for(int i=0;i<32;i=i+1) begin
	    map[i]=0;
	    validity_map[i] = 0;
	 end
      end
   endfunction;
   
   function void rw_golden_result;
      if(write_enable==1) begin
	 if((write_address < 32) & (write_address>-1)) begin
	    map[write_address] = write_data;
	    validity_map[write_address] = 1;
	 end
      end

      if(read_enable==1) begin
	 if((read_address < 32) & (read_address>-1)) begin
	    read_value = map[read_address];
	    read_valid = validity_map[read_address];
	 end
	 else begin
	    read_valid = 0;
	 end
      end
   endfunction
   

   function void search_golden_result;
      search_valid = 0;		
      if(search_enable==1) begin
	 for(int i=0;i<32;i=i+1) begin
	    if(map[i]==search_data) begin
	       search_valid = 1;
	       search_index = i;					
	       break;
	    end
	 end
      end
   endfunction
endclass // cam_test


class cam_env;

   int cycle = 0;
   int max_transactions=10000;
   int warmup_time=2;
   real reset_density = 0.5;
   real search_density = 0.5;
   real write_density = 0.5;
   real read_density = 0.5;
   bit 	verbose=1;
   int 	seed;
   bit [3:0] index_mask; // Basic Mask for Everythang
   bit [31:0]  data_mask;
	
     
   function configure(string filename);
      int file, chars_returned;
      string param, value;
      file = $fopen(filename, "r");
      while(!$feof(file)) begin
	 chars_returned = $fscanf(file, "%s %s", param, value);
	 if ("RANDOM_SEED" == param) begin
            $sscanf(value, "%d", seed);
            $srandom(seed);
	    $display("Random number generator seeded to %d", seed);
         end
         else if("TRANSACTIONS" == param) begin
            $sscanf(value, "%d", max_transactions);
	    $display("Maximum transactions to test: %d", max_transactions);
         end
	 else if("RESET_DENSITY" == param) begin
            $sscanf(value, "%f", reset_density);
	    $display("Reset density: %f", reset_density);
	 end
	 else if("READ_DENSITY" == param) begin
            $sscanf(value, "%f", read_density);
	    $display("Read density: %f", read_density);
	 end
	 else if("WRITE_DENSITY" == param) begin
            $sscanf(value, "%f", write_density);
	    $display("Write density: %f", write_density);
	 end
	 else if("SEARCH_DENSITY" == param) begin
            $sscanf(value, "%f", search_density);
	    $display("Search density: %f", search_density);
	 end
	 else if("INDEX_MASK_READ" == param) begin
	    // $sscanf(value, "%x", index_mask_read);
	    // TODO 
	 end
	 else if("INDEX_MASK_WRITE" == param) begin
	    $sscanf(value, "%x", index_mask); 
	    $display("Index Mask: %f", index_mask);
	    
	    // TODO
	 end
	 else if ("DATA_MASK_SEARCH" == param) begin
	    // TODO
	 end
	 else if ("DATA_MASK_WRITE" == param) begin
	    $sscanf(value, "%x", data_mask);
	    $display("Data Mask: %f", data_mask);
	    
	 end
         else begin
            $display("Never heard of a: %s", param);
            $exit();
         end		 
      end // End While
   endfunction // configure  

endclass // cam_env



class cam_checker;
   function bit int_check_result (int dut_value, int bench_value, bit verbose, string name); 
      bit passed = (dut_value == bench_value);
      if(passed) begin
         if(verbose) $display("%t %s:\tpass %d\n", $realtime, name, dut_value);
      end
      else begin
         $display("%t %s:\tfail", $realtime, name);
         $display("----> dut value:   %d", dut_value);
         $display("----> bench value: %d", bench_value);
         $exit();
      end
      return passed;
   endfunction

   function bit bit_check_result(bit dut_value, bit bench_value, bit verbose, string name);
      bit passed = (dut_value == bench_value);
      if(passed) begin
         if(verbose) $display("%t %s:\tpass %d", $realtime, name, dut_value);
      end
      else begin
         $display("%t %s:\tfail", $realtime, name);
         $display("----> dut value:   %d", dut_value);
         $display("----> bench value: %d", bench_value);
         $exit();
      end
      return passed;
   endfunction
endclass 


program testbench (cam_interface.bench cam_tb);
   
   cam_transaction packet;
   cam_test test;
   cam_checker check;
   cam_env env;
   int cycle;

   task do_cycle;
          
      env.cycle++;
      
      cycle = env.cycle;
      packet = new();
      packet.randomize();
      packet.read_enable = ($dist_uniform(env.seed, 0, 1) < env.read_density);
      packet.write_enable = ($dist_uniform(env.seed, 0, 1) < env.write_density);
      packet.reset = ($dist_uniform(env.seed, 0, 1) < env.reset_density);
      packet.search_enable = ($dist_uniform(env.seed, 0, 1) < env.search_density);



      test.reset <= packet.reset;
      test.read_enable <= packet.read_enable;
      test.read_address <= packet.read_address;      
      test.write_enable <= packet.write_enable;
      test.write_address <= packet.write_address;
      test.write_data <= packet.write_data&env.index_mask;   
      test.search_enable <= packet.search_enable;
      test.search_data <= packet.search_data;    

      cam_tb.cb.rst_i <= packet.reset;
      cam_tb.cb.read_enable_i <= packet.read_enable; 
      cam_tb.cb.read_index_i <= packet.read_address;
      cam_tb.cb.write_enable_i <= packet.write_enable;
      cam_tb.cb.write_index_i <= packet.write_address&env.index_mask;
      $display("Write (Value, Address) : (%d , %d) ", packet.write_data&env.data_mask, packet.write_address&env.index_mask);
      
      cam_tb.cb.write_data_i <= packet.write_data&env.data_mask;
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

	 // only check this result if read_enable is set
	 if (packet.read_enable) begin
	    check.bit_check_result(
				   cam_tb.cb.read_valid_o,
				   test.read_valid,
				   env.verbose, "read_valid"
				   );
	    if (test.read_valid) begin
	       check.int_check_result(
				      cam_tb.cb.read_value_o,
				      test.read_value,
				      env.verbose, "read_value"
				      );
	    end
	 end

	 if (packet.search_enable) begin
	    check.bit_check_result(
				   cam_tb.cb.search_valid_o,
				   test.search_valid,
				   env.verbose, "search_valid"
				   );
	    if (test.search_valid) begin
	       check.int_check_result(
				      cam_tb.cb.search_index_o,
				      test.search_index,
				      env.verbose, "search_index"
				      );
	    end
	 end			
      end
   end
   
   
endprogram 

   
   
   
   

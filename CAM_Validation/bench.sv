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
   

endclass // cam_transaction

class cam_test;


endclass // cam_test

class cam_checker;


endclass // cam_checker


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













class reset;

   function void golden_result;



   endfunction // program

   function void checkbits;
      

   endfunction //

endclass // reset


class rw;


   function void golden_result;

   endfunction // program
   


   function void checkbits;

   endfunction // testbench
   

endclass // rw


class search;



   function void golden_result;




         endfunction //

   function void checkbits;



         endfunction //

endclass // search

   
program testbench ();
   
   
   reset;
   rw;
   search;


   initial begin
      repeat(10000) begin //MAX_TRANSACTIONS

      end // end repeat
   end // end initial
 
   
endprogram 
   
     
   
   
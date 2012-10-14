//Author:
//Name:
//Date Created:Saturday October 13, 2012
//Date Modified:

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
   
     
   
   
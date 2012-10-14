//Author:
//Name:
//Date Created:Saturday October 13, 2012
//Date Modified:

class reset;

   function void golden_result;



   endfunction //

   function void checkbits;
      

   endfunction //

end class // UNMATCHED !!

class rw;


   function void golden_result;




         endfunction //

   function void checkbits;



         endfunction //

end class // UNMATCHED !!

class search;



   function void golden_result;




         endfunction //

   function void checkbits;



         endfunction //

   end class // UNMATCHED !!

   
program()
   
   reset;
   rw;
   search;


   initial begin
      repeat(10000) begin //MAX_TRANSACTIONS

      end // end repeat
   end // end initial
 
   
endprogram
     
   
   
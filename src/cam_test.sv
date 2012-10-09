// Author: The TA (Leonard Robinson)
// Module: cam_test.sv
// Date Created: September 27, 2012
// Date Modified: September 29, 2012

module cam_test();

    parameter DATA_WIDTH = 5;
    parameter DATA_SIZE = (1 << DATA_WIDTH);

    reg clk_i;
    reg rst_i;
    reg read_enable_i;
    reg write_enable_i;
    reg search_enable_i;
    reg [DATA_WIDTH - 1 : 0] write_index_i;
    reg [DATA_SIZE - 1 : 0] write_data_i;
    reg [DATA_SIZE - 1 : 0] search_data_i;
    reg [DATA_WIDTH - 1 : 0] read_index_i;

    wire [DATA_WIDTH - 1 : 0] search_index_o;
    wire [DATA_SIZE - 1 : 0] read_value_o;
    wire search_valid_o;
    wire read_valid_o;

    cam cam_dut (.clk_i, 
		 .rst_i, 
		 .read_enable_i,
		 .read_index_i,
		 .write_enable_i,
		 .write_index_i,
		 .write_data_i,
		 .search_enable_i,
		 .search_data_i,

		 .read_value_o,
		 .search_index_o,
		 .search_valid_o,
		 .read_valid_o 
		 );

    initial begin
        // Beginning of time.  Reset is on.
        clk_i = 0;
        rst_i = 1;
        search_data_i = 0;
        search_enable_i = 0;
        write_data_i = 7;
        write_index_i = 9;
        write_enable_i = 0;
        read_index_i = 9;
        read_enable_i = 0;
 
        // Wait a clock cycle.
        #1 clk_i = 1;
        #1 clk_i = 0;
        rst_i = 0;

        // Done with reset.  Wait a cycle.
        #1 clk_i = 1;       
        #1 clk_i = 0;       
        #1 $display("search_index should be 31.  It is: %d", search_index_o);
        $display("search valid should be 0.  It is: %d", search_valid_o);

        // Write the value 7 to address 9.  Search for 7.
        // Read from address 9.
        write_enable_i = 1;
        #1 clk_i = 1;
        read_enable_i = 1;
        search_enable_i = 1;
        search_data_i = 7;
        #1 clk_i = 0;
        #1 $display("search_index should 9.  It is: %d", search_index_o);
        $display("search valid should be 1.  It is: %d", search_valid_o);
        $display("read_value should be 7.  It is: %d", read_value_o);
        $display("read_valid should be 1.  It is: %d", read_valid_o);
    end
endmodule

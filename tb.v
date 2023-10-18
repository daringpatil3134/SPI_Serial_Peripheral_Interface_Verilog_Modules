`include "spi_defines.v"

module tb;

    reg wb_clk_in, wb_rst_in;
    wire wb_we_in, wb_stb_in, wb_cyc_in, miso;

    wire [4:0]wb_adr_in;
    wire [31:0]wb_dat_in;
    wire [3:0]wb_sel_in;
    wire [31:0]wb_dat_o;

    wire wb_ack_out, wb_int_o, sclk_out, mosi;

    wire [`SPI_SS_NB-1:0]ss_pad_o;

    parameter T = 20;

    wishbone_master MASTER(wb_clk_in,
                            wb_rst_in,
                            wb_ack_out,
                            wb_err_in,
                            wb_dat_o,
                            wb_adr_in,
                            wb_cyc_in,
                            wb_stb_in,
                            wb_we_in,
                            wb_dat_in,
                            wb_sel_in);

    spi_top SPI_CORE(wb_clk_in,
                     wb_rst_in,
                     wb_adr_in,
                     wb_dat_o,
                     wb_sel_in,
                     wb_we_in,
                     wb_stb_in,
                     wb_cyc_in,
                     wb_ack_out,
                     wb_int_o,
                     wb_dat_in,
                     ss_pad_o,
                     sclk_out,
                     mosi,
                     miso);

    spi_slave SLAVE(sclk_out,
                    mosi,
                    ss_pad_o,
                    miso);

    initial
    begin
        wb_clk_in = 1'b0;
        forever
            #(T/2) wb_clk_in = ~wb_clk_in;
    end

    task rst();
        begin
            wb_rst_in = 1'b1;
            #13;
            wb_rst_in = 1'b0;
        end
    endtask

    //tx_neg=1, rx_neg=0, LSB=1, char_len=4
    /*initial
    begin
        rst;
        //initialize the WISHBONE output signals
        MASTER.initialize;
        //configure control register with go_busy being low
        MASTER.single_write(5'h10,32'h0000_3c04,4'b1111);
        //configure divider with go_busy being low
        MASTER.single_write(5'h14,32'h0000_0004,4'b1111);
        //configure slave register with go_busy being low
        MASTER.single_write(5'h18,32'h0000_0001,4'b1111);
        //configure tx register with go_busy being low and processor is sending 4 bits
        MASTER.single_write(5'h00,32'h0000_236f,4'b1111);
        //configure control register with go_busy beingg high
        MASTER.single_write(5'h10,32'h0000_3d04,4'b1111);
        repeat(100)
        @(negedge wb_clk_in);
        $finish;
	#10000 $finish;
    end*/

    //tx_neg=1, rx__neg=0, LSB=0, char_len=4
    /*initial
    begin
        rst;
        //initialize the WISHBONE output signals
        MASTER.initialize;
        //configure control register with go_busy being low
        MASTER.single_write(5'h10,32'h0000_3404,4'b1111);
        //configure divider with go_busy being low
        MASTER.single_write(5'h14,32'h0000_0004,4'b1111);
        //configure slave register with go_busy being low
        MASTER.single_write(5'h18,32'h0000_0001,4'b1111);
        //configure tx register with go_busy being low and processor is sending 4 bits
        MASTER.single_write(5'h00,32'h0000_236f,4'b1111);
        //configure control register with go_busy beingg high
        MASTER.single_write(5'h10,32'h0000_3504,4'b1111);
        repeat(100)
        @(negedge wb_clk_in);
        $finish;
	#10000 $finish;
    end*/

    //tx_neg=0, rx__neg=1, LSB=1, char_len=4
    initial
    begin
        rst;
        //initialize the WISHBONE output signals
        MASTER.initialize;
        //configure control register with go_busy being low
        MASTER.single_write(5'h10,32'h0000_3A04,4'b1111);
        //configure divider with go_busy being low
        MASTER.single_write(5'h14,32'h0000_0004,4'b1111);
        //configure slave register with go_busy being low
        MASTER.single_write(5'h18,32'h0000_0001,4'b1111);
        //configure tx register with go_busy being low and processor is sending 4 bits
        MASTER.single_write(5'h00,32'h0000_236f,4'b1111);
        //configure control register with go_busy beingg high
        MASTER.single_write(5'h10,32'h0000_3B04,4'b1111);
        repeat(100)
        @(negedge wb_clk_in);
        $finish;
	#10000 $finish;
    end

endmodule
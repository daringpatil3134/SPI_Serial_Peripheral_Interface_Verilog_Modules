`include "spi_defines.v"

`timescale 1us/1ns

module spi_shift_reg_tb;

  reg   rx_negedge,
        tx_negedge,
        wb_clk_in,
        wb_rst,
        go,
        miso,
        lsb,
        sclk,
        cpol_0,
        cpol_1;

  reg [3:0] byte_sel,latch ;
  reg [`SPI_CHAR_LEN_BITS-1:0] len;
  reg [`SPI_MAX_CHAR-1:0] p_in;

  wire [`SPI_MAX_CHAR-1:0]p_out;
  wire tip,mosi;
  wire last;

  parameter T = 10;
  parameter [`SPI_DIVIDER_LEN-1:0] divider_value = 4'b0010;

  // Instantiate the DUT
  spi_shift_reg DUT (rx_negedge,
                     tx_negedge,
                     byte_sel,
                     latch,
                     len,
                     p_in,
                     wb_clk_in,
                     wb_rst,
                     go,
                     miso,
                     lsb,
                     sclk,
                     cpol_0,
                     cpol_1,
                     p_out,
                     last,
                     mosi,
                     tip);

  initial
  begin
    wb_clk_in = 1'b0;
    forever
      #(T/2) wb_clk_in = ~wb_clk_in;
  end
  
  initial
  begin
    sclk = 1'b0;
    forever
      begin
        repeat(divider_value + 1)
          @(posedge wb_clk_in);
          sclk = ~sclk;
      end
  end

  task rst();
    begin
      wb_rst = 1'b1;
      #13;
      wb_rst = 1'b0;
    end
  endtask

  initial
  begin
    cpol_1 = 1'b0;
    forever
      begin
        repeat(divider_value*2 + 1)
          @(posedge wb_clk_in);
        cpol_1 = 1'b1;
        @(posedge wb_clk_in)
        cpol_1 = 1'b0;
          repeat(divider_value*2 + 1)
            @(posedge wb_clk_in);
        cpol_1 = 1'b1;
        @(posedge wb_clk_in)
        cpol_1 = 1'b0;
      end
  end

  initial
  begin
    cpol_0 = 1'b0;
      repeat(divider_value)
        @(posedge wb_clk_in);
      cpol_0 = 1'b1;
      @(posedge wb_clk_in)
      cpol_0 = 1'b0;
      forever
        begin
          repeat(divider_value*2 + 1)
            @(posedge wb_clk_in);
          cpol_0 = 1'b1;
          @(posedge wb_clk_in)
          cpol_0 = 1'b0;
        end
  end

  task t1;
    begin
      @(negedge wb_clk_in)
      rx_negedge = 1'b1;
      tx_negedge = 1'b0;
    end
  endtask

  task t2;
    begin
      @(negedge wb_clk_in)
      rx_negedge = 1'b0;
      tx_negedge = 1'b1;
    end
  endtask

  task initialize;
    begin
      len = 3'b000;
      lsb = 1'b0;
      p_in = 32'h0000;
      byte_sel = 4'b0000;
      latch = 4'b0000;
      go = 1'b0;
      miso = 1'b0;
      cpol_1 = 1'b0;
      cpol_0 = 1'b0;
    end
  endtask

  initial
  begin
    initialize;
    rst;
    @(negedge wb_clk_in)
    len = 32'h0004;
    lsb = 1'b1;
    p_in = 32'haa55;
    latch = 4'b0001;
    byte_sel = 4'b0001;
    t1;
    #10;
    go = 1'b1;
    #40;
    miso = 1'b1;
    #20;
    miso = 1'b0;
    #20;
    miso = 1'b1;
    #20;
    miso = 1'b0;
    #20;
    miso = 1'b1;
    #60;
    miso = 1'b0;
    #30;
    #100;
  end

endmodule

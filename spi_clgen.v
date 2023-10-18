`include "spi_defines.v"

module spi_clgen (wb_clk_in,
		  wb_rst,
		  tip,
		  go,
		  last_clk,
		  divider,
		  sclk_out,
		  cpol_0,
		  cpol_1);

  input                         wb_clk_in;
  input                         wb_rst;
  input                         tip;
  input                         go;
  input                         last_clk;
  input [`SPI_DIVIDER_LEN-1:0] divider;
  output                        sclk_out;
  output                        cpol_0;
  output                        cpol_1;
  
  reg                           sclk_out;
  reg                           cpol_0;
  reg                           cpol_1;
  
  reg [`SPI_DIVIDER_LEN-1:0]    cnt;

  
  
  
  // Counter counts half period
  always@(posedge wb_clk_in or posedge wb_rst)
  begin
    if(wb_rst)
      begin
        cnt <= {{`SPI_DIVIDER_LEN{1'b0}},1'b1};
      end
    else if(tip)
      begin
        if(cnt == (divider + 1))
          begin
            cnt <= {{`SPI_DIVIDER_LEN{1'b0}},1'b1};
          end
        else
          begin
            cnt <= cnt + 1;
          end
      end
    else if(cnt == 0)
      begin
        cnt <= {{`SPI_DIVIDER_LEN{1'b0}},1'b1};
      end
  end
  
  
  // Generation of the serial clock
  always@(posedge wb_clk_in or posedge wb_rst)
  begin
    if(wb_rst)
      begin
        sclk_out <= 1'b0;
      end
    else if(tip)
      begin
        if(cnt == (divider + 1))
          begin
            if(!last_clk || sclk_out)
              sclk_out <= ~sclk_out;
          end
      end
  end
  
  
  // Posedge and negedge detection of sclk
  always@(posedge wb_clk_in or posedge wb_rst)
  begin
    if(wb_rst)
      begin
        cpol_0 <= 1'b0;
        cpol_1 <= 1'b0;
      end
    else
      begin
        cpol_0 <= 0;
        cpol_1 <= 0;
          if(tip)
            begin
              if(~sclk_out)
                begin
                  if(cnt == divider)
                    begin
                      cpol_0 <= 1;
                    end
                end
            end
          if(tip)
            begin
              if(sclk_out)
                begin
                  if(cnt == divider)
                    begin
                      cpol_1 <= 1;
                    end
                end
            end
      end
   end


endmodule
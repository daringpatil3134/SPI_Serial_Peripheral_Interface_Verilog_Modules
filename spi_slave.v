`include "spi_defines.v"

module spi_slave (input sclk,mosi,
                  input [`SPI_SS_NB-1:0]ss_pad_o,
                  output miso);

    reg rx_slave = 1'b0; //Slave recieving from SPI_MASTER
    reg tx_slave = 1'b0; //Slave transmitting to SPI_MASTER

    //Initial value of temp is 0
    reg [127:0]temp1 = 0;
    reg [127:0]temp2 = 0;

    reg miso1 = 1'b0;
    reg miso2 = 1'b1;

    always@(posedge sclk)
    begin
        if ((ss_pad_o != 8'b11111111) && ~rx_slave && tx_slave) //Posedge of the Serial Clock
            begin
                temp1 <= {temp1[126:0],mosi};
            end
    end

    always@(negedge sclk)
    begin
        if ((ss_pad_o != 8'b11111111) && rx_slave && ~tx_slave) //Negedge of the Serial Clock
            begin
                temp2 <= {temp2[126:0],mosi};
            end
    end

    always@(negedge sclk)
    begin
        if (rx_slave && ~tx_slave) //Posedge of the Serial Clock
            begin
                miso1 <= temp1[127];
            end
    end
    
    always@(negedge sclk)
    begin
        if (~rx_slave && tx_slave) //Posedge of the Serial Clock
            begin
                miso2 <= temp2[127];
            end
    end

    assign miso = miso1 || miso2;

endmodule
    
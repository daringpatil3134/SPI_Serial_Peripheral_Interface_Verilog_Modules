module wishbone_master(input clk_in, rst_in,ack_in,err_in,
                       input [31:0]dat_in,
                       output reg [4:0]adr_o,
                       output reg cyc_o,stb_o,we_o,
                       output reg [31:0]dat_o,
                       output reg [3:0]sel_o);

    //Internal Signals
    integer adr_temp,sel_temp,dat_temp;
    reg we_temp,cyc_temp,stb_temp;

    //Initialize task
    task initialize;
        begin
            {adr_temp,cyc_temp,stb_temp,we_temp,dat_temp,sel_temp} = 0;
        end
    endtask

    //Wishbone Bus Cycles Single Read/Write
    task single_write;
    input [4:0]adr;
    input [31:0]dat;
    input [3:0]sel;
    begin
        @(negedge clk_in);
        adr_temp = adr;
        sel_temp = sel;
        we_temp  = 1;
        dat_temp = dat;
        cyc_temp = 1;
        stb_temp = 1;
        @(negedge clk_in);
        wait(~ack_in)
        @(negedge clk_in);
        adr_temp = 5'dz;
        sel_temp = 4'd0;
        we_temp  = 1'b0;
        dat_temp = 32'dz;
        cyc_temp = 1'b0;
        stb_temp = 1'b0;
    end
    endtask

    always@(posedge clk_in)
    begin
        adr_o <= adr_temp;
    end
    
    always@(posedge clk_in)
    begin
        we_o <= we_temp;
    end
    
    always@(posedge clk_in)
    begin
        dat_o <= dat_temp;
    end
    
    always@(posedge clk_in)
    begin
        sel_o <= sel_temp;
    end
    
    always@(posedge clk_in)
    begin
        if(rst_in)
            cyc_o <= 0;
        else
            cyc_o <= cyc_temp;
    end
    
    always@(posedge clk_in)
    begin
        if(rst_in)
            stb_o <= 0;
        else
            stb_o <= stb_temp;
    end

endmodule
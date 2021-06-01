`timescale 1ns / 1ps
module Rate_Calculator(
    input clk,
    input [7:0] in_bus,
    input BOD_in,
    output reg Brownout
    );
    reg [7:0] vol1,vol2,rate;
    
    initial
    begin
        vol1=0;
        vol2=0;
        rate=14;
    end
    
    always @(posedge clk)
    begin
        if (BOD_in == 1)
        begin
            vol2 = in_bus;
            rate = vol1 - vol2;
            if ((vol1 > vol2) && (rate > 7))
                Brownout = 1;
            else
                Brownout = 0;
            vol1 = in_bus;
        end 
        else
            Brownout = 0;        
    end  
endmodule

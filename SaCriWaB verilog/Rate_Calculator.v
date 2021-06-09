`timescale 1ns / 1ps
module Rate_Calculator(
    input clk,
    input [19:0] adc_in, 
    input [11:0] rate_limit,
    input BOD_out1,BOD_out2,
    output reg Brownout
    );
    reg [19:0] vol1,vol2,rate;
    
    initial
    begin
        vol1=0;
        vol2=0;
        rate=14;
    end
    
    always @(negedge clk)
    begin
        if (BOD_out2 ==1)
        begin
            Brownout =1;
        end
        
        else if (BOD_out1 == 1)
        begin
            vol2 = adc_in;
            rate = vol1 - vol2;
            if ((vol1 > vol2) && (rate > rate_limit))
                Brownout = 1;
            else
                Brownout = 0;
            vol1 = adc_in;
        end
         
        else
            Brownout = 0;        
    end  
endmodule

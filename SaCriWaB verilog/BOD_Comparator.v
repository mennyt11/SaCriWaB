`timescale 1ns / 1ps
module BOD_Comparator(
    input [19:0] adc_in, BOD_thresh1,BOD_thresh2,
    output reg BOD_out1,
    output reg BOD_out2
    );
    always @(adc_in)
    begin
        if (adc_in<BOD_thresh2)
        begin
            BOD_out2<=1;
            BOD_out1<=1;
        end
        
        else if (adc_in<BOD_thresh1)
        begin
            BOD_out1<=1;
            BOD_out2<=0;
        end
        
        else
        begin
            BOD_out1<=0;
            BOD_out2<=0;
        end
    end    
endmodule

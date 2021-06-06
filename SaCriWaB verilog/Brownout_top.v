`timescale 1ns / 1ps
module Brownout_top(
    input CLK,
    input [19:0] ADC_IN, BOD_THRESH1, BOD_THRESH2,
    input [11:0] RATE_LIMIT,
    output BROWNOUT
    );
    wire comp1,comp2;
    //reg [7:0] BOD_thresh1, BOD_thresh2, rateLimit;
    //initial
    //begin
    //    BOD_thresh1 = 0;
    //    BOD_thresh2 = 0;
    //    rateLimit = 0;
    //end
    
    //always @(supply_vol or min_vol)
    //begin
    //    BOD_thresh1 <= (supply_vol + min_vol)/2;
    //    BOD_thresh2 <= (supply_vol + min_vol)/2;
    //    rateLimit <= (supply_vol - min_vol)/8;
    //end
    
    BOD_Comparator BOD(.adc_in(ADC_IN), .BOD_thresh1(BOD_THRESH1), .BOD_thresh2(BOD_THRESH2), .BOD_out1(comp1), .BOD_out2(comp2));
    Rate_Calculator RateCalc(.clk(CLK), .adc_in(ADC_IN),   .BOD_out1(comp1), .BOD_out2(comp2),
    .Brownout(BROWNOUT), .rate_limit(RATE_LIMIT));
endmodule

`timescale 1ns / 1ps
module Brownout_top(
    input clk_tp,
    input [7:0] ADCin_tp, supply_vol, min_vol,
    output Brownout_tp
    );
    wire BODto_rate;
    reg [7:0] BOD_value, rateLimit;
    initial
    begin
        BOD_value = 0;
        rateLimit = 0;
    end
    
    always @(supply_vol or min_vol)
    begin
        BOD_value <= (supply_vol + min_vol)/2;
        rateLimit <= (supply_vol - min_vol)/8;
    end
    
    BOD_Comparator BOD(.in_bus(ADCin_tp), .BOD_out(BODto_rate), .BODvalue(BOD_value));
    Rate_Calculator RateCalc(.clk(clk_tp), .in_bus(ADCin_tp), .BOD_in(BODto_rate), 
    .Brownout(Brownout_tp), .rate_limit(rateLimit));
endmodule

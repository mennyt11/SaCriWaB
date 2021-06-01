`timescale 1ns / 1ps
module Brownout_top(
    input [7:0] ADCin_tp,
    input clk_tp,
    output Brownout_tp
    );
    wire BODto_rate;
    BOD_Comparator BOD(.in_bus(ADCin_tp), .BOD_out(BODto_rate));
    Rate_Calculator RateCalc(.clk(clk_tp), .in_bus(ADCin_tp), .BOD_in(BODto_rate), 
    .Brownout(Brownout_tp));
endmodule

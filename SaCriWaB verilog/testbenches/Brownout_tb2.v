`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2021 18:09:42
// Design Name: 
// Module Name: Brownout_tb1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Brownout_tb1();
    localparam T = 20;
    reg clk;
    reg [19:0] adc_in, bod_thresh1, bod_thresh2;
    reg [11:0] rate_limit;
    wire brownout;
    
    Brownout_top DUT(.CLK(clk), .ADC_IN(adc_in), .BOD_THRESH1(bod_thresh1), 
    .BOD_THRESH2(bod_thresh2), .RATE_LIMIT(rate_limit), .BROWNOUT(brownout));
    
    initial
    begin
        adc_in = 20'hXXXXX;
        bod_thresh1 = 20'hE38E4;
        bod_thresh2 = 20'hD5555;
        rate_limit = 12'h00C;
    end
    
    always
    begin
        clk = 1'b1;
        #(T/2);
        clk = 1'b0;
        #(T/2);
    end
    
    initial
    begin
        @(negedge clk)
        #5 adc_in = 20'hffff0;
                
        @(negedge clk)
        #5 adc_in = 20'hf0000;
        
        @(negedge clk)
        #5 adc_in = 20'hE38E3;
        
        @(negedge clk)
        #5 adc_in = 20'hE38E0;
        
        @(negedge clk)
        #5 adc_in = 20'hE38a4;
        
        @(negedge clk)
        #5 adc_in = 20'hE38a0;
        
        @(negedge clk)
        #5 adc_in = 20'hE33a4;
        
        @(negedge clk)
        #5 adc_in = 20'hE32a4;
        
        @(negedge clk)
        #5 adc_in = 20'hE32a0;
        
        @(negedge clk)
        #5 adc_in = 20'hd555a;
        
        @(negedge clk)
        #5 adc_in = 20'hd5559;
        
        @(negedge clk)
        #5 adc_in = 20'hd5557;
        
        @(negedge clk)
        #5 adc_in = 20'hd5555;
        
        @(negedge clk)
        #5 adc_in = 20'hd5554;
        
        @(negedge clk)
        #5 adc_in = 20'hd5550;
        
        @(negedge clk)
        #5 adc_in = 20'hd554c;
        
        @(negedge clk)
        #5 
        
        $stop;    
    end
    
endmodule

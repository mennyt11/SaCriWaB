`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2021 20:00:36
// Design Name: 
// Module Name: wd_fail_detector
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


module wd_fail_detector(
    input SWSTAT,
    input WDSRVC,
    input FWOVR,
    output reg WDFAIL,
    output reg [2:0] FLSTAT
    );
    
    reg SRVC_LMT=1;
    initial 
    begin
        WDFAIL=0;
        FLSTAT=3'b100;
    end
    
    always @(posedge FWOVR or posedge WDSRVC or negedge SWSTAT)
    begin
        if(FWOVR==1)
        begin
            WDFAIL <=1;
            FLSTAT <= 3'b000;
        end 
        else if(WDSRVC==1 && SWSTAT == 0)
        begin
            WDFAIL <=1;
            FLSTAT <=3'b001;
        end
        
        else if(WDSRVC==1 && SWSTAT ==1 && SRVC_LMT==0)
        begin
            SRVC_LMT<=1;
            WDFAIL<=0;
        end
        
        else if(WDSRVC ==1 && SWSTAT ==1 && SRVC_LMT==1)
        begin
            WDFAIL<=1;
            FLSTAT<=3'b010;
        end
        else if(SRVC_LMT==0)
        begin
            WDFAIL<=1;
            FLSTAT<=3'b011;
        end
        else
        begin
            SRVC_LMT<=0;
            WDFAIL<=0;
        end
    end
    
endmodule

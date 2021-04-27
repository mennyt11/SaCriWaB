`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.04.2021 17:54:39
// Design Name: 
// Module Name: wd_fail_detector_tb
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


module wd_fail_detector_tb();
reg SWSTAT,WDSRVC,FWOVR;
wire WDFAIL;
wire[1:0] FLSTAT;

wd_fail_detector DUT(.SWSTAT(SWSTAT),.WDSRVC(WDSRVC),.FWOVR(FWOVR),.WDFAIL(WDFAIL),.FLSTAT(FLSTAT));

always 
begin
    SWSTAT=1;
    #70;
    SWSTAT=0;
    #30;
end

initial 
begin
    SWSTAT=1;
    WDSRVC=0;
    FWOVR=0;    
end

initial 
begin
    @(negedge SWSTAT) //FLSTAT 00
    #10 WDSRVC=1;
    #5 WDSRVC=0;
    
    @(posedge SWSTAT)
    #60 WDSRVC=1;
    #5 WDSRVC=0;
    
    @(posedge SWSTAT) //FLSTAT 01
    #50 FWOVR=1;
    #10 FWOVR=0;
    
    @(posedge SWSTAT)
    #60 WDSRVC=1;
    #5 WDSRVC=0;
    
    @(posedge SWSTAT) //FLSTAT 10
    #30 WDSRVC=1;
    #5 WDSRVC=0;
    
    #20 WDSRVC=1;
    #5 WDSRVC=0;
        
    @(posedge SWSTAT)
    #60 WDSRVC=1;
    #5 WDSRVC=0;
    
    @(posedge SWSTAT) //FLSTAT 11
    #80;
    
    @(posedge SWSTAT)
    #60 WDSRVC=1;
    #5 WDSRVC=0;
    
    #10;
    $stop;
end

endmodule

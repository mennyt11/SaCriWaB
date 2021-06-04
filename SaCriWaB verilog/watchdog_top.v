`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2021 14:35:41
// Design Name: 
// Module Name: watchdog_top
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


module watchdog_top(
    input [1:0] ABUS,
    input [15:0] DBUS,
    input RST,
    input CLK,
    output RSTOUT,
    output WDFAIL,
    output [1:0] FLSTAT
    );
   wire wren;
   wire [15:0] din,flstat16;
   wire [1:0] flstat,ain;
   wire fwlen,swlen,rst_lmt,wdsrvc,init;
   wire fwovr,swstat,wdfail,config_wren;
   
   assign flstat16={14'b000000,flstat};
   assign din = wdfail?flstat16:DBUS;
   assign ain = wdfail?2'b10:ABUS;
   
   assign config_wren= wren | wdfail;
   assign WDFAIL = wdfail;
   pattern_comparator I1(.DBUS(DBUS),.CLK(CLK),.RST(RST),.WREN(wren));
   configuration_register I2(.RST(RST),.CLK(CLK),.WREN(wren),.ABUS(ain),.DBUS(din),.FWLEN(fwlen),.SWLEN(swlen),.RST_LMT(rst_lmt),.WDSRVC(wdsrvc),.INIT(init),.FLSTAT(FLSTAT));
   frame_window I3(.CLK(CLK), .WDRST(RST),.WDSRVC(wdsrvc),.FWLEN(fwlen),.FWOVR(fwovr));
   service_window I4(.CLK(CLK),.INIT(init),.SWLEN(swlen),.SWSTAT(swstat));
   wd_fail_detector I5(.SWSTAT(swstat), .WDSRVC(wdsrvc),.FWOVR(fwovr),.WDFAIL(wdfail),.FLSTAT(flstat));
   downcounter I6(.WDFAIL(wdfail),.CLK(CLK),.RST_LMT(rst_lmt),.RSTOUT(RSTOUT));
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2021 10:48:56 AM
// Design Name: 
// Module Name: watchdog_top_tb2
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


module watchdog_top_tb2();

localparam T = 20;
reg[1:0] abus;
reg[7:0] dbus;
reg clk, rst;
wire rstout;
wire WDFAIL;
wire FLSTAT;

watchdog_top DUT2( .ABUS(abus), .DBUS(dbus), .RST(rst), .CLK(clk), .RSTOUT(rstout), .WDFAIL(WDFAIL), .FLSTAT(FLSTAT));
 initial
  begin 
  abus = 0;
  dbus = 0;
  rst = 0;
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
 @(negedge clk)  //random value
 #5 dbus =8'h36;
    abus =2'b00;
 @(negedge clk)  // random value
 #5 dbus =8'h11;
    abus =2'b00;
 @(negedge clk)  // first of the pattern
 #5 dbus =8'hAA;
    abus =2'b00;
 @(negedge clk)   // second of the pattern
 @(negedge clk)
 @(negedge clk)
 #5 dbus =8'h55;
    abus =2'b00;
 @(negedge clk)    //(1) write is enabled for next four cycles
 #5 dbus =8'h0A;   // frame window length is given as hex 0A
    abus =2'b00;
 @(negedge clk)
 #5 dbus =8'h03;   // (2)service window length is given as hex 03
    abus =2'b01;
 @(negedge clk)
 #5 dbus =8'h04;   //(3) reset limit which is the max value of downcounter is given as hex 04
    abus =2'b11;
 @(negedge clk)
 #5 dbus =8'h00;   // (4)zero value to fill write cycle
    abus =2'b10;
 @(negedge clk)  //random value
 #5 dbus =8'h67;
    abus =2'b10;
 @(negedge clk)  // random value
 #5 dbus =8'h45;
    abus =2'b10;
 @(negedge clk)  // first of the pattern
 #5 dbus =8'hAA;
    abus =2'b00;
 @(negedge clk)   // second of the pattern
 @(negedge clk)
 @(negedge clk)
 #5 dbus =8'h55;
    abus =2'b00;
 @(negedge clk)  // (1)init signal is given
 #5 dbus =8'h08;
    abus =2'b10;
 @(negedge clk) // (2)0 value so that system counter keeps counting
 @(negedge clk) //(3)
 @(negedge clk) //(4)
 #5 dbus =8'h00;
    abus =2'b10;
 @(negedge clk)  // first of the pattern
 #5 dbus =8'hAA;
    abus =2'b00;
 @(negedge clk)   // second of the pattern
 @(negedge clk)
 @(negedge clk)
 #5 dbus =8'h55;
    abus =2'b00;
 @(negedge clk)  // (1)watchdog service given ie counter is kicked, service limit goes to high
 #5 dbus =8'h04;
    abus =2'b10;
 @(negedge clk)  //(2) random value
 #5 dbus =8'h00;
    abus =2'b10;
 @(negedge clk)   // (3)watchdog service is again given since service limit is already high this is  a fail, flstat = 10;
 #5 dbus =8'h04;
    abus =2'b10;
 @(negedge clk)   ; //(4) time for downcounter, and system to save current data before reset
 #5 dbus =8'h00;
    abus =2'b10; 
 @(negedge clk)
 @(negedge clk)
 @(negedge clk)
 #5 dbus =8'h00;
    abus =2'b10;
 @(negedge clk)  // random value
 @(negedge clk)
 #5 dbus =8'h00;
    abus =2'b10;
 @(negedge clk)  //random value
 #5 dbus =8'h15;
    abus =2'b10;
 @(negedge clk)  // random value
 #5 dbus =8'h71;
    abus =2'b10;
 end
 
endmodule

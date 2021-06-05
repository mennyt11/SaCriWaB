`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2021 10:50:38 AM
// Design Name: 
// Module Name: watchdog_top__tb3
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


module watchdog_top__tb3();

localparam T = 20;
reg[1:0] abus;
reg[7:0] dbus;
reg clk, rst;
wire rstout;
wire WDFAIL;
wire FLSTAT;

watchdog_top DUT3( .ABUS(abus), .DBUS(dbus), .RST(rst), .CLK(clk), .RSTOUT(rstout), .WDFAIL(WDFAIL), .FLSTAT(FLSTAT));
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
 @(negedge clk)  // (1)init signal is again given
 #5 dbus =8'h08;
    abus =2'b10;
 @(negedge clk)  // (2)watchdog service is given after 12 clk cycles which is greater than frame window so frame window overflows
 @(negedge clk)  // (3)thsi results is fail, flstat = 00;
 @(negedge clk)  //(4)
 @(negedge clk)
 @(negedge clk)
 @(negedge clk)  // first of the pattern
 #5 dbus =8'hAA;
    abus =2'b00;
 @(negedge clk)   // second of the pattern
 @(negedge clk)
 @(negedge clk)
 #5 dbus =8'h55;
    abus =2'b00;
 @(negedge clk)  //(1)
 @(negedge clk)  //(2)
 #5 dbus =8'h00;
    abus =2'b10;
 @(negedge clk) //(3)
 #5 dbus =8'h04;
    abus =2'b10;
 @(negedge clk) //(4) time for downcounter
 #5 dbus =8'h00;
    abus =2'b10;
 @(negedge clk)
 @(negedge clk)
 @(negedge clk)
 @(negedge clk)
 #5 dbus =8'h00;
    abus =2'b10;
 end
endmodule

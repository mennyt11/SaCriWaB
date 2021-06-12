`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/04/2021 12:16:43 PM
// Design Name: 
// Module Name: watchdog top  tb
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


module watchdog_top_tb1();

localparam T = 20;
reg[2:0] abus;
reg[15:0] dbus;
reg[19:0] adc_in;
reg clk, rst;
wire rstout;
wire WDFAIL;
wire [2:0] FLSTAT;
wire brownout;

watchdog_top DUT1( .ABUS(abus), .DBUS(dbus),.ADC_IN(adc_in), .RST(rst), .CLK(clk), .RSTOUT(rstout), .WDFAIL(WDFAIL), .FLSTAT(FLSTAT), .BROWNOUT(brownout));
 initial
  begin 
  abus = 0;
  dbus = 0;
  adc_in =20'hFFFF;
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
 #5 dbus =16'h3636;
    abus =3'b000;
    adc_in =20'hFFFFF;
 @(negedge clk)  // random value
 #5 dbus =16'h1111;
    abus =3'b000;
    adc_in =20'hFFFFF;
 @(negedge clk)  // first of the pattern
 #5 dbus =16'hAAAA;
    abus =3'b000;
    adc_in =20'hFFFFF;
 @(negedge clk)   // second of the pattern
 @(negedge clk)
 @(negedge clk)
 #5 dbus =16'h5555;
    abus =3'b000;
    adc_in =20'hFFFFF;
 @(negedge clk)    //(1) write is enabled for next four cycles
 #5 dbus =16'h000A;   // frame window length is given as hex 0A
    abus =3'b000;
    adc_in =20'hFFFFF;
 @(negedge clk)
 #5 dbus =16'h0003;   // (2)service window length is given as hex 03
    abus =3'b001;
    adc_in =20'hFFFFF;
 @(negedge clk)
 #5 dbus =16'h0004;   //(3) reset limit which is the max value of downcounter is given as hex 04
    abus =3'b011;
    adc_in =20'hFFFFF;
 @(negedge clk)
 #5 dbus =16'h0000;   // (4)zero value to fill write cycle
    abus =3'b010;
    adc_in =20'hFFFFF;
 @(negedge clk)  //random value
 #5 dbus =16'h6767;
    abus =3'b010;
    adc_in =20'hFFFFF;
 @(negedge clk)  // random value
 #5 dbus =16'h4545;
    abus =3'b010;
    adc_in =20'hFFFFF;
 @(negedge clk)  // first of the pattern
 #5 dbus =16'hAAAA;
    abus =3'b000;
    adc_in =20'hFFFFF;
 @(negedge clk)   // second of the pattern
 @(negedge clk)
 @(negedge clk)
 #5 dbus =16'h5555;
    abus =3'b000;
    adc_in =20'hFFFFF;
  @(negedge clk)
 #5 dbus =16'h0010;   // (1)init signal is enabled
    abus =3'b010;
    adc_in =20'hFFFFF;
 @(negedge clk)
 #5 dbus =16'h0008;   //(2) watchdog service is given that is counter is kicked
    abus =3'b010;  // since watchdog service happens below service window length it is a fail, flstat = 01 
    adc_in =20'hFFFFF; 
 @(negedge clk)   //(3) for the next 4 clk cycles 0 value is passed, in this time the downcounter counts and hence is the time 
 @(negedge clk)   // (4)for system to recover
 #5 dbus =16'h0000;
    abus =3'b010;
    adc_in =20'hFFFFF; 
 @(negedge clk)
 @(negedge clk)
 #5 dbus =16'h0000;
    abus =3'b010;
    adc_in =20'hFFFFF; 
 @(negedge clk)  // random value 
 #5 dbus =16'h20;
    abus =3'b010;
    adc_in =20'hFFFFF; 
 @(negedge clk)  //random value
 #5 dbus =16'h1515;
    abus =3'b010;
    adc_in =20'hFFFFF; 
 @(negedge clk)  // random value
 #5 dbus =16'h7171;
    abus =3'b010;
    adc_in =20'hFFFFF; 
 end
endmodule

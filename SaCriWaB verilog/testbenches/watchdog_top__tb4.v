`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/05/2021 10:51:08 AM
// Design Name: 
// Module Name: watchdog_top__tb4
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


module watchdog_top__tb4();

localparam T = 20;
reg[2:0] abus;
reg[15:0] dbus;
reg[19:0] adc_in;
reg clk, rst;
wire rstout;
wire WDFAIL;
wire [2:0] FLSTAT;
wire brownout;

watchdog_top DUT4( .ABUS(abus), .DBUS(dbus), .ADC_IN(adc_in), .RST(rst), .CLK(clk), .RSTOUT(rstout), .WDFAIL(WDFAIL), .FLSTAT(FLSTAT), .BROWNOUT(brownout));
 initial
  begin 
  abus = 0;
  dbus = 0;
  adc_in = 20'hFFFF;
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
 @(negedge clk)  // (1)init signal is given
 #5 dbus =16'h0010;
    abus =3'b010;
    adc_in =20'hFFFFF; 
 @(negedge clk)  // (2) 0 value given for next 3 write enabled signals so that counter keeps counting
 @(negedge clk) // (3)
 @(negedge clk)  //(4)
 #5 dbus =16'h0000;  
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
 @(negedge clk)  // (1)init signal is again given,  this indicates that the init signal occured before a watchdog service 
 #5 dbus =16'h0010; // and before frame window overflow, this is fault 4, so flstat = 3'b011
    abus =3'b010;
    adc_in =20'hFFFFF; 
 @(negedge clk)  // (2) 0 value given for next 3 write enabled signals and here the downcounter counts for the next 4 cycles 
 @(negedge clk) // (3) ; as an fault was detected
 @(negedge clk)  //(4)
 #5 dbus =16'h0000;  
    abus =3'b010;
    adc_in =20'hFFFFF; 
 @(negedge clk)  
 #5 dbus =16'h0000;  
    abus =3'b010;
    adc_in =20'hFFFFF; 
 end
endmodule

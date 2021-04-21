`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2021 18:45:27
// Design Name: 
// Module Name: pattern_comparator
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


module pattern_comparator(
 input [7:0] DBUS,
 input CLK,
 input RST,
 output reg WREN);

 parameter IDLE = 2'b00, STAT1 = 2'b01, STAT2 = 2'b10;
 integer q;
 reg [1:0] PS, NS;
 reg start;

 initial  
 begin
    PS = IDLE;
 end

 always@ (posedge CLK or posedge RST)
 begin 
   if (RST)
      PS <= IDLE;
   else
     PS <= NS;
 end

 always@(PS or DBUS)
 begin
   case(PS)
   IDLE: begin
            if( DBUS==8'hAA)
            begin
                NS= STAT1;
                WREN = 0;
            end
               
            else 
            begin
                NS = IDLE;
                WREN = 0;
            end
         end

   STAT1: begin
            if(DBUS == 8'h55)
            begin
                NS = STAT2;
                WREN = 0;
            end
            
            else
            begin 
                NS = IDLE;
                WREN = 0;
            end
          end 

   STAT2: begin
            start = 1;
          end

   default: NS = IDLE;
   endcase
 end

 always@(posedge CLK)
  begin
      if( start==1)
          begin
              q=q+1;
              NS = STAT2;
              WREN = 1;
          end
      if (q==4)
          begin
              start = 0;
              NS = IDLE;
              WREN = 0;
          end 
  end 
endmodule


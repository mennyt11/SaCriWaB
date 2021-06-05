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
 input [15:0] DBUS,
 input CLK,
 input RST,
 output reg WREN
 );

 parameter IDLE = 2'b00, STAT1 = 2'b01, STAT2 = 2'b10,count=16'h0004;
 reg[15:0] q1,q2;
 reg [1:0] PS, NS;
 reg start1,start2;

 initial  
 begin
    PS = IDLE;
    q1=0;
    q2=0;
    start1=0;
    start2=0;
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
            if( DBUS==16'hAAAA)
            begin
                NS<= STAT1;
                WREN <= 0;
                start1<=1;
            end
               
            else 
            begin
                NS <= IDLE;
                WREN <= 0;
            end
         end

   STAT1: begin
            if(DBUS == 16'h5555)
            begin
                start1<=0;
                q1<=0;
                NS <= STAT2;
                WREN <= 1;
            end
          end 

   STAT2: begin
            start2 <= 1;
          end

   default: NS <= IDLE;
   endcase
 end
 
always@(posedge CLK)
  begin
     if (q1==count)
          begin
              q1<=0;
              start1 <= 0;
              NS <= IDLE;
              PS<= IDLE;
              WREN <= 0;
          end
      else if( start1==1)
          begin
              q1<=q1+1;
              NS <= STAT1;  
          end
          
       else
            q1<=q1;
end

  
 always@(posedge CLK)
  begin
      if (q2==count)
          begin
              q2<=0;
              start2 <= 0;
              NS <= IDLE;
              PS <= IDLE;
              WREN <= 0;
          end
      else if( start2==1)
          begin
              q2<=q2+1;
              NS <= STAT2;
              WREN <= 1;
          end
       else
            q2<=q2; 
  end 
endmodule

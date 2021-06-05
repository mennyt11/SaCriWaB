`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2021 20:02:05
// Design Name: 
// Module Name: downcounter
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


module downcounter(
    input WDFAIL,
    input CLK,
    input [15:0] RST_LMT,
    output reg RSTOUT
    );
    reg [15:0] q=0;
    
    always @ (posedge CLK)
    begin
        if (WDFAIL==0)
        begin
            RSTOUT<=0;
            q<=0;
        end
        
        else if(q==RST_LMT)
        begin
           RSTOUT<=1; 
        end
        
        else if(WDFAIL==1)
        begin
            q<=q+1;
        end
        
        else
        begin
            q<=q;
        end
    end
    
endmodule

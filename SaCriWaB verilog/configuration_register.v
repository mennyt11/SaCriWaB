`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.04.2021 13:01:41
// Design Name: 
// Module Name: configuration_register
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


module configuration_register(
    input RST,
    input CLK,
    input WREN,
    input [1:0] ABUS,
    input [15:0] DBUS,
    output [15:0] FWLEN,
    output [15:0] SWLEN,
    output [15:0] RST_LMT,
    output WDSRVC,
    output INIT,
    output [1:0] FLSTAT
    );
    
    reg [15:0] FWLEN_reg,SWLEN_reg,RST_LMT_reg;
    reg [15:0] SERVICE_reg; // [15:4] unused,[3] INIT,[2] WDSRVC,[1:0] FLSTAT
    
    assign FWLEN = FWLEN_reg;
    assign SWLEN = SWLEN_reg;
    assign INIT = SERVICE_reg[3];
    assign WDSRVC = SERVICE_reg[2];
    assign FLSTAT = SERVICE_reg[1:0];
    assign RST_LMT = RST_LMT_reg;
    
    initial
    begin
    FWLEN_reg=0;
    SWLEN_reg=0;
    SERVICE_reg=0;
    RST_LMT_reg=0;
    end
    
    always @(posedge CLK)
    begin
        if (RST==1)
        begin
        FWLEN_reg<=0;
        SWLEN_reg<=0;
        SERVICE_reg<=0;
        RST_LMT_reg<=0;
        end
        
        else if(WREN==1)
        begin
        case(ABUS)
        2'b00: FWLEN_reg<= DBUS;
        2'b01: SWLEN_reg<= DBUS;
        2'b10: SERVICE_reg<= DBUS;
        2'b11: RST_LMT_reg<=DBUS;
        endcase
        end
        
        else
        begin
        FWLEN_reg<= FWLEN_reg;
        SWLEN_reg<= SWLEN_reg;
        SERVICE_reg<= SERVICE_reg;
        RST_LMT_reg <= RST_LMT_reg;
        end
        
     end
endmodule

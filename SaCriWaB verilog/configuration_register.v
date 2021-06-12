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
    input [2:0] ABUS,
    input [15:0] DBUS,
    output [15:0] FWLEN,
    output [15:0] SWLEN,
    output [15:0] RST_LMT,
    output WDSRVC,
    output INIT,
    output [2:0] FLSTAT,
    output [19:0] BOD_thresh1,
    output [19:0] BOD_thresh2,
    output [11:0] BOD_rate_limit
    );
    
    reg [15:0] FWLEN_reg,SWLEN_reg,RST_LMT_reg;
    reg [15:0] SERVICE_reg; // [15:5] unused,[4] INIT,[3] WDSRVC,[2:0] FLSTAT
    
    reg [15:0] BOD_reg0; //[15:4] BOD_rate_limit, [3:0] BOD_thresh1_MSB4
    reg [15:0] BOD_reg1;// BOD_thresh1_LSB16
    reg [15:0] BOD_reg2; //{15:4] unused, [3:0] BOD_thresh2_MSB4
    reg [15:0] BOD_reg3; //BOD_thresh2_LSB16
    
    assign FWLEN = FWLEN_reg;
    assign SWLEN = SWLEN_reg;
    assign INIT = SERVICE_reg[4];
    assign WDSRVC = SERVICE_reg[3];
    assign FLSTAT = SERVICE_reg[2:0];
    assign RST_LMT = RST_LMT_reg;
    assign BOD_thresh1= {BOD_reg0[3:0],BOD_reg1};
    assign BOD_thresh2= {BOD_reg2[3:0],BOD_reg3};
    assign BOD_rate_limit= BOD_reg0[15:4];
    
    initial
    begin
    FWLEN_reg=16'h00FF;
    SWLEN_reg=16'h000A;
    SERVICE_reg=16'h0010;
    RST_LMT_reg=16'h000A;
    
    //BOD_thresh1=20'hE38E4 (for 20bit ADC with Vref=9V and Vin=8V)
    //BOD_thresh2=20'hD5555 (for 20bit ADC with Vref=9V and Vin=7.5V)
    //BOD_rate_limit= 12'h00C (1.03e-4 V per cycle) =>(0.5V in 4800cycles)
    BOD_reg0=16'h00CE; 
    BOD_reg1=16'h38E4; 
    BOD_reg2=16'h000D;
    BOD_reg3=16'h5555;
    end
    
    always @(posedge CLK)
    begin
        if (RST==1)
        begin
            FWLEN_reg=16'h00FF;
            SWLEN_reg=16'h000A;
            SERVICE_reg=16'h0010;
            RST_LMT_reg=16'h000A;
    
            //BOD_thresh1=20'hE38E4 (for 20bit ADC with Vref=9V and Vin=8V)
            //BOD_thresh2=20'hD5555 (for 20bit ADC with Vref=9V and Vin=7.5V)
            //BOD_rate_limit= 12'h00C (1.03e-4 V per cycle) =>(0.5V in 4800cycles)
            BOD_reg0=16'h00CE; 
            BOD_reg1=16'h38E4; 
            BOD_reg2=16'h000D;
            BOD_reg3=16'h5555;
        end
        
        else if(WREN==1)
        begin
        case(ABUS)
        3'b000: FWLEN_reg<= DBUS;
        3'b001: SWLEN_reg<= DBUS;
        3'b010: SERVICE_reg<= DBUS;
        3'b011: RST_LMT_reg<=DBUS;
        3'b100: BOD_reg0<= DBUS;
        3'b101: BOD_reg1<= DBUS;
        3'b110: BOD_reg2<= DBUS;
        3'b111: BOD_reg3<=DBUS;
        endcase
        end
        
        else
        begin
        FWLEN_reg<= FWLEN_reg;
        SWLEN_reg<= SWLEN_reg;
        SERVICE_reg<= SERVICE_reg;
        RST_LMT_reg <= RST_LMT_reg;
        BOD_reg0 <=BOD_reg0;
        BOD_reg1 <=BOD_reg1;
        BOD_reg2 <=BOD_reg2;
        BOD_reg3 <=BOD_reg3;
        end
        
     end
endmodule

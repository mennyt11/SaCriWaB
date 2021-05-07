`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2021 17:26:20
// Design Name: 
// Module Name: configuration_register_tb
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


module configuration_register_tb();

localparam T=20;
 
reg [7:0] dbus;
reg [1:0] abus;
reg clk,rst;
wire wren;

wire [7:0] swlen,fwlen,rst_lmt;
wire wdsrvc;
wire init;
wire [2:0] flstat;

pattern_comparator PAT(.DBUS(dbus),.CLK(clk),.RST(rst),.WREN(wren));
configuration_register CON(.RST(rst),.CLK(clk),.WREN(wren),.ABUS(abus),.DBUS(dbus),.FWLEN(fwlen),.SWLEN(swlen),
                               .RST_LMT(rst_lmt),.WDSRVC(wdsrvc),.INIT(init),.FLSTAT(flstat));

initial
begin
    dbus=0;
    abus=0;
    rst=0;
end

always begin
    clk=1'b1;
    #(T/2);
    clk=1'b0;
    #(T/2);
end

initial 
begin
    @(negedge clk)
    #5 dbus=8'h11;
    
    @(negedge clk)
    #5 dbus=8'hAA;
    
    @(negedge clk)
    @(negedge clk)
    #5 dbus=8'h40;
    
    @(negedge clk)
    @(negedge clk)
    #5 dbus=8'h33;
    
    @(negedge clk)
    #5 dbus=8'h76;
    
    @(negedge clk)
    #5 dbus=8'hAA;
    
    @(negedge clk)
    @(negedge clk)
    @(negedge clk)
    #5 dbus=8'h55;
    
    @(negedge clk)
    #5 dbus=8'hA0;
    abus=2'b00;
    
    @(negedge clk)
    #5 dbus=8'h0F;
       abus=2'b01;
           
    @(negedge clk)
    #5 dbus=8'h08;
    abus=2'b10;
    
    @(negedge clk)
    #5 dbus=8'h00;
    abus=2'b10;
    
    @(negedge clk)
    #5 dbus=8'h10;
    abus=2'b10;
    
    @(negedge clk)
    #5 dbus=8'h10;
    abus=2'b10;
    
    @(negedge clk)
    #5 dbus=8'h00;
    abus=2'b10;
    
    @(negedge clk)
    #5 dbus=8'h11;
    
    @(negedge clk)
    #5 dbus=8'h88;
    
    $stop;
end
endmodule

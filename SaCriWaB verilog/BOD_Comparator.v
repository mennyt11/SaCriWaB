`timescale 1ns / 1ps
module BOD_Comparator(
    input [7:0] in_bus, BODvalue,
    output reg BOD_out
    );
    always @(in_bus)
    begin
        if (in_bus<BODvalue)
            BOD_out<=1;
        else
            BOD_out<=0;
    end    
endmodule

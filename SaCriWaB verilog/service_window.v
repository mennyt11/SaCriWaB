module service_window(
		input SWCLK,INIT,
		input [7:0] SWLEN,
		output reg SW_STAT);
reg [7:0] q;
		 
initial begin 
q=0;
SW_STAT=1;
end

always @ (posedge SWCLK)
begin
	if(INIT==0)
		begin
		SW_STAT=0;
		end
end

always @ (posedge SWCLK)
begin
	if(q==SWLEN) 
		begin
		SW_STAT=1;
		q=0;
		end
end

endmodule	


module frame_window(
		input FWCLK, WDRST,WDSRVC,
		input [7:0] FWLEN,
		output reg FW_OVR);

reg [7:0] q;
		 
initial begin 
FW_OVR=0;
q=0;
end

always @ (posedge FWCLK)
begin
	if(q==FWLEN)
		begin
		FW_OVR<=1;
		q<=0;
		end

	else if(WDSRVC==1)
		begin
		q<=0;
		end
	
	else if(WDRST==1)
		begin
		q<=0;
		FW_OVR<=0;
		end
	else
		q<=q+1;
end

endmodule		
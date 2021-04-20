module frame_window(
<<<<<<< HEAD
		input FWCLK, WDRST,WDSRVC,
=======
		input FWCLK, WDRST,
>>>>>>> 897ce8fa71d1055816e61bd16bb6fbadb2bce202
		input [7:0] FWLEN,
		output reg FW_OVR);

reg [7:0] q;
		 
initial begin 
FW_OVR=0;
q=0;
end

always @ (posedge FWCLK)
begin
<<<<<<< HEAD
	if(q==FWLEN)
=======
	if(q==FWLEN+1)
>>>>>>> 897ce8fa71d1055816e61bd16bb6fbadb2bce202
		begin
		FW_OVR<=1;
		q<=0;
		end
<<<<<<< HEAD

	else if(WDSRVC==1)
		begin
		q<=0;
		end
=======
>>>>>>> 897ce8fa71d1055816e61bd16bb6fbadb2bce202
	
	else if(WDRST==1)
		begin
		q<=0;
		FW_OVR<=0;
		end
	else
		q<=q+1;
end

endmodule		
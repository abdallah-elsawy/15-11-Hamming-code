
module counter
	#(
	parameter WIDTH=4
	)
	(
	input clk,
	input reset,
	input en,
	output full
    );
 reg[WIDTH-1:0] count;

	 always @(posedge clk)
	 begin
		if(reset==1)
			count<=0;
			else
				if(en==1)
				begin
					count<=count+1;
				end
	 end
	 assign full = (count >= 11)? 1: 0;
endmodule

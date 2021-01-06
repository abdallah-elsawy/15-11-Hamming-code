module ShiftRegister
#(
	parameter WIDTH=11
)
(
	input clk,
	input reset,
	input write,
	input shift,
	input[WIDTH-1:0] data_in,
	input serial_in,
	output serial_out,
	output[WIDTH-1:0] data_out
    );

	reg[WIDTH-1:0] data;
	
	always @(posedge clk)
	begin
		if(reset==1)
			data<=0;
		else if(write==1)
			data<=data_in;
		else if(shift==1)//do shift right
			data<={serial_in,data[WIDTH-1:1]};
	end
	
	assign serial_out=data[0];
	
	assign data_out=data;
endmodule

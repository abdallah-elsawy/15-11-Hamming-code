module Hamming_Decoder(
input clk1,
input clk2,
input s_in,
input reset,
output s_out
);

//input register
wire [14:0] parallel_in;
ShiftRegister #(.WIDTH(15)) 
reg_in(
.clk(clk1),
.reset(0),
.write(0),
.shift(1),
.serial_in(s_in),
.data_in(0),
.data_out(parallel_in)
);

//decoder
wire [10:0] parallel_out;

decoder dec(
.c_h(parallel_in),
.data_out(parallel_out)
);

//counter
wire countfull;

counter counter (
.clk(clk2),
.en(1),
.reset(reset),
.full(countfull)
);

//output register
ShiftRegister #(.WIDTH(11)) 
reg_out (
.clk(clk2),
.reset(0),
.write(countfull),
.shift(1),
.data_in(parallel_out),
.serial_out(s_out)
);

endmodule






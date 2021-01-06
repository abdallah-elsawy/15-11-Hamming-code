module Hamming_Encoder(
input clk1,
input clk2,
input reset,
input s_in,
output s_out
);



//register input
wire [10:0] parallel_in;

ShiftRegister #(.WIDTH(11)) 
reg_in (
.clk(clk1),
.reset(0),
.write(0),
.shift(1),
.serial_in(s_in),
.data_in(0),
.data_out(parallel_in)
);

//encoder
wire [14:0] parallel_out;

encoder enc (
.data_in(parallel_in),
.c_h(parallel_out),
);

//counter_4bit
wire countfull;

counter counter(
.clk(clk1),
.en(1),
.reset(reset),
.full(countfull)
);

//output register

ShiftRegister #(.WIDTH(15))



reg_out (
.clk(clk2),
.reset(0),
.write(countfull),
.shift(1),
.data_in(parallel_out),
.serial_out(s_out)
);


endmodule


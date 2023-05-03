module signextend(in,out);
//this file extends 16 bits source to 32 bits
input [15:0] in;
output [31:0] out;

assign out = {{16{in[15]}},in};

endmodule
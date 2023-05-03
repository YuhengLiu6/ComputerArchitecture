`timescale 100fs/100fs
//this file implement  multiplexer for 32 bits
module Mux2to1_32(src1,src2,cout,ctr);

input ctr;
input [31:0]  src1, src2;
output reg [31:0] cout;

always @(src1,src2,ctr)
begin
    if (ctr==0)
        cout = src1;
    else
        cout = src2;
end
endmodule





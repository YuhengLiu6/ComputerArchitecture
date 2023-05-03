`timescale 100fs/100fs
//this file implement  multiplexer for 5 bits
module Mux2to1_5(src1,src2,cout,ctr);

input ctr;
input [4:0]  src1, src2;
output reg [4:0] cout;

always @(src1,src2,ctr)
begin
    if (ctr==0)
        cout = src1;
    else
        cout = src2;
end
endmodule
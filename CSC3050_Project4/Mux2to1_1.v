`timescale 100fs/100fs
//this file implement  multiplexer for 1 bit
module Mux2to1_1(src1,src2,cout,ctr);

input ctr;
input  src1, src2;
output reg  cout;

always @(src1,src2,ctr)
begin
    if (ctr==0)
        cout = src1;
    else
        cout = src2;
end
endmodule
`timescale 100fs/100fs
//this file implements the register file part
module RegisterFile(CLOCK,A1,A2,A3,WD3,RD1,RD2,RegWriteW);

input CLOCK,RegWriteW;
input [4:0] A1,A2,A3;
input [31:0] WD3;
output [31:0] RD1,RD2;

reg signed [31:0] AllReg[0:31];
initial
begin
AllReg[0]<=0;
AllReg[1]<=0;
AllReg[2]<=0;
AllReg[3]<=0;
AllReg[4]<=0;
AllReg[5]<=0;
AllReg[6]<=0;
AllReg[7]<=0;
AllReg[8]<=0;
AllReg[9]<=0;
AllReg[10]<=0;
AllReg[11]<=0;
AllReg[12]<=0;
AllReg[13]<=0;
AllReg[14]<=0;
AllReg[15]<=0;
AllReg[16]<=0;
AllReg[17]<=0;
AllReg[18]<=0;
AllReg[19]<=0;
AllReg[20]<=0;
AllReg[21]<=0;
AllReg[22]<=0;
AllReg[23]<=0;
AllReg[24]<=0;
AllReg[25]<=0;
AllReg[26]<=0;
AllReg[27]<=0;
AllReg[28]<=0;
AllReg[29]<=0;
AllReg[30]<=0;
AllReg[31]<=0;
end

always @(negedge CLOCK)
begin

    if (RegWriteW==1) 
        AllReg[A3] = WD3;
end
assign    RD1 = AllReg[A1];
assign    RD2 = AllReg[A2];
endmodule





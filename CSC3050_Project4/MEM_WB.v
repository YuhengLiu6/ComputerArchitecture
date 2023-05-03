`timescale 100fs/100fs
//this file implements the process of and the register between MEM stage and WB stage
module MEM_WB(CLOCK,PCplus4M,RegWriteM,MemtoRegM,MemWriteM,BranchM,ZeroM,ALUOutM,WriteDataM,PCBranchM,WriteRegM,ReadDataM,
PCplus4W,RegWriteW,MemtoRegW,ALUOutW,ReadDataW,WriteRegW,ResultW);

//define inputs and outputs with corresponding length and type
input CLOCK,PCplus4M,RegWriteM,MemtoRegM,MemWriteM,BranchM,ZeroM,WriteDataM,PCBranchM;
input [4:0] WriteRegM;
input [31:0] ALUOutM,ReadDataM;
output reg RegWriteW,MemtoRegW,ResultW;
output reg [4:0] WriteRegW;
output reg [31:0] ALUOutW,ReadDataW,PCplus4W;

always @(posedge CLOCK)
begin
    RegWriteW    <=    RegWriteM;
    MemtoRegW    <=    MemtoRegM;
    WriteRegW    <=    WriteRegM; 
    ALUOutW      <=    ALUOutM  ;
    ReadDataW    <=    ReadDataM;
    PCplus4W     <=    PCplus4M ;
end

endmodule















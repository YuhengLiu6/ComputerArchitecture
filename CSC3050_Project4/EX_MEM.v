`timescale 100fs/100fs
//this file implements the process of and the register between EX stage and MEM stage
module EX_MEM(CLOCK,RESET,RegWriteE,MemtoRegE,MemWriteE,BranchE,
ALUControlE,ALUSrcE,ALUSrc_shamtE,RegDstE,ALUOutE,ZeroE,WriteDataE,WriteRegE,
SrcAE,SrcBE,RtE,RdE,shamtE,SignImmE,PCplus4E,PCBranchE,
RegWriteM,MemtoRegM,MemWriteM,BranchM,
ALUOutM,WriteDataM,PCBranchM,ZeroM,PCplus4M,WriteRegM);

//define inputs and outputs with corresponding length and type
input CLOCK,RESET;
input shamtE,RegWriteE,MemtoRegE,MemWriteE,BranchE,RegDstE,RtE,RdE,ALUSrcE,ALUSrc_shamtE,ZeroE;
input  RD1E,RD2E,PCplus4E,SignImmE;
input [3:0] ALUControlE;
input [4:0] WriteRegE;
input [31:0] ALUOutE,SrcAE,SrcBE,WriteDataE,PCBranchE;
output reg RegWriteM,MemtoRegM,MemWriteM,BranchM,ZeroM;
output reg [31:0] ALUOutM,WriteDataM,PCBranchM,PCplus4M;
output reg [4:0] WriteRegM;

always @(posedge CLOCK) 
begin
    if (RESET!=1)
    begin
        RegWriteM    <=    RegWriteE     ;
        MemtoRegM    <=    MemtoRegE     ;
        MemWriteM    <=    MemWriteE     ;
        BranchM      <=    BranchE       ;
        ALUOutM      <=    ALUOutE       ;
        ZeroM        <=    ZeroE         ;
        WriteDataM   <=    WriteDataE    ;
        WriteRegM    <=    WriteRegE     ;
        PCBranchM    <=    PCBranchE      ;
        PCplus4M     <=    PCplus4E      ;
    end
    else
    begin
        RegWriteM    <=    0    ;
        MemtoRegM    <=    0    ;
        MemWriteM    <=    0    ;
        BranchM      <=    0    ;
        ALUOutM      <=    0    ;
        ZeroM        <=    0    ;
        WriteDataM   <=    0    ;
        WriteRegM    <=    0    ;
        PCBranchM    <=    0   ;
        PCplus4M     <=    0   ;
    end
end
endmodule












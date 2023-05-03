`timescale 100fs/100fs
//this file implements the process of and the register between ID stage and EX stage
module ID_EX(
CLOCK,RESET,RegWriteD,MemtoRegD,MemWriteD,BranchD,
ALUControlD,ALUSrcD,ALUSrc_shamtD,RegDstD,
RegWriteE,MemtoRegE,MemWriteE,BranchE,ALUControlE,ALUSrcE,ALUSrc_shamtE,RegDstE,
RD1D,RD2D,RtD,RdD,shamtD,SignImmD,PCplus4D,
RD1E,RD2E,RtE,RdE,shamtE,SignImmE,PCplus4E
);

//define inputs and outputs with corresponding length and type
input CLOCK,RESET,RegWriteD,MemtoRegD,MemWriteD,BranchD,ALUSrcD,RegDstD,ALUSrc_shamtD,ZeroD;
input [3:0] ALUControlD;
input [4:0] RtD,RdD,shamtD;
input [31:0] RD1D,RD2D,PCplus4D, SignImmD;
output reg RegWriteE,MemtoRegE,MemWriteE,BranchE,ALUSrcE,ALUSrc_shamtE,RegDstE;
output reg [3:0] ALUControlE;
output reg [4:0] RtE,RdE,shamtE;
output reg [31:0] RD1E,RD2E,PCplus4E,SignImmE;

always @(posedge CLOCK) 
begin
    if(RESET!=1)
    begin
        RegWriteE         <=   RegWriteD     ;                     
        MemtoRegE         <=   MemtoRegD     ;                    
        MemWriteE         <=   MemWriteD     ;                      
        BranchE           <=   BranchD       ;                    
        ALUControlE       <=   ALUControlD   ;                          
        ALUSrcE           <=   ALUSrcD       ;                   
        ALUSrc_shamtE    <=   ALUSrc_shamtD  ;                        
        RegDstE           <=   RegDstD       ;                   
        RD1E              <=   RD1D          ;                     
        RD2E              <=   RD2D          ;                
        RtE               <=   RtD           ;                     
        RdE               <=   RdD           ;                     
        shamtE            <=   shamtD        ;                      
        SignImmE          <=   SignImmD      ;                     
        PCplus4E          <=   PCplus4D      ;
    end
    else
    begin
        RegWriteE         <=   0;                     
        MemtoRegE         <=   0;                    
        MemWriteE         <=   0;                      
        BranchE           <=   0;                    
        ALUControlE       <=   0;                          
        ALUSrcE           <=   0;                   
        ALUSrcE           <=   0;                        
        RegDstE           <=   0;                   
        RD1E              <=   0;                     
        RD2E              <=   0;                
        RtE               <=   0;                     
        RdE               <=   0;                     
        shamtE            <=   0;                      
        SignImmE          <=   0;                     
        PCplus4E          <=   0;
    end
end
endmodule







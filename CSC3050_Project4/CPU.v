`timescale 100fs/100fs
`include "ALU.v"
`include "controlunit.v"
`include "IF_ID.v"
`include "ID_EX.v"
`include "EX_MEM.v"
`include "MEM_WB.v"
`include "PCReg.v"
`include "InstructionRAM.v"
`include "MainMemory.v"
`include "Mux2to1_32.v"
`include "Mux2to1_1.v"
`include "Mux2to1_5.v"
`include "RegisterFile.v"
`include "signextend.v"

module CPU(CLOCK, RESET);

input CLOCK,RESET;
reg ENABLE = 1'b1;
wire [31:0] InstrF;
wire [31:0] InstrD;
wire [31:0] PCF,PC;
wire [31:0] PCPlus4F,PCBranchM;

//select PCPlus4F and PCBranchM
Mux2to1_32 Mux2to1_0(
    .src1 (PCPlus4F),
    .src2 (PCBranchM),
    .cout (PC),
    .ctr  (zeroM)
);

//first stage----Instruction fetch--------------------------------------------------------------------------
wire [31:0] PCplus4W;

//implementation to write back to instruction fetch part
PCReg PCReg_1(
    .CLOCK    (CLOCK),
    .RESET    (RESET),
    .PCPlus4Fin(PC),
    .PCF       (PCF)
);

//access instruction memory
InstructionRAM InstructionRAM_1(                  
    .RESET               (RESET),            
    .ENABLE              (ENABLE),             
    .FETCH_ADDRESS       (PCF>>2),                                          
    .DATA                (InstrF)           
);

//second stage----Instruction fetch--------------------------------------------------------------------------
wire [31:0] PCplus4D;
IF_ID IF_ID_1(
    .CLOCK        (CLOCK),
    .RESET        (RESET),
    .ins          (InstrF),
    .PCPlus4F    (PCF+4),
    .new_ins      (InstrD),
    .PCPlus4D     (PCplus4D),
    .PCPlus4Fout(PCPlus4F)
);


//control unit
wire RegWriteD,MemtoRegD,MemWriteD,BranchD,ALUSrcD,RegDstD;
wire [3:0] ALUControlD;
controlunit controlunit_1(
    .op             (InstrD[31:26]),           
    .func           (InstrD[5:0]),                  
    .RegWriteD       (RegWriteD),      
    .MemtoRegD      (MemtoRegD),      
    .MemWriteD       (MemWriteD),      
    .BranchD         (BranchD),    
    .ALUControlD     (ALUControlD),        
    .ALUSrcD         (ALUSrcD),    
    .ALUSrc_shamt   (ALUSrc_shamtE),          
    .RegDstD         (RegDstD)    
);


wire [31:0] RD1D,RD2D,ResultW;
wire [4:0] WriteRegW;
RegisterFile RegisterFile_1(
    .CLOCK        (CLOCK),                   
    .A1           (InstrD[25:21]),                                  
    .A2           (InstrD[20:16]),                      
    .A3           (WriteRegW),                      
    .WD3          (ResultW),                      
    .RegWriteW    (RegWriteW),                             
    .RD1          (RD1D),                       
    .RD2          (RD2D)                       
);

wire [31:0] SignImmD;
signextend signextend_1(
    .in  (InstrD[15:0]),
    .out (SignImmD)
);

//third stage----executing--------------------------------------------------------------------------
wire RegWriteE,MemtoRegE,MemWriteE,BranchE,ALUSrcE,RegDstE,ALUSrc_shamtD,ALUSrc_shamtE;
wire [3:0] ALUControlE;
wire [4:0] RtE,RdE,shamtE;
wire [31:0] RD1E,RD2E,PCplus4E,SignImmE;

ID_EX ID_EX_1(
    .CLOCK           (CLOCK), 
    .RESET           (RESET),                        
    .RegWriteD       (RegWriteD),                          
    .MemtoRegD       (MemtoRegD),                      
    .MemWriteD       (MemWriteD),                      
    .BranchD         (BranchD),                    
    .ALUControlD     (ALUControlD),                        
    .ALUSrcD         (ALUSrcD),                    
    .ALUSrc_shamtD    (ALUSrc_shamtD),                          
    .RegDstD         (RegDstD),                    
    .RD1D            (RD1D),                 
    .RD2D            (RD2D),                 
    .RtD             (InstrD[20:16]),                
    .RdD             (InstrD[15:11]),
    .shamtD           (InstrD[10:6]),                
    .SignImmD        (SignImmD),                     
    .PCplus4D        (PCplus4D),

    .RegWriteE          (RegWriteE),                   
    .MemtoRegE          (MemtoRegE),                   
    .MemWriteE          (MemWriteE),                   
    .BranchE            (BranchE),                 
    .ALUControlE        (ALUControlE),                     
    .ALUSrcE            (ALUSrcE),                 
    .ALUSrc_shamtE      (ALUSrc_shamtE),                       
    .RegDstE            (RegDstE),                 
    .RD1E               (RD1E),              
    .RD2E               (RD2E),              
    .RtE                (RtE),             
    .RdE                (RdE),
    .shamtE             (shamtE),             
    .SignImmE           (SignImmE),                  
    .PCplus4E           (PCplus4E)
);   



//three multiplexers

//select SrcAE
wire [31:0] SrcAE,SrcBE;
wire [4:0] WriteRegE;
Mux2to1_32 Mux2to1_1(
    .src1    (RD1E),
    .src2    ({27'b0,shamtE}),
    .ctr     (ALUSrc_shamtE),
    .cout    (SrcAE)
);

//select SrcBE
Mux2to1_32 Mux2to1_2(
    .src1    (RD2E),
    .src2    (SignImmE),
    .ctr     (ALUSrcE),
    .cout    (SrcBE)
);

//select WriteRegE
Mux2to1_5 Mux2to1_3(
    .src1    (RtE),
    .src2    (RdE),
    .ctr     (RegDstE),
    .cout    (WriteRegE)
);


wire [31:0] ALUOutE;
wire zeroE;
//ALU selects SrcAE and SrcBE
ALU ALU_1(
    .SrcAE   (SrcAE),
    .SrcBE   (SrcBE),
    .ALUControlE  (ALUControlE),
    .cout     (ALUOutE),
    .zero     (zeroE)    
);


//fourth stage----memory--------------------------------------------------------------------------
wire RegWriteM,MemtoRegM,MemWriteM,zeroM;
wire [31:0] ALUOutM,WriteDataM;
wire [4:0] WriteRegM;
EX_MEM EX_MEM_1(
    .CLOCK              (CLOCK),
    .RESET              (RESET),
    .RegWriteE        (RegWriteE),                                       
    .MemtoRegE        (MemtoRegE),                                    
    .MemWriteE        (MemWriteE),                                    
    .BranchE          (BranchE),                                  
    .ALUOutE          (ALUOutE),                                  
    .ZeroE            (zeroE),                                
    .WriteDataE       (RD2E),                                     
    .WriteRegE        (WriteRegE),                                    
    .PCBranchE        ((SignImmE<<2)+PCplus4E),
                                  
    .RegWriteM           (RegWriteM),                                 
    .MemtoRegM           (MemtoRegM),                                 
    .MemWriteM           (MemWriteM),                                 
    .BranchM             (BranchM),                               
    .ALUOutM             (ALUOutM),                               
    .ZeroM               (zeroM),                             
    .WriteDataM          (WriteDataM),                                  
    .WriteRegM           (WriteRegM),                                 
    .PCBranchM           (PCBranchM)                                 
);


wire [31:0] ReadDataM;
//access main memory
MainMemory MainMemory_1(
    .CLOCK                    (CLOCK),                   
    .RESET                    (RESET),     
    .ENABLE                   (MemWriteM),      
    .FETCH_ADDRESS            (ALUOutM>>2),
    .EDIT_SERIAL              ({MemWriteM,ALUOutM[31:0]>>2,WriteDataM[31:0]}),             
    .DATA                     (ReadDataM)    
);



//fifth stage--Write back--------------------------------------------------------------------------
wire MemtoRegW;
wire [31:0] ALUOutW,ReadDataW;

MEM_WB MEM_WB_1(
    .CLOCK           (CLOCK),                            
    .RegWriteM       (RegWriteM),                    
    .MemtoRegM       (MemtoRegM),                    
    .ALUOutM         (ALUOutM),                  
    .ReadDataM       (ReadDataM),                    
    .WriteRegM       (WriteRegM),
                  
    .RegWriteW       (RegWriteW),                 
    .MemtoRegW       (MemtoRegW),                 
    .ALUOutW         (ALUOutW),               
    .ReadDataW       (ReadDataW),                 
    .WriteRegW       (WriteRegW)                 
);

//select ALUOutW and ReadDataW
Mux2to1_32 Muxmem(
    .src1   (ALUOutW),
    .src2   (ReadDataW),
    .ctr    (MemtoRegW),
    .cout   (ResultW) 
);


endmodule
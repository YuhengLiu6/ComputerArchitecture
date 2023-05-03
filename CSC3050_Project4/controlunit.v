`timescale 100fs/100fs

module controlunit(op,func,RegWriteD,MemtoRegD,MemWriteD,BranchD,
ALUControlD,ALUSrcD,ALUSrc_shamt,RegDstD);

input [5:0] op,func;
output reg RegWriteD,MemtoRegD,MemWriteD,BranchD,ALUSrcD,ALUSrc_shamt,RegDstD;
output reg[3:0] ALUControlD;

initial begin
    RegWriteD     =0;
    MemtoRegD     =0;
    MemWriteD     =0;
    BranchD       =0;
    ALUControlD   =4'b0000;
    ALUSrcD       =0;
    ALUSrc_shamt  =0;
    RegDstD       =0;
end

always@(op,func) begin
    case(op)
    6'b000000:
    begin
        case(func)
        6'b100000://add
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0010;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b100001://addu
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0010;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b100010://sub
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0110;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b100011://subu
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0110;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b100100://and
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0000;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b100111://nor
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b1100;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b100101://or
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0001;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b100110://xor
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0011;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b000000://sll
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0100;
            ALUSrcD     =0;
            ALUSrc_shamt=1;
            RegDstD     =1;
        end
        6'b000100://sllv
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0100;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b000010://srl
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0101;
            ALUSrcD     =0;
            ALUSrc_shamt=1;
            RegDstD     =1;
        end
        6'b000110://srlv
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0101;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b000011://sra
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b1000;
            ALUSrcD     =0;
            ALUSrc_shamt=1;
            RegDstD     =1;
        end
        6'b000111://srav
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b1000;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        6'b001000://jr
        begin
            RegWriteD   =0;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b1110;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =0;
        end
        6'b101010://slt
        begin
            RegWriteD   =1;
            MemtoRegD   =0;
            MemWriteD   =0;
            BranchD     =0;
            ALUControlD =4'b0111;
            ALUSrcD     =0;
            ALUSrc_shamt=0;
            RegDstD     =1;
        end
        endcase
    end
    6'b100011://lw
    begin
        RegWriteD   =1;
        MemtoRegD   =1;
        MemWriteD   =0;
        BranchD     =0;
        ALUControlD =4'b0010;
        ALUSrcD     =1;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b101011://sw
    begin
        RegWriteD   =0;
        MemtoRegD   =0;
        MemWriteD   =1;
        BranchD     =0;
        ALUControlD =4'b0010;
        ALUSrcD     =1;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b001000://addi
    begin
        RegWriteD   =1;
        MemtoRegD   =0;
        MemWriteD   =0;
        BranchD     =0;
        ALUControlD =4'b0010;
        ALUSrcD     =1;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b001001://addiu
    begin
        RegWriteD   =1;
        MemtoRegD   =0;
        MemWriteD   =0;
        BranchD     =0;
        ALUControlD =4'b0010;
        ALUSrcD     =1;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b001100://andi
    begin
        RegWriteD   =1;
        MemtoRegD   =0;
        MemWriteD   =0;
        BranchD     =0;
        ALUControlD =4'b1111;
        ALUSrcD     =1;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b001101://ori
    begin
        RegWriteD   =1;
        MemtoRegD   =0;
        MemWriteD   =0;
        BranchD     =0;
        ALUControlD =4'b1101;
        ALUSrcD     =1;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b001110://xori
    begin
        RegWriteD   =1;
        MemtoRegD   =0;
        MemWriteD   =0;
        BranchD     =0;
        ALUControlD =4'b1110;
        ALUSrcD     =1;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b000100://beq
    begin
        RegWriteD   =0;
        MemtoRegD   =0;
        MemWriteD   =0;
        BranchD     =1;
        ALUControlD =4'b1001;
        ALUSrcD     =0;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b000101://bne
    begin
        RegWriteD   =0;
        MemtoRegD   =0;
        MemWriteD   =0;
        BranchD     =1;
        ALUControlD =4'b1010;
        ALUSrcD     =0;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b000010://j
    begin
        RegWriteD   =0;
        MemtoRegD   =0;
        MemWriteD   =0;
        BranchD     =0;
        ALUControlD =4'b1101;
        ALUSrcD     =0;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    6'b000011://jal
    begin
        RegWriteD   =0;
        MemtoRegD   =0;
        MemWriteD   =0;
        BranchD     =0;
        ALUControlD =4'b1101;
        ALUSrcD     =0;
        ALUSrc_shamt=0;
        RegDstD     =0;
    end
    endcase
    
end

endmodule

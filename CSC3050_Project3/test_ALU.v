`timescale 1ns/1ps

module alu_test;

reg[31:0] instruction, regA, regB;

wire[31:0] result;
wire[2:0] flags;
//wire zero;
//wire overflow;
//wire neg;

alu testalu(instruction, regA, regB, result, flags);

initial
begin

$display("instruction:op:func:result:     alusrc1:                        alusrc2:                      flags:");
$monitor("   %h:%h: %h :%h:%b:%b:%b",
instruction, testalu.opcode, testalu.func, result, testalu.alusrc1, testalu.alusrc2, testalu.flags);

//// logical left shift
#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0110_0000;//add
regA<=32'b1000_0000_0000_0000_0000_0000_0000_1001;
regB<=32'b1000_0000_0000_0000_0000_0000_0000_0101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0110_0000;//add
regA<=32'b0000_0000_0000_0000_0000_0000_1100_1001;
regB<=32'b0000_0000_0000_0000_0000_0000_0011_0101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0110_0001;//addu
regA<=32'b0100_0000_0000_0000_0000_0000_0000_1001;
regB<=32'b0100_0000_0000_0000_0000_0000_0000_0101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0110_0100;//and
regA<=32'b1000_0000_0000_0000_0000_0000_0000_1001;
regB<=32'b1000_0000_0000_0000_0000_0000_0000_0101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0110_0111;//nor
regA<=32'b1011_0000_0000_0000_0000_0000_0000_1001;
regB<=32'b1010_1111_0000_0000_0000_0000_0000_0101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0110_0101;//or
regA<=32'b1011_0000_1111_0000_1111_0000_1111_1011;
regB<=32'b1010_1111_0000_1111_0000_1111_0000_0101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0110_0110;//xor
regA<=32'b1011_0000_0000_0000_0000_0000_0000_1001;
regB<=32'b1010_1111_0000_0000_0000_0000_0000_0101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0100_0000;//sll
regA<=32'b1011_0000_0000_0000_0000_0000_0000_1001;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0100_0100;//sllv
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0110_1010;//slt
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_0110_1011;//sltu
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_1100_0011;//sra
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_1100_0111;//srav
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0111;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_1100_0010;//srl
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_1100_0110;//srlv
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_1110_0010;//sub
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0000_0000_0000_0001_0001_0000_1110_0010;//subu
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0010_0000_0000_0001_1111_1111_1111_1111;//addi
regA<=32'b1111_1111_1111_1111_1111_1111_1111_1111;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0010_0100_0000_0001_1000_0000_0000_0010;//addiu
regA<=32'b1111_1111_1111_1111_1111_1111_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0011_0000_0000_0001_1000_0000_0000_0000;//andi
regA<=32'b0000_1111_1111_1111_1111_1111_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0001_0000_0000_0001_1000_0000_1111_1110;//beq
regA<=32'b0000_1111_1111_1111_1111_1111_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0001_0100_0000_0001_1000_0000_1111_1110;//bne
regA<=32'b1101_1101_1101_1101_1101_1101_1101_1100;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b1000_1100_0000_0001_1000_0000_1111_1111;//lw
regA<=32'b1101_1101_1101_1101_1101_1101_1101_1101;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b1010_1100_0000_0001_1000_0000_1111_1111;//sw
regA<=32'b1101_1101_1101_1101_1101_1101_1101_1101;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0011_0100_0000_0001_1111_1111_1111_1111;//ori
regA<=32'b1011_0000_0000_0000_0000_0000_0000_1001;
regB<=32'b1010_1111_0000_0000_0000_0000_0000_0101;

#10 instruction<=32'b0011_1000_0000_0001_0001_0000_0110_0110;//xori
regA<=32'b1011_0000_0000_0000_0000_0000_0000_1001;
regB<=32'b1010_1111_0000_0000_0000_0000_0000_0101;

#10 instruction<=32'b0010_1000_0000_0001_0001_0000_0110_1010;//slti
regA<=32'b1000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0010_1000_0000_0001_1001_0000_0110_1010;//slti
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b0101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0010_1100_0000_0001_1001_0000_0110_1010;//sltiu
regA<=32'b0000_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b1101_1101_1101_1101_1101_1101_1101_1101;

#10 instruction<=32'b0010_1100_0000_0001_1001_0000_0110_1010;//sltiu
regA<=32'b1100_0000_0000_0000_0000_0000_0000_0011;
regB<=32'b0001_1101_1101_1101_1101_1101_1101_1101;

#10 $finish;
end
endmodule
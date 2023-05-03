module alu(instruction, regA, regB, result, flags);

input[31:0] instruction;
input[31:0] regA, regB;

output[31:0] result;
output[2:0]flags;

reg[5:0] opcode, func;
reg[4:0] sa;
reg[31:0] alusrc1, alusrc2;
reg[31:0] reg_C;
reg[2:0] temp_flag;
reg[15:0] im;




always @(instruction, regA, regB)
begin

opcode = instruction[31:26];
func = instruction[5:0];
sa = instruction[10:6];
im = instruction[15:0];

case(opcode)
6'b000000:
begin
    case(func)
    6'b100000://add
    begin   
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = alusrc1 + alusrc2;
        if (alusrc1[31] & alusrc2[31] & ~reg_C[31])
        begin
            temp_flag = 3'b100;
        end
        else if (~alusrc1[31] & ~alusrc2[31] & reg_C[31])
        begin
            temp_flag = 3'b100;
        end
        else
        begin
            temp_flag = 3'b000;
        end
    end

    6'b100001://addu
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = alusrc1 + alusrc2;
        temp_flag = 3'b000;
    end

    6'b100100://and
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = alusrc1 & alusrc2;
        temp_flag = 3'b000;
    end

    6'b100111://nor
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = (~alusrc1) & (~alusrc2);
        temp_flag = 3'b000;
    end

    6'b100101://or
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = alusrc1 | alusrc2;
        temp_flag = 3'b000;
    end

    6'b100110://xor
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = ((~alusrc1)&alusrc2)|(alusrc1&(~alusrc2));
        temp_flag = 3'b000;
    end

    6'b000000://sll
    begin
        alusrc1 = regB;
        alusrc2 = sa;
        reg_C = alusrc1 << alusrc2;
        temp_flag = 3'b000;
    end

    6'b000100://sllv
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = alusrc2 << alusrc1;
        temp_flag = 3'b000;
    end

    6'b101010://slt  
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        if (($signed(alusrc1) - $signed(alusrc2)) < 1'b0)
        begin
            reg_C = 1'b1;
            temp_flag = 3'b010;
        end
        else
        begin
            reg_C = 1'b0;
            temp_flag = 3'b000;
        end
    end

    6'b101011://sltu
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        if (alusrc1 < alusrc2)
        begin
            reg_C = 1'b1;
            temp_flag = 3'b010;
        end
        else
        begin
            reg_C = 1'b0;
            temp_flag = 3'b000;
        end
    end

    6'b000011://sra
    begin
        alusrc1 = regB;
        alusrc2 = sa; 
        reg_C = $signed(alusrc1) >>> sa;      
        temp_flag = 3'b000;
    end

    6'b000111://srav
    begin
        alusrc1 = regA;
        alusrc2 = regB; 
        reg_C = $signed(alusrc2) >>> alusrc1;      
        temp_flag = 3'b000;
    end

    6'b000010://srl
    begin
        alusrc1 = regB;
        alusrc2 = sa; 
        reg_C = alusrc1 >> alusrc2;      
        temp_flag = 3'b000;
    end    

    6'b000110://srlv
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = alusrc2 >> alusrc1;
        temp_flag = 3'b000;
    end

    6'b100010://sub
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = alusrc1 - alusrc2; 
        if (alusrc1[31] & ~alusrc2[31] & ~reg_C[31])
        begin
            temp_flag = 3'b100;
        end
        else if (~alusrc1[31] & alusrc2[31] & reg_C[31])
        begin
            temp_flag = 3'b100;
        end
        else
        begin
            temp_flag = 3'b000;
        end
    end

    6'b100011://subu
    begin
        alusrc1 = regA;
        alusrc2 = regB;
        reg_C = alusrc1 - alusrc2; 
        temp_flag = 3'b000;
    end
    endcase
end

6'b001000://addi
begin
alusrc1 = regA;
alusrc2 = {{16{im[15]}},im};
reg_C = alusrc1 + alusrc2;
if (alusrc1[31] & alusrc2[31] & ~reg_C[31])
begin
    temp_flag = 3'b100;
end
else if (~alusrc1[31] & ~alusrc2[31] & reg_C[31])
begin
    temp_flag = 3'b100;
end
else
begin
    temp_flag = 3'b000;
end
end

6'b001001://addiu
begin
    alusrc1 = regA;
    alusrc2 = im;
    reg_C = regA + im;
    temp_flag = 3'b000;
end

6'b001100://andi
begin
    alusrc1 = regA;
    alusrc2 = im;
    reg_C = alusrc1 & alusrc2;
    temp_flag = 3'b000;
end   

6'b000100://beq
begin
    alusrc1 = regA;
    alusrc2 = regB;
    if (alusrc1 == alusrc2)
    begin
        reg_C = im;
        temp_flag = 3'b001;
    end
    else
    begin
        reg_C = 32'b0;
        temp_flag = 3'b000;
    end
end

6'b000101://bne
begin
    alusrc1 = regA;
    alusrc2 = regB;
    if ((alusrc1 - alusrc2) != 0)
    begin
        reg_C = im;
        temp_flag = 3'b000;
    end
    else
    begin
        reg_C = 32'b0;
        temp_flag = 3'b001;
    end
end

6'b100011://lw
begin
    alusrc1 = regA;
    alusrc2 = im;
    reg_C = alusrc1 + alusrc2;
    temp_flag = 3'b000;
end

6'b101011://sw
begin
    alusrc1 = regA;
    alusrc2 = im;
    reg_C = alusrc1 + alusrc2;
    temp_flag = 3'b000;
end

6'b001101://ori
begin
    alusrc1 = regA;
    alusrc2 = im;
    reg_C = alusrc1 | alusrc2;
    temp_flag = 3'b000;
end

6'b001110://xori
begin
    alusrc1 = regA;
    alusrc2 = im;
    reg_C = ((~alusrc1)&alusrc2)|(alusrc1&(~alusrc2));
    temp_flag = 3'b000;
end

6'b001010://slti
begin
    alusrc1 = regA;
    alusrc2 = {{16{im[15]}},im};
    if (($signed(alusrc1) - $signed(alusrc2))<1'b0)
    begin
        reg_C = 1'b1;
        temp_flag = 3'b010;
    end
    else
    begin
        reg_C = 1'b0;
        temp_flag = 3'b000;
    end
end

6'b001011://sltiu
begin
    alusrc1 = regA;
    alusrc2 = {{16{im[15]}},im};
    if (alusrc1 < alusrc2)
    begin
        reg_C = 1'b1;
        temp_flag = 3'b010;
    end
    else
    begin
        reg_C = 1'b0;
        temp_flag = 3'b000;
    end
end
endcase

end

assign result = reg_C[31:0];
assign flags = temp_flag[2:0];

endmodule


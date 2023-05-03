`timescale 100fs/100fs

module ALU(SrcAE,SrcBE,cout,ALUControlE,zero);

input signed [31:0] SrcAE,SrcBE;
input [3:0] ALUControlE;
output [31:0] cout;
output reg zero;

reg [31:0] alusrc1,alusrc2,temp;

always @(SrcAE,SrcBE,ALUControlE)
begin
    zero = 0;
    alusrc1 = SrcAE;
    alusrc2 = SrcBE;
    case(ALUControlE)
        4'b0000: temp=alusrc1&alusrc2;//and
        4'b1111: temp=alusrc1&{{16'b0},alusrc2[15:0]};//andi
        4'b0001: temp=alusrc1|alusrc2;// or 
        4'b1101: temp=alusrc1|{{16'b0},alusrc2[15:0]};//ori
        4'b0010: temp=alusrc1+alusrc2;// add
        4'b0110: temp=alusrc1-alusrc2;// sub 
        4'b0111: // slt
        begin
            if (alusrc1<alusrc2) temp = 32'b1;
            else temp = 32'b0;
        end
        4'b1100: temp=~(alusrc1|alusrc2);// nor
        4'b0011: temp=(alusrc1^alusrc2);// xor 
        4'b1110: temp=alusrc1^{{16'b0},alusrc2[15:0]};//xori
        4'b0100: temp=$unsigned(alusrc2)<<alusrc1;// sll 
        4'b0101: temp=$unsigned(alusrc2)>>alusrc1;// srl 
        4'b1000: temp=($signed(alusrc2))>>>alusrc1;// sra 
        4'b1001: // beq
        begin
            if (alusrc1 == alusrc2)
            begin
                temp = 32'b1;
                zero = 1;
            end
            else
            begin
                temp = 32'b0;
                zero = 0;
            end
        end
        4'b1010: // bne
        begin
            if (alusrc1 != alusrc2)
            begin
                temp = 32'b1;
                zero = 1;
            end
            else
            begin
                temp = 32'b0;
                zero = 0;
            end
        end

    endcase
end
assign cout = temp;

endmodule
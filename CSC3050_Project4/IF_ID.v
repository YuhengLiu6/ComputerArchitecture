`timescale 100fs/100fs
//this file implements the process of and the register between IF stage and ID stage
module IF_ID(CLOCK,RESET,PCPlus4D,PCPlus4F,ins,new_ins,PCPlus4Fout);

//define inputs and outputs with corresponding length and type
input CLOCK,RESET;
input [31:0] ins,PCPlus4F;
output reg [31:0] new_ins,PCPlus4D;
output [31:0] PCPlus4Fout;

reg [31:0] PC;

always @(posedge CLOCK)
begin 
  if (RESET!=1)
  begin
    new_ins  <= ins ;
    PCPlus4D   <= PCPlus4F;
  end
  else
  begin
    new_ins <= 32'b0;
    PCPlus4D  <= 0;
    PC <= 0;
  end
end
assign PCPlus4Fout = PCPlus4F;

endmodule
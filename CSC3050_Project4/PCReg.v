`timescale 100fs/100fs
//this file implements the first part to set PC register
module PCReg(CLOCK,RESET,PCPlus4Fin,PCF);

input CLOCK,RESET;
input [31:0] PCPlus4Fin;
output reg [31:0] PCF;

always @(posedge CLOCK)
begin
    if(RESET!=1)
        PCF = PCPlus4Fin;
    else begin
        PCF <= 0;
    end
end

endmodule






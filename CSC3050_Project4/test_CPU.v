`include "CPU.v"

module testbench;

integer result_1;
integer i = 0;
reg CLOCK = 1'b0;
reg RESET = 1'b1;

CPU cpu(
    .CLOCK (CLOCK), 
    .RESET  (RESET)
    );

initial 
begin 
    RESET = 1;#100;RESET = 0;
end

initial begin
    
    CLOCK = ~CLOCK;#50;
    CLOCK = ~CLOCK;#50;// Initialization

    repeat(600) 
    begin

        // $display("%d",cpu.PCPlus4F);
        // $display("%d",cpu.PCF);
        // $display("%d",cpu.PCplus4D);
        // $display("%d",cpu.zeroM);

        // $display("%b",cpu.InstrF);
        // $display("%d",cpu.MemtoRegD);
        // $display("%d",cpu.ALUOutM);
        // $display("%d",cpu.WriteDataM);
        // $display("%d",cpu.MemWriteM);



        // $display("%b",cpu.ResultW);
        // $display("%b",cpu.RegWriteW);


        // $display("%d",cpu.WriteDataM);


        // $display("%b",cpu.ALUControlD);
        CLOCK = ~CLOCK;#50;
        CLOCK = ~CLOCK;#50;

    if (cpu.InstrF == 32'hffffffff) begin // if InstrF ==32'hffffffff, the program ends.
        repeat(10)                             
        begin
        // $display("%b",cpu.InstrF);
        // $display("%d",cpu.MemtoRegD);
        // $display("%d",cpu.ALUOutM);
        // $display("%d",cpu.RD2D);
        
        // $display("%d",cpu.RD2E);
        // $display("%d",cpu.MemWriteM);

        CLOCK = ~CLOCK;#50;CLOCK = ~CLOCK;#50;

        end

        result_1 = $fopen("result1.txt","w"); //dump process
        repeat(512)
        begin 
            $fwrite(result_1,"%b\n",cpu.MainMemory_1.DATA_RAM[i]);
            i = i + 1;
        end

        $fclose(result_1);

        
        $finish;
    end
    end
end
endmodule



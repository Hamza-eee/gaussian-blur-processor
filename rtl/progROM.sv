//-----------------------------------------------------
// File Name   : progROM.sv
// Function    : Program Memory holding the instructions in a sync ROM
// Version     : 2.0
// Author      : Hamza Alhalabi, alhalabihamzawrk@gmail.com
// Date        : 06 Feb 2026
//-----------------------------------------------------
module progROM #( INSTRUCNUM = 16, INSTRUCSIZE = 10) (
    input logic [$clog2(INSTRUCNUM)-1:0] instrucAddr,
    output logic [INSTRUCSIZE-1:0] controlWord
);
    logic [INSTRUCSIZE-1:0] progMem [INSTRUCNUM-1:0];

    initial
        $readmemb("data/prog.text", progMem);

    always_comb
        controlWord = progMem[instrucAddr];

endmodule

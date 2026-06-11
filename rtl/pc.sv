//-----------------------------------------------------
// File Name   : pc.sv
// Function    : Program counter freezed by SW8
// Version     : 2.0
// Author      : Hamza Alhalabi, alhalabihamzawrk@gmail.com
// Date        : 07 April 2026
//-----------------------------------------------------
// `define LASTADDR 4'h0F

module pc #( INSTRUCNUM=16 ) (
    input logic clk, nRst,
    output logic [$clog2(INSTRUCNUM)-1:0] instrucAddr
);
    wire notLastInstruc;
    assign notLastInstruc = ~&instrucAddr; // NAND, true unless it's the last address 4'b1111

    always_ff @( posedge clk, negedge nRst) begin : program_counter
        if(~nRst)
            instrucAddr <= '0;
        else if (notLastInstruc)
            instrucAddr <= instrucAddr + 4'b0001;
    end

endmodule

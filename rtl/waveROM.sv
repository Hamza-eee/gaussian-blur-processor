//-----------------------------------------------------
// File Name   : waveROM.sv
// Function    : ROM that holds the wave samples
// Version     : 1.0
// Author      : Hamza Alhalabi, alhalabihamzawrk@gmail.com
// Date        : 06 Feb 2026
//-----------------------------------------------------
module waveROM #(NUMSAMPLES=256, DWIDTH=8)(
    input logic [7:0] waveAddr,
    output logic [DWIDTH-1:0] waveSample
);
    logic [DWIDTH-1:0] waveMem [NUMSAMPLES-1:0];

    initial
        $readmemh("data/wave.hex", waveMem);

    always_comb
        waveSample = waveMem[waveAddr];
endmodule

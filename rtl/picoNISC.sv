//-----------------------------------------------------
// File Name   : picoNISC.sv
// Function    : top level module
// Version     : 3.0
// Author      : Hamza Alhalabi, alhalabihamzawrk@gmail.com
// Date        : 06 Apr 2026
//-----------------------------------------------------
module picoNISC #(parameter DWIDTH = 8) (
    input  logic clk,
    input  logic [9:0] SW,
    output logic [7:0] LED
);
    parameter INSTRUCNUM = 16;
    parameter INSTRUCSIZE = 10;

    // wires
    wire [DWIDTH-1:0] acc_reg, ps_reg, waveAddr_reg;
    wire [DWIDTH-1:0] res_mul, waveSample;
    wire [DWIDTH-1:0] res_add, a_add, b_add;
    wire [$clog2(INSTRUCNUM)-1:0] instrucAddr;
    wire [INSTRUCSIZE-1:0] controlWord;
    wire [5:0] dataImm;
    wire op, selA;
    wire [1:0]selB;
    wire nRst;
    wire [7:0] swImm;

    // control word decode
    assign op   = controlWord[INSTRUCSIZE-1];
    assign selA = controlWord[INSTRUCSIZE-2];
    assign selB = controlWord[INSTRUCSIZE-3:INSTRUCSIZE-4];
    assign dataImm = controlWord[5:0];

    //Switch assignments
    assign nRst  = SW[9] & SW[8];
    assign swImm = SW[7:0];
    assign LED = acc_reg;

    // module instances
    adder #(.DWIDTH(DWIDTH)) adder (
        .a_add(a_add),
        .b_add(b_add),
        .res_add(res_add)
    );

    mul #(.DWIDTH(DWIDTH)) mul (
        .a_mul(waveSample),
        .b_mul({{2'b0}, dataImm}),
        .res_mul(res_mul)
    );

    adderMux #(.DWIDTH(DWIDTH)) mux (
    //selection signals
    .selA(selA),
    .selB(selB),
    //muxA inputs
    .acc_reg(acc_reg),
    .waveAddr_reg(waveAddr_reg),
    //muxB inputs
    .swImm(swImm),
    .dataImm(dataImm),
    .ps_reg(ps_reg),
    //muxes outputs
    .muxA_out(a_add),
    .muxB_out(b_add)
    );

    regBank #(.DWIDTH(DWIDTH)) regBank (
        .clk(clk),
        .nRst(nRst),
        .psEn(op),
        .accEn(selB[1]),
        .waveEn(selA),
        .res_add(res_add),
        .res_mul(res_mul),
        .acc_reg(acc_reg),
        .ps_reg(ps_reg),
        .waveAddr_reg(waveAddr_reg)
    );

    waveROM #(.NUMSAMPLES(256), .DWIDTH(DWIDTH)) waveROM (
        .waveAddr(waveAddr_reg),
        .waveSample(waveSample)
    );

    progROM #(.INSTRUCNUM(INSTRUCNUM), .INSTRUCSIZE(INSTRUCSIZE)) progROM (
        .instrucAddr(instrucAddr),
        .controlWord(controlWord)
    );

    pc #(.INSTRUCNUM(INSTRUCNUM)) pc (
        .clk(clk),
        .nRst(nRst),
        .instrucAddr(instrucAddr)
    );

endmodule

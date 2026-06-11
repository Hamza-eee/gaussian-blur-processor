//-----------------------------------------------------
// File Name   : adderMux.sv
// Function    : Muxes to the adder inputs A and B
// Version     : 2.0
// Author      : Hamza Alhalabi, alhalabihamzawrk@gmail.com
// Date        : 06 Apr 2026
//-----------------------------------------------------
module adderMux #(DWIDTH = 8)(
    //selection signals
    input logic selA,
    input logic [1:0] selB,
    //muxA inputs
    input logic [DWIDTH-1:0] acc_reg,
    input logic [DWIDTH-1:0] waveAddr_reg,
    //muxB inputs
    input logic [DWIDTH-1:0] swImm,
    input logic [5:0] dataImm,
    input logic [DWIDTH-1:0] ps_reg,
    //muxes outputs
    output logic [DWIDTH-1:0] muxA_out,
    output logic [DWIDTH-1:0] muxB_out
);
    always_comb begin : muxA
        if (selA) begin
            muxA_out = waveAddr_reg;
        end else begin
            muxA_out = acc_reg;
        end
    end

    always_comb begin : muxB
        case (selB)
            2'b00 : muxB_out = {{2{dataImm[5]}}, dataImm};
            2'b01 : muxB_out = swImm;
            2'b10 : muxB_out = ps_reg;
            2'b11 : muxB_out = '0;
            default :  muxB_out = '0;
        endcase
    end

endmodule

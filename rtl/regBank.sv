//-----------------------------------------------------
// File Name   : regBank.sv
// Function    : register bank module
// Version     : 2.0
// Author      : Hamza Alhalabi, alhalabihamzawrk@gmail.com
// Date        : 06 Apr 2026
//-----------------------------------------------------
module regBank #(DWIDTH = 8) (
    input logic clk, nRst, psEn, accEn, waveEn,
    input logic [DWIDTH-1 : 0] res_add,
    input logic [DWIDTH-1 : 0] res_mul,
    output logic [DWIDTH-1 : 0] acc_reg,
    output logic [DWIDTH-1 : 0] ps_reg,
    output logic [DWIDTH-1 : 0] waveAddr_reg
);
    always_ff @( posedge clk, negedge nRst) begin : accumulator_reg
        if (~nRst) begin
            acc_reg <= '0;
        end
        else if (accEn) begin
            acc_reg <= res_add;
        end
    end

    always_ff @( posedge clk, negedge nRst) begin : wave_address_reg
        if (~nRst) begin
            waveAddr_reg <= '0;
        end
        else if (waveEn) begin
            waveAddr_reg <= res_add;
        end
    end

    always_ff @( posedge clk, negedge nRst) begin : partial_sum_reg
        if (~nRst) begin
            ps_reg <= '0;
        end
        else if (psEn) begin
            ps_reg <= res_mul;
        end
    end
endmodule

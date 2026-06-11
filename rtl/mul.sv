//-----------------------------------------------------
// File Name   : mul.sv
// Function    : Multiplier module
// Version     : 1.0
// Author      : Hamza Alhalabi, alhalabihamzawrk@gmail.com
// Date        : 06 Apr 2026
//-----------------------------------------------------

module mul #(
    parameter DWIDTH = 8
) ( input logic signed [DWIDTH-1:0] a_mul,
    input logic signed [DWIDTH-1:0] b_mul,
    output logic signed [DWIDTH-1:0] res_mul
);
  logic signed [(2*DWIDTH)-1:0] temp_mul;

  always_comb begin : Multiplier
      temp_mul = a_mul * b_mul;
  end

  assign res_mul = temp_mul[(2*DWIDTH)-2:DWIDTH-1];

endmodule

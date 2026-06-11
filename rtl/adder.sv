//-----------------------------------------------------
// File Name   : adder.sv
// Function    : Adder module
// Version     : 1.0
// Author      : Hamza Alhalabi, alhalabihamzawrk@gmail.com
// Date        : 06 Apr 2026
//-----------------------------------------------------
module adder #(
    parameter DWIDTH = 8
) (
    input logic [DWIDTH-1:0] a_add,
    input logic [DWIDTH-1:0] b_add,
    output logic [DWIDTH-1:0] res_add
);
  always_comb begin : Adder
      res_add = a_add + b_add;
  end

endmodule

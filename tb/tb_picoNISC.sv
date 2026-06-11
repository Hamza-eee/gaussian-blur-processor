//-----------------------------------------------------
// File Name   : tb_picoNISC.sv
// Function    : top level module Testbench
// Version     : 3.0
// Author      : Hamza Alhalabi, alhalabihamzawrk@gmail.com
// Date        : 06 Apr 2026
//-----------------------------------------------------
module tb_picoNISC;

    localparam DWIDTH = 8;

    logic [7:0] golden_ref [0:251] = '{8'h07, 8'h0E, 8'h11, 8'h14, 8'h18, 8'h1D, 8'h23, 8'h25, 8'h28, 8'h2A, 8'h2D, 8'h31, 8'h39, 8'h3E, 8'h3F, 8'h41, 8'h43, 8'h46, 8'h4A, 8'h4B, 8'h4D, 8'h4D, 8'h50, 8'h55, 8'h58, 8'h5A, 8'h59, 8'h57, 8'h57, 8'h58, 8'h59, 8'h58, 8'h56, 8'h54, 8'h53, 8'h52, 8'h4F, 8'h4C, 8'h49, 8'h48, 8'h47, 8'h47, 8'h47, 8'h45, 8'h42, 8'h3E, 8'h3C, 8'h3C, 8'h38, 8'h32, 8'h2D, 8'h2A, 8'h28, 8'h25, 8'h20, 8'h19, 8'h12, 8'h0B, 8'h08, 8'h08, 8'h06, 8'h06, 8'h00, 8'hFA, 8'hF2, 8'hED, 8'hE7, 8'hE3, 8'hE0, 8'hDD, 8'hDB, 8'hD8, 8'hD5, 8'hD1, 8'hCC, 8'hC7, 8'hC4, 8'hC2, 8'hBF, 8'hBD, 8'hBA, 8'hB8, 8'hB6, 8'hB3, 8'hB3, 8'hB0, 8'hB0, 8'hAF, 8'hAF, 8'hAE, 8'hAC, 8'hAA, 8'hA7, 8'hA6, 8'hA7, 8'hAA, 8'hAB, 8'hAC, 8'hAD, 8'hAD, 8'hAD, 8'hB0, 8'hB0, 8'hB2, 8'hB2, 8'hB2, 8'hB1, 8'hB3, 8'hB4, 8'hB7, 8'hBC, 8'hC0, 8'hC5, 8'hCC, 8'hD0, 8'hD4, 8'hDA, 8'hDB, 8'hDD, 8'hE0, 8'hE5, 8'hE9, 8'hEB, 8'hEE, 8'hF4, 8'hF8, 8'hFD, 8'h01, 8'h02, 8'h06, 8'h0B, 8'h12, 8'h19, 8'h1D, 8'h21, 8'h24, 8'h2B, 8'h30, 8'h35, 8'h38, 8'h3B, 8'h3C, 8'h3E, 8'h3E, 8'h43, 8'h47, 8'h4D, 8'h4D, 8'h50, 8'h51, 8'h54, 8'h59, 8'h5C, 8'h5C, 8'h59, 8'h56, 8'h55, 8'h56, 8'h57, 8'h5A, 8'h5B, 8'h58, 8'h58, 8'h57, 8'h56, 8'h50, 8'h50, 8'h4D, 8'h4C, 8'h49, 8'h47, 8'h44, 8'h42, 8'h40, 8'h40, 8'h3D, 8'h3B, 8'h39, 8'h34, 8'h2F, 8'h28, 8'h23, 8'h1D, 8'h1A, 8'h17, 8'h14, 8'h10, 8'h09, 8'h05, 8'h01, 8'hFE, 8'hFB, 8'hF8, 8'hF5, 8'hF2, 8'hEC, 8'hE7, 8'hE0, 8'hD8, 8'hD5, 8'hD1, 8'hCE, 8'hCA, 8'hC5, 8'hC2, 8'hC2, 8'hC1, 8'hBF, 8'hBC, 8'hB7, 8'hB4, 8'hB3, 8'hB1, 8'hAE, 8'hAC, 8'hA9, 8'hA9, 8'hA7, 8'hA8, 8'hA7, 8'hA8, 8'hA3, 8'hA3, 8'hA3, 8'hA6, 8'hA8, 8'hA9, 8'hA9, 8'hA9, 8'hAD, 8'hAF, 8'hB3, 8'hB7, 8'hB7, 8'hB6, 8'hB4, 8'hB3, 8'hB6, 8'hBA, 8'hBF, 8'hC4, 8'hCB, 8'hD0, 8'hD7, 8'hDA, 8'hDC, 8'hDE, 8'hDF, 8'hE1, 8'hE7, 8'hEE, 8'hF2};

    // DUT signals
    logic clk;
    logic [9:0] SW;
    logic [7:0] LED;
    // Test bench variables
    logic [7:0] reference_idx;
    int pass = 0;
    int fail = 0;
    // DUT
    picoNISC # ( .DWIDTH(DWIDTH))
     picoNISC_dut (
        .clk(clk),
        .SW(SW),
        .LED(LED)
     );

    // Clock generation
    initial begin
        clk = 0;
        forever #1ns clk = ~clk; //500MHz
    end

    task automatic run_once ( input logic [7:0] sample_idx);
        // adjusting reference index to be used with the golden_ref array which has 252 samples only
        reference_idx = sample_idx-2;
        #2ns;
        SW[7:0] = sample_idx;
        SW[8]= 1'b0;
        #2ns;
        SW[8]= 1'b1; // start execution
        #32ns; // wait for 16 clock cycles for program to complete
        $display("Result at sample index 0x%h: Expected 0x%h, Got 0x%h",
                sample_idx, golden_ref[reference_idx], LED);

        #10ns; // idle
        //$display("Same result after delay: 0x%h", LED);
        SW[8] = 1'b0;
    endtask

    task automatic run_check ( input logic [7:0] sample_idx);
        // adjusting reference index to be used with the golden_ref array which has 252 samples only
        reference_idx = sample_idx-2;
        #2ns;
        SW[7:0] = sample_idx;
        SW[8]= 1'b0;
        #2ns;
        SW[8]= 1'b1; // start execution
        #32ns; // wait for 16 clock cycles for program to complete

        if (LED != golden_ref[reference_idx]) begin
            $display("Mismatched at sample index 0x%h: Expected 0x%h, Got 0x%h",
                sample_idx, golden_ref[reference_idx], LED);
            fail++;
        end else
            pass++;
        SW[8] = 1'b0;
        #1ns; // idle
    endtask

    initial begin
        $dumpfile("waves.vcd");
        $dumpvars(0, tb_picoNISC);
        //initialisation
        SW = '0;
        #10ns; // wait for 5 cycles
        SW[9]= 1'b1; //end reset
        $display("---------------------------");
        $display("          TB Start         ");
        $display("---------------------------");
        run_once(8'h40);
        run_once(8'h11);

        // Reset before test sweep
        SW[8] = 1'b0;
        SW[9] = 1'b0;
        #4ns;
        SW[9] = 1'b1;
        #4ns;
        // Running test over all samples (except upper and lower 2 edge samples)
        for (int i = 2; i < 254; i++) begin
            run_check(8'(i));
        end
        $display("---------------------------");
        $display("       Test Results        ");
        $display("Passed Tests: %0d / %0d", pass, pass + fail);
        $display("Failed Tests: %0d / %0d", fail, pass + fail);

        $display("---------------------------");
        $display("          TB End           ");
        $display("---------------------------");

        $finish;
    end

endmodule

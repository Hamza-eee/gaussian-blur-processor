onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk -radix hexadecimal /tb_picoNISC/picoNISC_dut/clk
add wave -noupdate -label nRst -radix hexadecimal /tb_picoNISC/picoNISC_dut/nRst
add wave -noupdate -label {SW[9]} -radix binary {/tb_picoNISC/picoNISC_dut/SW[9]}
add wave -noupdate -label {SW[8]} -radix binary {/tb_picoNISC/picoNISC_dut/SW[8]}
add wave -noupdate -label {swImm(SW[7:0])} -radix hexadecimal /tb_picoNISC/picoNISC_dut/swImm
add wave -noupdate -label {LED[7:0]} -radix hexadecimal /tb_picoNISC/picoNISC_dut/LED
add wave -noupdate -divider {Program counter}
add wave -noupdate -label instrucAddr -radix hexadecimal /tb_picoNISC/picoNISC_dut/instrucAddr
add wave -noupdate -divider {Program memory}
add wave -noupdate -label controlWord -radix hexadecimal /tb_picoNISC/picoNISC_dut/controlWord
add wave -noupdate -label op -radix binary /tb_picoNISC/picoNISC_dut/op
add wave -noupdate -label selA -radix binary /tb_picoNISC/picoNISC_dut/selA
add wave -noupdate -label {selB[1:0]} -radix binary /tb_picoNISC/picoNISC_dut/selB
add wave -noupdate -label dataImm -radix hexadecimal /tb_picoNISC/picoNISC_dut/dataImm
add wave -noupdate -divider Adder
add wave -noupdate -label a_add -radix hexadecimal /tb_picoNISC/picoNISC_dut/a_add
add wave -noupdate -label b_add -radix hexadecimal /tb_picoNISC/picoNISC_dut/b_add
add wave -noupdate -label res_add -radix hexadecimal /tb_picoNISC/picoNISC_dut/res_add
add wave -noupdate -label acc_reg -radix hexadecimal /tb_picoNISC/picoNISC_dut/acc_reg
add wave -noupdate -label waveAddr_reg -radix hexadecimal /tb_picoNISC/picoNISC_dut/waveAddr_reg
add wave -noupdate -divider Multiplier
add wave -noupdate -label waveSample(a_mul) -radix hexadecimal /tb_picoNISC/picoNISC_dut/waveSample
add wave -noupdate -label {{{2'b0}, dataImm}(b_mul)} -radix hexadecimal /tb_picoNISC/picoNISC_dut/mul/b_mul
add wave -noupdate -label res_mul -radix hexadecimal /tb_picoNISC/picoNISC_dut/res_mul
add wave -noupdate -label ps_reg -radix hexadecimal /tb_picoNISC/picoNISC_dut/ps_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors
quietly wave cursor active 0
configure wave -namecolwidth 196
configure wave -valuecolwidth 43
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {7312 ps} {61130 ps}

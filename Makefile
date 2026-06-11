# ---- Sources ----
RTL_SRCS :=\
    rtl/progROM.sv\
    rtl/waveROM.sv\
    rtl/pc.sv\
    rtl/regBank.sv\
    rtl/adderMux.sv\
    rtl/mul.sv\
    rtl/adder.sv\
    rtl/picoNISC.sv

TB_SRCS := tb/tb_picoNISC.sv
SRCS    := $(RTL_SRCS) $(TB_SRCS)

# ---- ModelSim ----
VLIB := vlib
VLOG := vlog
VSIM := vsim
WORK := work
TOP  := tb_picoNISC

compile:
	@echo "== Compiling (ModelSim) =="
	$(VLIB) $(WORK)
	$(VLOG) -sv $(SRCS)

run: compile
	@echo "== Running (ModelSim) =="
	$(VSIM) -c $(WORK).$(TOP) -do "run -all; quit"

gui: compile
	@echo "== Running GUI (ModelSim) =="
	$(VSIM) $(WORK).$(TOP) -do "log -r /*; run -all"

# ---- Verilator ----
VERILATOR := verilator
VER_FLAGS := -Wall --timing --trace --top-module $(TOP) --binary -Wno-UNUSEDSIGNAL -Wno-UNDRIVEN
OBJDIR    := obj_dir
BIN       := $(OBJDIR)/V$(TOP)
WAVFILE   ?= waves.vcd

vbuild:
	@echo "== Building (Verilator) =="
	$(VERILATOR) $(VER_FLAGS) $(SRCS)

vsim: vbuild
	@echo "== Running (Verilator) =="
	./$(BIN)

vwave: vsim
	@if [ ! -f $(WAVFILE) ]; then \
		echo "Error: '$(WAVFILE)' not found."; \
		exit 1; \
	fi
	@echo "== Opening GTKWave =="
	gtkwave $(WAVFILE) &

# ---- Clean ----
clean:
	@echo "== Cleaning =="
	rm -rf $(WORK) $(OBJDIR) transcript vsim.wlf $(WAVFILE)

.PHONY: compile run gui vbuild vsim vwave clean
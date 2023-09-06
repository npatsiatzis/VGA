TOPLEVEL = top_vga_sdl
MODULE = tb_vga_sdl.cpp
RTL_DIR = ./../rtl/SystemVerilog/

# RTL_SOURCES += $(PWD)/../rtl/SystemVerilog/image_generator.vhd
RTL_SOURCES += $(PWD)/../rtl/SystemVerilog/display_timings.sv
RTL_SOURCES += $(PWD)/../rtl/SystemVerilog/top_vga_sdl.sv

VFLAGS = --assert --build -j --coverage --trace --trace-coverage -Wall --trace -O3 --x-assign fast --x-initial fast 
SDL_CFLAGS = `sdl2-config --cflags`
SDL_LDFLAGS = `sdl2-config --libs`



GENHTML = /usr/bin/genhtml
# If $VERILATOR_ROOT isn't in the environment, we assume it is part of a
# package install, and verilator is in your path. Otherwise find the
# binary relative to $VERILATOR_ROOT (such as when inside the git sources).
ifeq ($(VERILATOR_ROOT),)
VERILATOR = verilator
VERILATOR_COVERAGE = verilator_coverage
else
export VERILATOR_ROOT
VERILATOR = $(VERILATOR_ROOT)/bin/verilator
VERILATOR_COVERAGE = $(VERILATOR_ROOT)/bin/verilator_coverage
endif	

.PHONY:coverage
coverage: top_vga_sdl
	@echo "### Getting Line Coverage information ###"
	@$(VERILATOR_COVERAGE) --annotate logs/annotated --annotate-min 1 -write-info logs/merged.info logs/coverage.dat


top_vga_sdl: top_vga_sdl.exe
top_vga_sdl.exe: .stamp.verilate
# 	make -C ./obj_dir -f V$<
	make -C obj_dir -f V$(TOPLEVEL).mk V$(TOPLEVEL)
	./obj_dir/Vtop_vga_sdl

.stamp.verilate: 
	verilator ${VFLAGS} --I$(RTL_DIR) \
		-cc $(RTL_DIR)/$(TOPLEVEL).sv --exe $(MODULE) \
		-CFLAGS "${SDL_CFLAGS}" -LDFLAGS "${SDL_LDFLAGS}"
	@touch .stamp.verilate

.PHONY:html_coverage
html_coverage: coverage
	@echo ""
	@echo "### Generating html Coverage analysis ###"
	@$(GENHTML) logs/merged.info --output-directory html

.PHONY:lint
lint:
	@$(VERILATOR) --lint-only $(RTL_DIR)/*.sv
	@verible-verilog-lint $(RTL_DIR)/*.sv

.PHONY: clean
clean:
	rm -rf .stamp.*;
	rm -rf ./obj_dir
	rm -rf waveform.vcd
	rm -rf logs
	rm -rf html
	rm -rf coverage.dat

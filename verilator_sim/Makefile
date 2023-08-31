TOPLEVEL = top_vga_sdl
MODULE = tb_vga_sdl.cpp
RTL_DIR = $(PWD)/../rtl/SystemVerilog/

# RTL_SOURCES += $(PWD)/../rtl/SystemVerilog/image_generator.vhd
RTL_SOURCES += $(PWD)/../rtl/SystemVerilog/display_timings.sv
RTL_SOURCES += $(PWD)/../rtl/SystemVerilog/top_vga_sdl.sv

VFLAGS = --assert --build -j --coverage --trace --trace-coverage -Wall --trace -O3 --x-assign fast --x-initial fast 
SDL_CFLAGS = `sdl2-config --cflags`
SDL_LDFLAGS = `sdl2-config --libs`



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

.PHONY:line_coverage
line_coverage: top_vga_sdl
	@echo "### Getting Line Coverage information ###"
	@verilator_coverage --annotate logs/annotated --annotate-min 1 -write-info logs/merged.info --write logs/merged.vcov logs/coverage.dat

.PHONY:html_coverage
html_coverage: line_coverage
	@echo ""
	@echo "### Generating html Coverage analysis ###"
	@genhtml logs/merged.info --output-directory html	

.PHONY:lint
lint: $(RTL_DIR)/$(TOPLEVEL).sv
	@verilator --lint-only $(RTL_DIR)/$(TOPLEVEL).sv
	@verible-verilog-lint $(RTL_DIR)/$(TOPLEVEL).sv

.PHONY: clean
clean:
	rm -rf .stamp.*;
	rm -rf ./obj_dir
	rm -rf waveform.vcd
	rm -rf annotated
	rm -rf html
	rm -rf coverage.dat

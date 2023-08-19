TOPLEVEL = top_vga_sdl
MODULE = tb_vga_sdl.cpp
RTL_DIR = $(PWD)/../rtl/SystemVerilog/

# RTL_SOURCES += $(PWD)/../rtl/SystemVerilog/image_generator.vhd
RTL_SOURCES += $(PWD)/../rtl/SystemVerilog/display_timings.sv
RTL_SOURCES += $(PWD)/../rtl/SystemVerilog/top_vga_sdl.sv

VFLAGS = -O3 --x-assign fast --x-initial fast --noassert
SDL_CFLAGS = `sdl2-config --cflags`
SDL_LDFLAGS = `sdl2-config --libs`



top_vga_sdl: top_vga_sdl.exe
top_vga_sdl.exe: .stamp.verilate
# 	make -C ./obj_dir -f V$<
	make -C obj_dir -f V$(TOPLEVEL).mk V$(TOPLEVEL)

.stamp.verilate: 
	verilator ${VFLAGS} --I$(RTL_DIR) \
		-cc $(RTL_DIR)/$(TOPLEVEL).sv --exe $(MODULE) \
		-CFLAGS "${SDL_CFLAGS}" -LDFLAGS "${SDL_LDFLAGS}"
	@touch .stamp.verilate

.PHONY:lint
lint: 
	@verilator --lint-only $(RTL_DIR)/*.sv 
	@verible-verilog-lint $(RTL_DIR)/*.sv

.PHONY: clean
clean:
	rm -rf .stamp.*;
	rm -rf ./obj_dir
	rm -rf waveform.vcd

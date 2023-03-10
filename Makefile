# Makefile

# defaults
SIM ?= ghdl
TOPLEVEL_LANG ?= vhdl
EXTRA_ARGS += --std=08
SIM_ARGS += --wave=wave.ghw

VHDL_SOURCES += $(PWD)/image_generator.vhd
VHDL_SOURCES += $(PWD)/display_timings.vhd
VHDL_SOURCES += $(PWD)/vga.vhd
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
# MODULE is the basename of the Python test file

test:
		rm -rf sim_build
		$(MAKE) sim MODULE=testbench TOPLEVEL=vga

formal :
		sby --yosys "yosys -m ghdl" -f display_timings.sby

formal_sva :
		sby --yosys "yosys -m ghdl" -f display_timings_sva.sby
# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
![example workflow](https://github.com/npatsiatzis/vga/actions/workflows/regression.yml/badge.svg)
# VGA RTL implementation

- design consists of VGA timing generator, image generator and VGA top
- parameterizable timing generator, default values correspond to VGA 640 x 480 @ 60 Hz Industry standard timing
- image generator generates a standard test frame

-- RTL code in:
- [VHDL](https://github.com/npatsiatzis/fifo_asynchronous/tree/main/rtl/VHDL)

-- Functional verification with methodologies:
- [cocotb](https://github.com/npatsiatzis/fifo_asynchronous/tree/main/cocotb_sim)

- CoCoTB testbench for functional verification. Saves the horizontal/vertical sync information and the RGB values for every simulation time step in a specific format to use Eric Eastwood's "VGA simulator" tool to render the VGA image.
- The VGA Simulator (https://www.ericeastwood.com/lab/vga-simulator/) is a tool to view a raw VGA signal w/o having to plug it to a CRT monitor.


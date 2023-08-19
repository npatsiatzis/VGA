![example workflow](https://github.com/npatsiatzis/vga/actions/workflows/regression.yml/badge.svg)
![example workflow](https://github.com/npatsiatzis/vga/actions/workflows/formal.yml/badge.svg)

# VGA RTL implementation

- design consists of VGA timing generator, image generator and VGA top
- parameterizable timing generator, default values correspond to VGA 640 x 480 @ 60 Hz Industry standard timing
- image generator generates a standard test frame

-- RTL code in:
- [VHDL](https://github.com/npatsiatzis/vga/tree/main/rtl/VHDL)
- [SystemVerilog](https://github.com/npatsiatzis/vga/tree/main/rtl/SystemVerilog)

-- Functional verification with methodologies:
- [cocotb](https://github.com/npatsiatzis/vga/tree/main/cocotb_sim)
- [pyuvm](https://github.com/npatsiatzis/vga/tree/main/formal)

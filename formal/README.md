![example workflow](https://github.com/npatsiatzis/vga/actions/workflows/formal.yml/badge.svg)

# VGA RTL implementation

- design consists of VGA timing generator, image generator and VGA top
- parameterizable timing generator, default values correspond to VGA 640 x 480 @ 60 Hz Industry standard timing
- image generator generates a standard test frame

-- RTL code in:
- [VHDL](https://github.com/npatsiatzis/fifo_asynchronous/tree/main/rtl/VHDL)

-- Functional verification with methodologies:
- [formal](https://github.com/npatsiatzis/fifo_asynchronous/tree/main/formal)

- formal verification of the display_timings module using SymbiYosys (sby), (properties specified in PSL)
    - $ make formal

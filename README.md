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
- [verilator](https://github.com/npatsiatzis/vga/tree/main/verilator_sim)


### Repo Structure

This is a short tabular description of the contents of each folder in the repo.

| Folder | Description |
| ------ | ------ |
| [rtl/SystemVerilog](https://github.com/npatsiatzis/vga/tree/main/rtl/SystemVerilog) | SV RTL implementation files |
| [rtl/VHDL](https://github.com/npatsiatzis/vga/tree/main/rtl/VHDL) | VHDL RTL implementation files |
| [cocotb_sim](https://github.com/npatsiatzis/vga/tree/main/cocotb_sim) | Functional Verification with CoCoTB (Python-based) |
| [verilator_sim](https://github.com/npatsiatzis/vga/tree/main/verilator_sim) | Functional Verification with Verilator (C++ based) |
| [formal](https://github.com/npatsiatzis/vga/tree/main/formal) | Formal Verification using  PSL properties and [YoysHQ/sby](https://github.com/YosysHQ/oss-cad-suite-build) |


This is <!-- the tree view of the strcture of the repo.
<pre>
<font size = "2">
.
├── <font size = "4"><b><a href="https://github.com/npatsiatzis/vga/tree/main/rtl">rtl</a></b> </font>
│   ├── <font size = "4"><a href="https://github.com/npatsiatzis/vga/tree/main/rtl/SystemVerilog">SystemVerilog</a> </font>
│   │   └── SV files
│   └── <font size = "4"><a href="https://github.com/npatsiatzis/vga/tree/main/rtl/VHDL">VHDL</a> </font>
│       └── VHD files
├── <font size = "4"><b><a href="https://github.com/npatsiatzis/vga/tree/main/cocotb_sim">cocotb_sim</a></b></font>
│   ├── Makefile
│   └── python files
├── <font size = "4"><b><a href="https://github.com/npatsiatzis/vga/tree/main/verilator_sim">verilator_sim</a></b></font>
│   ├── Makefile
│   └── verilator tb
└── <font size = "4"><b><a href="https://github.com/npatsiatzis/vga/tree/main/formal">formal</a></b></font>
    ├── Makefile
    └── PSL properties file, scripts
</pre> -->
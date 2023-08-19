# VGA RTL implementation

- design consists of VGA timing generator, and a top vga sdl module that creates the picture of a square
- parameterizable timing generator, default values correspond to VGA 640 x 480 @ 60 Hz Industry standard timing
- to try a different resolution, just change all the relevant parameter default values on top_vga_sdl.sv
- the verilator tb with support for sdl was adapted from https://projectf.io/posts/verilog-sim-verilator-sdl/

-- Run : 
- make
- ./obj_dir/Vtop_vga_sdl 


from cocotb_test.simulator import run
import pytest
import os

vhdl_compile_args = "--std=08"
sim_args = "--wave=wave.ghw"


tests_dir = os.path.abspath(os.path.dirname(__file__)) #gives the path to the test(current) directory in which this test.py file is placed
rtl_dir = tests_dir                                    #path to hdl folder where .vhdd files are placed

module = "testbench"
toplevel = "vga"   
vhdl_sources = [
    os.path.join(rtl_dir, "display_timings.vhd"),
    os.path.join(rtl_dir, "image_generator.vhd"),
    os.path.join(rtl_dir, "vga.vhd"),
    ]
                             
def test():

    run(
        python_search=[tests_dir],                      
        vhdl_sources=vhdl_sources,
        toplevel=toplevel,
        module=module,

        vhdl_compile_args=[vhdl_compile_args],
   		toplevel_lang="vhdl",
    )

    if __name__ == "__main__":
    	test(parameter)
# Functional test for the VGA module
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.utils import get_sim_time
import os


@cocotb.test()
async def test(dut):
	"""Check the functional correctness of the VGA module
	pixel clock, this has to be according to the requirements for the image to
	to be properly rendered."""

	#here we are following along the default example of 640x480 @60 Hz, thus we use
	#a 25 MHz clock. Consult : http://tinyvga.com/vga-timing
	cocotb.start_soon(Clock(dut.i_clk, (1/(25*10**6)), units="sec").start())	

	filename = 'vga_items.txt'
	if os.path.exists(filename):
	    os.remove(filename)
	f = open(filename,'x')
	while(get_sim_time('ns') < 10**10):
		await RisingEdge(dut.i_clk)
		sim_time = int(get_sim_time('ns'))
		with open(filename,'a') as f:
			print("{} ns: {} {} {} {} {}".format(sim_time,dut.o_hsync, dut.o_vsync, dut.o_r, dut.o_g , dut.o_b),file=f)
		


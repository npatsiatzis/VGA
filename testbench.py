# Functional test for uart module
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer,RisingEdge,FallingEdge,ClockCycles,ReadWrite

from cocotb.utils import get_sim_time
from cocotb.result import TestFailure
import random
from cocotb_coverage.coverage import CoverCross,CoverPoint,coverage_db



@cocotb.test()
async def test(dut):
	"""Check results and coverage for UART"""

	cocotb.start_soon(Clock(dut.i_clk, (1/(25*10**6)), units="sec").start())	#pixel clock

	while(get_sim_time('ns') < 10**10):
		await RisingEdge(dut.i_clk)
		sim_time = int(get_sim_time('ns'))
		with open('vga_items.txt','a') as f:
			print("{} ns: {} {} {} {} {}".format(sim_time,dut.o_hsync, dut.o_vsync, dut.o_r, dut.o_g , dut.o_b),file=f)
		



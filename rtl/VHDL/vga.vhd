library ieee;
use ieee.std_logic_1164.all;

entity vga is
	generic(
		--default for 640x480 @60Hz
		g_h_res : natural :=640;						
		g_v_res : natural :=480;
		g_h_fp  : natural :=16;
		g_h_sync : natural :=96;
		g_h_bp : natural :=48;
		g_v_fp : natural :=10;
		g_v_sync : natural :=2;
		g_v_bp : natural :=33);
	port(
		i_clk : in std_ulogic;							--pixel clock				
		i_rst : in std_ulogic;		
		o_h_sync : out std_ulogic;						--horizontal sync
		o_v_sync : out std_ulogic;						--vertical sync
        o_r : out std_ulogic_vector(2 downto 0);
        o_g : out std_ulogic_vector(2 downto 0);
        o_b : out std_ulogic_vector(1 downto 0);
        o_active : out std_ulogic);
end vga;

architecture top of vga is 
	signal w_x : std_ulogic_vector(9 downto 0);
	signal w_y : std_ulogic_vector(9 downto 0);
	signal w_active : std_ulogic;

begin
	display_timings : entity work.display_timings(rtl)
	generic map (
		g_h_res => g_h_res,						
		g_v_res => g_v_res,
		g_h_fp  => g_h_fp,
		g_h_sync => g_h_sync,
		g_h_bp => g_h_bp,
		g_v_fp => g_v_fp,
		g_v_sync => g_v_sync,
		g_v_bp => g_v_bp)
	port map(
		i_clk => i_clk,		
		i_rst => i_rst,									
		o_h_sync => o_h_sync,
		o_v_sync  => o_v_sync,
		o_x => w_x,
		o_y => w_y,
		o_active => w_active);

	image_generator : entity work.image_generator(rtl)
	port map(
		i_clk  => i_clk,
		i_active => w_active,
        o_r => o_r,
        o_g => o_g,
        o_b => o_b);
end top;
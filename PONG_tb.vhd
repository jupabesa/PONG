LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------
ENTITY PONG_tb IS
END ENTITY PONG_tb;
-------------------------------------
ARCHITECTURE testbench OF PONG_tb IS
 	SIGNAL	clk_tB				:	STD_LOGIC := '0';
	SIGNAL   VGAHS_tb       : STD_LOGIC;
   SIGNAL   VGAVS_tb       : STD_LOGIC;
   SIGNAL   VGAR_tb          : STD_LOGIC_VECTOR(3 DOWNTO 0);   
	SIGNAL   VGAB_tb          : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL   VGAG_tb          : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL   BOTON_tb       : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL   SWITCH_tb         : STD_LOGIC;
	SIGNAL   SSEG1_tb         :STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL   SSEG2_tb         :STD_LOGIC_VECTOR(6 DOWNTO 0);
	
	
BEGIN
	--CLOCK GENERATION:------------------------
	   clk_tb <= not clk_tb after 10 ns; -- 50MHz clock generation
	--RESET GENERATION:------------------------
	   boton_tb(2) <= '1' after 20 ns;
	
	DUT:	ENTITY work.PONG
	PORT MAP(	CLK		=>	CLK_tb,
               VGA_HS  => VGAHS_tb,
					VGA_VS  => VGAVS_tb,
					VGA_R    => VGAR_tb,
					VGA_B   =>  VGAB_tb,
					VGA_G  =>   VGAG_tb,
					BOTON  => BOTON_tb,
					SWITCH  => SWITCH_tb,
					SSEG1  =>  SSEG1_tb,
					SSEG2  => SSEG2_tb
			  );
	
	--Input signal generation
	signal_generation: PROCESS
	BEGIN


	  WAIT FOR 40 ns;

	END PROCESS signal_generation;

END ARCHITECTURE testbench;
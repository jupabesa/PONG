LIBRARY IEEE; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_arith.all;

ENTITY MOVBOLA IS 
GENERIC ( VELBOLAH : INTEGER := 3;
          VELBOLAV : INTEGER := 3);
PORT (
	CLK : IN STD_LOGIC;
	RST : IN STD_LOGIC;
	NEW_FRAME : IN STD_LOGIC;
	RED: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	GREEN: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	BOLA_ARRIBA : OUT STD_LOGIC; 
	BOLADER : OUT STD_LOGIC; 
	PUNTAJEDER : OUT INTEGER;
	PUNTAJEIZQ : OUT INTEGER;
   PBOLAH    :  OUT  INTEGER;
	PBOLAV    : OUT  INTEGER
);
END ENTITY MOVBOLA;


ARCHITECTURE RTL OF MOVBOLA IS

SIGNAL BOLAARR : STD_LOGIC;
SIGNAL BOLAADER : STD_LOGIC;
SIGNAL POSBOLAV :INTEGER;
SIGNAL POSBOLAH :INTEGER;
SIGNAL PUNTAJE_DER : INTEGER;
SIGNAL PUNTAJE_IZQ : INTEGER;
SIGNAL VBOLAV  : INTEGER;
SIGNAL VBOLAH  : INTEGER;

BEGIN 

 BOLA_ARRIBA <= BOLAARR;
 BOLADER <= BOLAADER;
 PBOLAH <= POSBOLAH;
 PBOLAV <= POSBOLAV;
 PUNTAJEDER <= PUNTAJE_DER;
 PUNTAJEIZQ <= PUNTAJE_IZQ;
 
move_ball : process (CLK) 
begin
 
	if (rising_edge(CLK) and new_frame = '1') then
	
		if (RST = '1') then
			PUNTAJE_IZQ <= 0;
			PUNTAJE_DER <= 0;
			POSBOLAV <= 515;
			POSBOLAH <= 1500;
         VBOLAH <= VELBOLAH;
			VBOLAV <= VELBOLAV;
			
		else

			if (POSBOLAV < 1062 and BOLAARR = '1') then
				POSBOLAV <= POSBOLAV + VBOLAV;
			elsif (BOLAARR = '1') then
				BOLAARR <= '0';
			elsif (POSBOLAV >47 and BOLAARR = '0') then
				POSBOLAV <= POSBOLAV - VBOLAV;
			elsif (BOLAARR = '0') then
				BOLAARR <= '1';
			end if;
			
	
			if (POSBOLAH < 2231 and BOLAADER = '1') then
				POSBOLAH <= POSBOLAH + VBOLAH;
			elsif (BOLAADER = '1') then
				BOLAADER	<= '0';	
				if (PUNTAJE_IZQ  < 9) then
					PUNTAJE_IZQ <= PUNTAJE_IZQ + 1;
					POSBOLAV <= 515;
					POSBOLAH <= 1500;
				else	
					VBOLAH 			<= 0;
					VBOLAV			<= 0;
				end if;
				
			elsif (POSBOLAH >586 and BOLAADER = '0') then
				POSBOLAH <= POSBOLAH - VBOLAH;

			elsif (BOLAADER = '0') then
				BOLAADER <= '1';
				
				if (PUNTAJE_DER  < 9) then
					PUNTAJE_DER <= PUNTAJE_DER + 1;
					POSBOLAV <= 515;
					POSBOLAH <= 1500;
				else	

					VBOLAH 			<= 0;
					VBOLAV			<= 0;
				end if;
			end if;
		end if;
	

	elsif rising_edge(CLK) then
		if (GREEN = "1111" and RED = "1111") then
			BOLAADER <= BOLAADER XOR '1'; 
		end if;
			
	end if;
		 
end process;

END ARCHITECTURE;
LIBRARY IEEE; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_arith.all;

ENTITY DIBUJAR_BOLA IS 
PORT (
	CLK : IN STD_LOGIC;
	RED: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	HPOS      : IN  INTEGER;
	VPOS      : IN  INTEGER;
   PBOLAH    : IN  INTEGER;
	PBOLAV    : IN  INTEGER
);
END ENTITY DIBUJAR_BOLA;


ARCHITECTURE RTL OF DIBUJAR_BOLA IS


BEGIN 

 
DIBUJAR_BOLA : process (CLK) 
begin
 
	if (rising_edge(CLK)) then
		
		if ( (hpos >= PBOLAH and hpos < PBOLAH + 15) and (vpos >= PBOLAV and vpos < PBOLAV + 15) ) then
			RED <= "1111";
		else
			RED <= "0000";
		end if;
		
	end if;
		 
end process;
		 
END ARCHITECTURE;
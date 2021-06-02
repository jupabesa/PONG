LIBRARY IEEE; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_arith.all;

ENTITY DIBUJAR_RAQUETA IS 
PORT (
	CLK : IN STD_LOGIC;
	GREEN : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	HPOS      : IN  INTEGER;
	VPOS      : IN  INTEGER;
	RAQUETA1V : IN INTEGER;
	RAQUETA2V  : IN INTEGER;
	RAQUETA1H : IN INTEGER;
	RAQUETA2H  :IN INTEGER
);
END ENTITY DIBUJAR_RAQUETA;


ARCHITECTURE RTL OF DIBUJAR_RAQUETA IS

SIGNAL R2V : INTEGER;
SIGNAL R1V : INTEGER;
SIGNAL R1H : INTEGER;
SIGNAL R2H : INTEGER;

BEGIN 

 
DIBUJAR_RAQUETA : process (CLK) 
begin
 
	if (rising_edge(CLK)) then
	
		if ( (hpos >= RAQUETA1H and hpos < RAQUETA1H + 15) and (vpos >= RAQUETA1V and vpos < RAQUETA1V + 80) ) then
			GREEN <= "1111";
		elsif ( (hpos >= RAQUETA2H and hpos < RAQUETA2H + 15) and (vpos >= RAQUETA2V and vpos < RAQUETA2V + 80) ) then
			GREEN <= "1111";
		else
			GREEN <= "0000";
		end if;
		
	end if;
		 
end process;
		 
END ARCHITECTURE;
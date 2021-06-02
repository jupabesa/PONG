LIBRARY IEEE; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_arith.all;

ENTITY MOVRAQUETA IS 
GENERIC ( VELRAQUETA : INTEGER := 5);
PORT (
	CLK : IN STD_LOGIC;
   BOTON1 : IN STD_LOGIC;
	BOTON2 : IN STD_LOGIC;
	SWITCH : IN STD_LOGIC;
	NEW_FRAME : IN STD_LOGIC;
	RAQUETA1V : OUT INTEGER;
	RAQUETA2V  :OUT INTEGER
);
END ENTITY MOVRAQUETA;


ARCHITECTURE RTL OF MOVRAQUETA IS

SIGNAL R2V : INTEGER;
SIGNAL R1V : INTEGER;
BEGIN 
 RAQUETA2V <= R2V;
 RAQUETA1V <= R1V;
Movimiento_Raqueta : PROCESS (CLK) 
begin
 
	if (rising_edge(CLK) and NEW_FRAME = '1') then
		
		if (BOTON1 = '0') then  
			if (R2V < 997) then
				R2V <= R2V + VELRAQUETA;
			else
				R2V <= R2V;		
			end if;
		elsif ( BOTON2 = '0') then 
			if (R2V > 47) then
				R2V <= R2V - VELRAQUETA;
			else
				R2V <= R2V;	
			end if;
		end if;
		
		if (SWITCH = '0') then
			if (R1V < 997) then
				R1V <= R1V + VELRAQUETA;
			else
				R1V <= R1V;
			end if;
		elsif (SWITCH = '1') then
			if (R1V > 47) then
				R1V <= R1V - VELRAQUETA;
			else
				R1V <= R1V;
			end if;
		end if;
			
	end if;
		 
end process;
END ARCHITECTURE;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY SSEG_DISPLAY IS
      PORT (
	NUMERO   : IN INTEGER range 0 to 9;
	NUMERO_OUT : OUT STD_LOGIC_VECTOR(6 downto 0)
  
);
 
END ENTITY SSEG_DISPLAY;
 
ARCHITECTURE RTL of SSEG_DISPLAY is

begin

SAlIDA_SSEG : process(NUMERO)
begin

	case NUMERO is
	 when 0 =>
		NUMERO_OUT <= "1000000";
	 when 1 =>
		NUMERO_OUT <= "1111001";
	 when 2 =>
		NUMERO_OUT <= "0100100";
	 when 3 =>
		NUMERO_OUT <= "0110000";
	 when 4 =>
		NUMERO_OUT <= "0011001";
	 when 5 =>
		NUMERO_OUT <= "0010010";
	 when 6 =>
		NUMERO_OUT <= "0000010";
	 when 7 =>
		NUMERO_OUT <= "1111000";
	 when 8 =>
		NUMERO_OUT <= "0000000";
	 when 9 =>
		NUMERO_OUT <= "0010000";
	 when others =>
		NUMERO_OUT <= "0000000"; 
	end case; 
	
end process;

end ARCHITECTURE ;
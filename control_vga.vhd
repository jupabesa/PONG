LIBRARY IEEE; 
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity control_vga is port (
	reloj	 : in std_logic;
	rojo	 : in std_logic_vector(3 downto 0);
	verde  : in std_logic_vector(3 downto 0);
	azul	 : in std_logic_vector(3 downto 0);
	cont_h : in STD_logic_vector(12 downto 0);
	cont_v : in STD_logic_vector(12 downto 0);
	
	h_flag   : out std_logic;
	v_flag   : out std_logic;
	sync_h   : out std_logic;
	sync_v   : out STD_logic;
	
	hsync 	: out std_logic;
	vsync 	: out std_logic;
	r			: out std_logic_vector(3 downto 0);
	g			: out std_logic_vector(3 downto 0);
	b			: out std_logic_vector(3 downto 0);
	actualizar: out std_logic;
	act_h   : out INTEGER range 0 to 2256;
	act_v   : out INTEGER range 0 to 2256
	
);
 
end entity;
 
architecture structure of control_vga is

signal position_x : UNSIGNED(12 downto 0);   
signal position_y : UNSIGNED(12 downto 0);	

 
begin

position_x<=UNSIGNED(cont_h);
position_y<=UNSIGNED(cont_v);

act_h <= to_integer(position_x);
act_v <= to_integer(position_y);
 
vga_tiempo : process(reloj)

begin
	if rising_edge(reloj) then -- Este reloj es el del PLL 
	h_flag<='0';
	v_flag<='0';
	sync_h<='0';
	sync_v<='0';
	if (position_x < 2256) then
			actualizar <= '0';
			h_flag<='1';

		else
			sync_h<='1';-- Reinicia el conteo porque ya hizo el conteo las columnas de toda una fila
			if (position_y < 1087) then
				v_flag<='1';-- Aunmenta a la siguiente fila 
			else 
				sync_v<='1';  --Reincia el conteo
				actualizar <= '1';
			end if;
		end if;
		--Sincronización
		if (position_x > 0 and position_x < 288) then
			hsync <= '0';
		else
			hsync <= '1';
		end if;
		
		if (position_y > 0 and position_y < 4) then
			vsync <= '0';
		else
			vsync <= '1';
		end if;
-----------------------------------------Cambio de colores-------------------------------------------------------
		
		if ((position_x >= 0 and position_x < 576) or (position_y >= 0 and position_y < 37) ) then
				r <= "0000";
				g <= "0000";
				b <= "0000";
		--Color para los Bordes
		elsif((position_x >= 576 and position_x < 586 ) or (position_y >= 37 and position_y < 47 ) or (position_x >= 2246 and position_x < 2256 ) or (position_y >= 1077 and position_y < 1087 ) ) then
					r <= "1111";
					g <= "1111";
					b <= "0000";
			else
					r <= rojo;
					g <= verde;
					b <= azul;
			end if;
	
	end if;
	
end process;
 
end structure;
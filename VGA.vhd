LIBRARY 	IEEE;--Llamado de la libreria
USE ieee.std_logic_1164.all;--USO de la libreria, Sirve para usar los STD_LOGIC
USE ieee.numeric_std.all;

ENTITY VGA IS
GENERIC (N    : INTEGER :=13
			);
PORT(
	reloj     : in std_logic;	
	reset     : in std_LOGIC;
	reloj_pll	 : in std_logic;
	rojo	 : in std_logic_vector(3 downto 0);
	verde  : in std_logic_vector(3 downto 0);
	azul	 : in std_logic_vector(3 downto 0);
	hsync 	: out std_logic;
	vsync 	: out std_logic;
	
	r			: out std_logic_vector(3 downto 0);
	g			: out std_logic_vector(3 downto 0);
	b			: out std_logic_vector(3 downto 0);
	actualizar: out std_logic;
	act_h   : out INTEGER range 0 to 2256;
	act_v   : out INTEGER range 0 to 2256
);
END ENTITY;
------------------------------------------

ARCHITECTURE structural OF VGA IS


SIGNAL enable1      : STD_LOGIC;
SIGNAL enable2      : STD_LOGIC;
SIGNAL sync1      : STD_LOGIC;
SIGNAL sync2      : STD_LOGIC;
SIGNAL cont1      : STD_LOGIC_vector(N-1 downto 0);
SIGNAL cont2      : STD_LOGIC_vector(N-1 downto 0);


BEGIN 
	
	controlMmodule_0: ENTITY work.control_vga
	PORT MAP(
	reloj=>reloj_pll,
	rojo=>rojo,	
	verde=>verde,	
	azul=>azul,	
	cont_h=> cont1,
	cont_v=> cont2,
	h_flag=> enable1,
	v_flag =>enable2,
	sync_h =>  sync1,
	sync_v =>  sync2,
	hsync=>hsync,
	vsync=>vsync,
	r=>r,		
	g=>g,		
	b=>b,	
	actualizar=>actualizar,
	act_h=>act_h,  
	act_v=>act_v 
	);
	
	counterMmodule_0: ENTITY work.counter_h
	PORT MAP(
				   clk=>reloj,
		         rst=>reset,
					ena=>enable1,
		         syn_clr=>sync1,
					counter=>cont1
	
	);
	counter2Mmodule_0: ENTITY work.counter_h
	PORT MAP(
				   clk=>reloj,
		         rst=>reset,
					ena=>enable2,
		         syn_clr=>sync2,
					counter=>cont2
	);

END ARCHITECTURE structural;
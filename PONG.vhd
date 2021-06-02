LIBRARY IEEE; 
USE ieee.STD_LOGIC_1164.all; 
USE ieee.STD_LOGIC_arith.all;
USE ieee.numeric_STD.all;

ENTITY PONG IS 
PORT (
	CLK : IN STD_LOGIC;
	VGA_HS : OUT STD_LOGIC;
	VGA_VS	: OUT STD_LOGIC;
	VGA_R  : OUT STD_LOGIC_VECTOR(3 downto 0);
	VGA_G  : OUT STD_LOGIC_VECTOR(3 downto 0);
	VGA_B  : OUT STD_LOGIC_VECTOR(3 downto 0);
	SWITCH     : IN STD_LOGIC; 
	SSEG1 : OUT STD_LOGIC_VECTOR(6 downto 0);
	SSEG2 : OUT STD_LOGIC_VECTOR(6 downto 0);
	BOTON : IN STD_LOGIC_VECTOR(2 downto 0)
	
);
END ENTITY PONG;


ARCHITECTURE RTL OF PONG IS
SIGNAL CLKVGA : STD_LOGIC:='0'; 
SIGNAL RST : STD_LOGIC:='0'; 
SIGNAL NEW_FRAME : STD_LOGIC:='0';
SIGNAL RED, GREEN, BLUE : STD_LOGIC_VECTOR(3 downto 0):= (others => '0');
SIGNAL POSH : INTEGER range 0 to 2256:=0;
SIGNAL POSV : INTEGER range 0 to 1087:=0;
SIGNAL RAQUETA1H : INTEGER range 586 to 2246:= 620;
SIGNAL RAQUETA1V : INTEGER range 47 to 1077:= 515;
SIGNAL RAQUETA2H : INTEGER range 586 to 2246:= 2197;
SIGNAL RAQUETA2V : INTEGER range 47 to 1077:= 512;
SIGNAL PBOLAH      : INTEGER range 586 to 2246:= 1500;
SIGNAL PBOLAV      : INTEGER range 47 to 1077:= 515;
SIGNAL BOLAARR	  	: STD_LOGIC:= '0';
SIGNAL BOLADER	:  STD_LOGIC:= '1';
SIGNAL VELBOLAH 	: INTEGER range 0 to 15:= 3;
SIGNAL VELBOLAV	: INTEGER range 0 to 15:= 3;
SIGNAL PUNTAJEDER : INTEGER range 0 to 9:= 0;
SIGNAL PUNTAJEIZQ  : INTEGER range 0 to 9:= 0;

begIN

	RST <= not BOTON(2);

VGA : ENTITY work.VGA
	PORT MAP (
		reloj	 => CLK,
		reloj_pll => CLKVGA,
		reset  => RST,
      r    => VGA_R,
		g   => VGA_G,
		b => VGA_B,
		rojo => RED,
		verde => GREEN,
		azul => BLUE,
      actualizar => NEW_FRAME,
		hsync   => VGA_HS,
		vsync   => VGA_VS,
		act_h   => POSH,
		act_v  => POSV
 );

Movimiento_Raquetas: ENTITY work.MOVRAQUETA
	PORT MAP(
	  clk   => CLKVGA,
	  BOTON1 => BOTON(0),
	  BOTON2 => BOTON(1),
	  SWITCH => SWITCH,
	  NEW_FRAME => NEW_FRAME,
	  RAQUETA1V => RAQUETA1V,
	  RAQUETA2V => RAQUETA2V	
	);
Dibujar_Raquetas: ENTITY work.DIBUJAR_RAQUETA
	PORT MAP(
	  clk   => CLKVGA,
	  RAQUETA1V => RAQUETA1V,
	  RAQUETA2V => RAQUETA2V,	
	  RAQUETA1H => RAQUETA1H,
	  RAQUETA2H => RAQUETA2H,	  
	  HPOS  => POSH,
     VPOS  => POSV,
	  GREEN => GREEN
	);
Dibujar_Bola: ENTITY work.DIBUJAR_BOLA
	PORT MAP(
	  clk   => CLKVGA,  
	  RED => RED,
	  HPOS  => POSH,
     VPOS  => POSV,
	  PBOLAH => PBOLAH,
	  PBOLAV => PBOLAV
	);
Mover_Bola: ENTITY work.MOVBOLA
	PORT MAP(
	  clk   => CLKVGA,  
     RST   => RST,
	  NEW_FRAME => NEW_FRAME,
	  RED  => RED,
	  GREEN => GREEN,
	  BOLADER  => BOLADER,
	  BOLA_ARRIBA => BOLAARR,
	  PUNTAJEDER => PUNTAJEDER,
	  PUNTAJEIZQ => PUNTAJEIZQ,
	  PBOLAH => PBOLAH,
	  PBOLAV  => PBOLAV
	);
	
My_PLL : ENTITY work.vga_CLK_pll
    PORT MAP(
	 INclk0 => CLK,
	 areset => RST,
	 c0     => CLKVGA
	 );
	 
SSEGDISPLAY1 : ENTiTY work.SSEG_DISPLAY 
    PORT MAP(
	 NUMERO => PUNTAJEIZQ,
	 NUMERO_OUT => SSEG2
	 );

SSEGDISPLAY2 : ENTiTY work.SSEG_DISPLAY 
    PORT MAP(
	 NUMERO => PUNTAJEDER,
	 NUMERO_OUT => SSEG1
	 );
end ARCHITECTURE;
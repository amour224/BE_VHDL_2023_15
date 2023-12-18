library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity avalon is
port (
clk, chipselect, write_n, reset_n : in std_logic;
writedata : in std_logic_vector (31 downto 0);
readdata : out std_logic_vector (31 downto 0);
address: in std_logic_vector (1 downto 0);
in_freq: in std_logic);
end entity;


ARCHITECTURE arch_avalon of avalon IS

signal raz_n :  STD_LOGIC;
signal continu, start_stop :  STD_LOGIC;
signal hz :  STD_LOGIC;
signal data_valid : std_logic;
signal data_anemometre : std_logic_vector(7 downto 0);
signal config : std_logic_vector (31 downto 0);



COMPONENT counter2
	PORT(clk_50 : IN STD_LOGIC;
		 in_freq : IN STD_LOGIC;
		 raz_n : IN STD_LOGIC;
		 frq : OUT  integer range 0 to 255
	);
END COMPONENT;

COMPONENT anemo
	PORT(HZ : IN STD_LOGIC;
		 clk_50 : IN STD_LOGIC;
		 continu : IN STD_LOGIC;
		 start_stop : IN STD_LOGIC;
		 raz_n : IN STD_LOGIC;
		 frq : IN  integer range 0 to 255;
		 data_valid : OUT STD_LOGIC;
		 data_anemometre : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT diviseur2
	PORT(clk_50 : IN STD_LOGIC;
		 hz : OUT STD_LOGIC
	);
END COMPONENT;


SIGNAL	SYNTHESIZED_WIRE_0 :   STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :   integer range 0 to 255;


BEGIN 
hz <= SYNTHESIZED_WIRE_0;


b2v_inst : counter2
PORT MAP(clk_50 => clk,
		 in_freq => in_freq,
		 raz_n => raz_n,
		 frq => SYNTHESIZED_WIRE_1);


b2v_inst1 : anemo
PORT MAP(HZ => SYNTHESIZED_WIRE_0,
		 clk_50 => clk,
		 continu => continu,
		 start_stop => start_stop,
		 raz_n => raz_n,
		 frq => SYNTHESIZED_WIRE_1,
		 data_valid => data_valid,
		 data_anemometre => data_anemometre);


b2v_inst2 : diviseur2
PORT MAP(clk_50 => clk,
		 hz => SYNTHESIZED_WIRE_0);

-- écriture registres
process_write: process (clk, reset_n)
	begin
		if reset_n = '0' then
			continu <='0';
			start_stop <='0';
			raz_n <='0';
		elsif clk'event and clk = '1' then
			if chipselect ='1' and write_n = '0' then
				if address = '0' then
					config <= writedata;
					start_stop <= config(2);
					continu <= config(1);
					raz_n <= config(0);
				end if;
				if address = '1' then
					code <= writedata(9 downto 0);
					data_anemometre <= code (7 downto 0);
					data_valid <= code(9);
				end if;
			end if;
		end if;
	end process;

	
-- lecture registres
	process_Read:
	PROCESS(start_stop, data_valid, data_anemometre,raz_n,continu)
		BEGIN
		case address is
		when '0' => readdata <= config;
		when '1' => readdata <="0000000000000000000000" & data_valid & '0' & data_anemometre;
		when others => readdata <= (others => '0');	
		end case;
	END PROCESS process_Read ;
END arch_avalon ;



	
	

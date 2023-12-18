
LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY avalon_anemo IS 
	PORT
	(
		clk_50M :  IN  STD_LOGIC;
		chipselect : in std_logic;
		write_n		: in std_logic;
		reset :  IN  STD_LOGIC;
		freq_in :   IN STD_LOGIC;
		writedata  : in std_logic_vector(31 downto 0);
		
		readdata :   out std_logic_vector(31 downto 0);
		address :   std_logic_vector(1 downto 0)
		
		
		
	);
END avalon_anemo;

ARCHITECTURE bdf_type OF avalon_anemo IS 

signal continu :    STD_LOGIC;
signal		start_stop :    STD_LOGIC;
signal		data_valid :    STD_LOGIC;
signal 		raz_n_tmp : std_logic;
signal		data_anemometre :   STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL   config : std_logic_vector (31 downto 0);


COMPONENT divfreq
	PORT(clk_50M : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 clk_1 : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT count
	PORT(clk_50 : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 freq_in : IN STD_LOGIC;
		 data_freq : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT memory
	PORT(clk_1 : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT gestion_data
	PORT(clk_1 : IN STD_LOGIC;
		 continu : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 start_stop : IN STD_LOGIC;
		 freq_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_valid : OUT STD_LOGIC;
		 data_anemometre : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN 



b2v_inst : divfreq
PORT MAP(clk_50M => clk_50M,
		 reset => reset,
		 clk_1 => SYNTHESIZED_WIRE_4);


b2v_inst1 : count
PORT MAP(clk_50 => clk_50M,
		 rst => reset,
		 freq_in => freq_in,
		 data_freq => SYNTHESIZED_WIRE_1);


b2v_inst2 : memory
PORT MAP(clk_1 => SYNTHESIZED_WIRE_4,
		 rst => reset,
		 data_in => SYNTHESIZED_WIRE_1,
		 data_out => SYNTHESIZED_WIRE_3);


b2v_inst4 : gestion_data
PORT MAP(clk_1 => SYNTHESIZED_WIRE_4,
		 continu => continu,
		 rst => reset,
		 start_stop => start_stop,
		 freq_in => SYNTHESIZED_WIRE_3,
		 data_valid => data_valid,
		 data_anemometre => data_anemometre);
		 
-- écriture registres
process_write: process (clk_50M, reset)
begin
	if reset = '0' then
	elsif clk_50M'event and clk_50M = '1' then
		if chipselect ='1' and write_n = '0' then
			config <= writedata;
			start_stop <= config(2);
			continu <= config(1);
			raz_n_tmp <= config(0);
		end if;
	end if;
end process;


-- lecture registres
process_Read:
PROCESS(data_valid, data_anemometre)
BEGIN
	readdata <= "0000000000000000000000"& data_valid & '0' & data_anemometre;
end process;


END bdf_type;
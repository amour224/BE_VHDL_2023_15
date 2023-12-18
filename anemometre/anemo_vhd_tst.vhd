LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY anemo_vhd_tst IS
END anemo_vhd_tst;


ARCHITECTURE anemo_arch OF anemo_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL continu : STD_LOGIC :='1';
SIGNAL data_anemometre : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL data_valid : STD_LOGIC;
SIGNAL frq : integer range 0 to 255:= 100;
SIGNAL HZ : STD_LOGIC;
SIGNAL start_stop : STD_LOGIC;


COMPONENT anemo
	PORT (
	continu : IN STD_LOGIC;
	data_anemometre : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	data_valid : OUT STD_LOGIC;
	frq : in integer range 0 to 255;
	HZ : IN STD_LOGIC;
	start_stop : IN STD_LOGIC
	);
END COMPONENT;
constant frq_period: time := 1000 ms; --100hz


BEGIN
	i1 : anemo
	PORT MAP (
-- list connections between master ports and signals
	continu => continu,
	data_anemometre => data_anemometre,
	data_valid => data_valid,
	frq => frq,
	HZ => HZ,
	start_stop => start_stop
	);
	
frq_process : process
		begin 
			HZ <= '0';
			wait for frq_period/2;
			HZ <= '1';
			wait for frq_period/2;
		end process;
		
		
stim_proc : process
		begin
			wait for 4000 ms;
			continu <= '0';
			start_stop <= '0';
			frq <= 200;
			wait for 4000 ms;
			start_stop <= '1';
			frq <= 150;
			wait for 4000 ms;
			frq <= 250;
			wait for 4000 ms;
			continu <= '1';
			frq <= 20;
			wait for 4000 ms;
			frq <= 10;
			wait for 4000 ms;
			frq <= 130;
			wait for 4000 ms;
			frq <= 140;
			wait;
		end process;                                      
END anemo_arch;

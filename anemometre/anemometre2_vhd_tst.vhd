LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY anemometre2_vhd_tst IS
END anemometre2_vhd_tst;
ARCHITECTURE anemometre2_arch OF anemometre2_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk_50 : STD_LOGIC;
SIGNAL continu : STD_LOGIC :='1';
SIGNAL data_anemometre : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL data_valid : STD_LOGIC := '0';
SIGNAL in_freq : STD_LOGIC;
SIGNAL raz_n : STD_LOGIC := '1';
SIGNAL start_stop : STD_LOGIC;
SIGNAL hz : STD_LOGIC;

COMPONENT anemometre2
	PORT (
	clk_50 : IN STD_LOGIC;
	in_freq : IN STD_LOGIC;
	hz :  OUT  STD_LOGIC;
	continu : IN STD_LOGIC;
	raz_n : IN STD_LOGIC;
	start_stop : IN STD_LOGIC;
	data_anemometre : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	data_valid : OUT STD_LOGIC
	);
END COMPONENT;

constant frq_period: time := 20 ms; --100hz
constant clk_period: time := 20 ns;


BEGIN
	i1 : anemometre2
	PORT MAP (
-- list connections between master ports and signals
	clk_50 => clk_50,
	continu => continu,
	data_anemometre => data_anemometre,
	data_valid => data_valid,
	in_freq => in_freq,
	raz_n => raz_n,
	start_stop => start_stop,
	hz => hz
	);
	
	
clk_process : process 
		begin 
			clk_50 <= '0';
			wait for clk_period/2;
			clk_50 <= '1';
			wait for clk_period/2;
		end process;
		
frq_process : process
		begin 
			in_freq <= '0';
			wait for frq_period/2;
			in_freq <= '1';
			wait for frq_period/2;
		end process;
		
stim_proc : process
		begin
			wait for 1700 ms;
			raz_n <= '0';
			wait for 100 ms;
			raz_n <= '1';
			continu <= '0';
			start_stop <= '1';
			wait for 2000 ms;
			start_stop <= '0';
			wait for 1600 ms;
			raz_n <= '0';
			wait for 100 ms;
			continu <= '1';
			wait;
		end process;    
--init : PROCESS                                               
---- variable declarations                                     
--BEGIN                                                        
--        -- code that executes only once                      
--WAIT;                                                       
--END PROCESS init;                                           
--always : PROCESS                                              
---- optional sensitivity list                                  
---- (        )                                                 
---- variable declarations                                      
--BEGIN                                                         
--        -- code executes for every event on sensitivity list  
--WAIT;                                                        
--END PROCESS always;                                          
END anemometre2_arch;
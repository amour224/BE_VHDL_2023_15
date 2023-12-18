library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity gestion_anemometre is 

port(
		clk_50M	: in std_logic;
		continu	: in std_logic;
		rst_n		: in std_logic;
		start_stop	: in std_logic;
		data_in_anem : in std_logic_vector(7 downto 0);
		data_valid :  out std_logic;
		data_out_anemometre		: out std_logic_vector(7 downto 0)
		);
end gestion_anemometre;

architecture arch of gestion_anemometre is 
signal	signal_valid : std_logic;
signal  signal_out : std_logic_vector(7 downto 0);

begin

	process(clk_50M,rst_n,continu, start_stop)
	begin
	if rising_edge(clk_50M) then 
		if(rst_n ='0') then
				signal_valid <= '0';
				signal_out <= (others=> '0');
		elsif (continu='1') then
				signal_valid <= '0';
				signal_out <= data_in_anem;
		else 
				if (start_stop ='1') then
					signal_valid <= '0';
					signal_out <= (others=> '0');
				else 
					signal_out <= data_in_anem;
					signal_valid <= '1';
				end if;
		end if;
	end if;
	end process;
	data_valid <= signal_valid;
	data_out_anemometre <= signal_out;
end arch;
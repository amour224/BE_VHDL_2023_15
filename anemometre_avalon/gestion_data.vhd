library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity gestion_data is

port ( 
		clk_1			: in std_logic;
		continu			: in std_logic;
		rst				: in std_logic;
		start_stop		: in std_logic;
		freq_in			: in std_logic_vector(7 downto 0);
		data_valid		: out std_logic;
		data_anemometre : out std_logic_vector(7 downto 0)
		
		);
end entity;

architecture arch of gestion_data is 
signal signal_valid : std_logic;
signal signal_out   : std_logic_vector(7 downto 0);

begin 

		process(clk_1,rst,continu,start_stop)
		
		begin
		if rising_edge(clk_1) then
			if (rst = '0') then
				signal_valid <= '0';
				signal_out <= (others=> '0');
			elsif(continu = '1') then
				signal_valid <= '1';
				signal_out <= freq_in;
			else 
				if(start_stop='1') then
					signal_valid <= '0';
					signal_out <= (others=> '0');
				else 
					signal_out <= freq_in;
					signal_valid <= '1';
				end if;
			end if;
		end if;
	end process;
	data_anemometre <= signal_out;
	data_valid <= signal_valid;
end architecture;
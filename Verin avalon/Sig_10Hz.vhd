library ieee;
Use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity Sig_10Hz is
port (
	raz_n : in std_logic;
	clk_1M : in std_logic;
	start_conv : out std_logic);
end entity Sig_10Hz;


architecture arch_div10 of Sig_10Hz is
signal tmp: std_logic :='0';

begin

process(clk_1M)
	variable count_conv : integer range 0 to 50000;	
	BEGIN
		if raz_n= '0' then
			count_conv:=0;
		elsif clk_1M'event and clk_1M='1' then
			count_conv:= count_conv +1;
			if count_conv =  50000 then
				tmp <= not tmp;
				count_conv:= 0;
			end if;
		end if;	
		
	start_conv <= tmp;
end process;
	
	
end architecture arch_div10;
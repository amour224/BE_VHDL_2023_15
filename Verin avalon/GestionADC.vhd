Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity GestionADC is
	port(
		start_conv : in std_logic;
		cs : in std_logic;
		clk_1M : in std_logic;
		raz_n : in std_logic;
		data_in : in std_logic;
		data_out : out std_logic_vector(11 downto 0)
		);
end GestionADC;

architecture arch_reg_dec of GestionADC is
signal decalage : std_logic_vector(11 downto 0);

begin 

process(clk_1M, raz_n)
variable cnt : integer range 0 to 16;
variable cnt2 : integer range 0 to 16;

begin

if raz_n = '0' then
	data_out <= x"000";
elsif falling_edge(clk_1M) then
	if start_conv ='0' and cs = '0' then
		cnt := cnt + 1;
		cnt2 := cnt2 + 1;
		if cnt >= 5 then
			if cnt2 <= 15 then
				decalage(16- cnt2) <= data_in;
			end if;	
		end if;
	else
		cnt := 0;
		cnt2 := 0;
	end if;
end if;

data_out <= decalage;

end process;

end architecture arch_reg_dec;
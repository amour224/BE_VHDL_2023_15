library ieee;
Use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Sig_1MHz is
port (
	clk_50 : in std_logic;
	raz_n : in std_logic;
	clk_1M : out std_logic);
end entity Sig_1MHz;



architecture arch_div1M of Sig_1MHz is
signal tmp: std_logic :='0';
--signal cnt: integer := 0;

begin

process (clk_50) is
variable cnt: integer := 0;

begin
	if raz_n= '0' then
			cnt:=0;
	elsif rising_edge(clk_50) then
		cnt := cnt + 1 ;
		if cnt = 25  then
			tmp <= not tmp;
			cnt := 0;
		end if;
	end if;
	
	clk_1M <= tmp;

end process;

end architecture arch_div1M;
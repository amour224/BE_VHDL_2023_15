library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity diviseur2 is
    port (
        clk_50M : in std_logic; 
        S_1Hz : out std_logic 
    );
end diviseur2;

architecture arch_1Hz of diviseur2 is
    signal tmp: std_logic := '0'; 
begin
    process (clk_50M) is
        variable cnt: integer := 0;
    begin
        if rising_edge(clk_50M) then 
            cnt := cnt + 1; 
            if cnt = 25000000 then 
                tmp <= not tmp; 
                cnt := 0; 
            end if;
        end if;
        S_1Hz <= tmp; 
    end process;
end arch_1Hz;

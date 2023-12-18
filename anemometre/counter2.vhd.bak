library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter2 is
    port(
        clk_50M : in std_logic; 
        in_freq_anemo : in std_logic; 
        raz_n : in std_logic;   
        frq : out integer range 0 to 255 
    );
end counter2;

architecture arch_counter of counter2 is
    signal compt1 : integer := 0; 
    signal compt2 : integer range 0 to 255 := 0; 
    signal stop : std_logic := '0'; 

begin 
    
    clk : process(clk_50M, raz_n)
    begin
        if raz_n = '0' then
            compt1 <= 0;
        elsif rising_edge(clk_50M) then
            compt1 <= compt1 + 1;
            if compt1 > 50000000 then
                stop <= '1';
                if compt2 = 0 then
                    stop <= '0';
                    compt1 <= 0;
                end if;
            end if;
        end if;
    end process clk;

    -- Processus pour le calcul de fréquence basé sur in_freq
    freq : process(clk_50M, raz_n)
    begin
        if raz_n = '0' then
            compt2 <= 0;
        elsif rising_edge(in_freq_anemo) then
            if stop = '0' then
                compt2 <= compt2 + 1;
            else 
                frq <= compt2;
                compt2 <= 0;
            end if;
        end if;
    end process freq;
end arch_counter;
